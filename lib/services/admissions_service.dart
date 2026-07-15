import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/admission_candidate_model.dart';
import '../models/admission_stage_model.dart';

class AdmissionsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Fetch active admission cycle and app configurations
  Future<Map<String, dynamic>?> getAppConfig() async {
    try {
      final doc = await _db.collection('configs').doc('app_config').get();
      return doc.data();
    } catch (e) {
      debugPrint('Error fetching app config: $e');
      rethrow;
    }
  }

  // 2. Ensure user is authenticated (signs in anonymously if no session exists)
  Future<User?> ensureAuthenticated() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        final credential = await _auth.signInAnonymously();
        user = credential.user;
        debugPrint('Signed in anonymously with UID: ${user?.uid}');
      }
      return user;
    } catch (e) {
      debugPrint('Error signing in anonymously: $e');
      rethrow;
    }
  }

  // 3. Register or bind a candidate's session with their Anonymous Firebase UID
  Future<AdmissionCandidate> bindCandidate({
    required String cycleId,
    required String appNo,
  }) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Authentication session lost. Please reload the app.');
      }

      final candidateRef = _db
          .collection('admission_cycles')
          .doc(cycleId)
          .collection('candidates')
          .doc(appNo);

      final candidateSnap = await candidateRef.get();

      if (!candidateSnap.exists) {
        // Create a new candidate session document dynamically (manual verification happens at physical desks)
        final newCandidateData = {
          'candidateUid': currentUser.uid,
          'fullName': 'Fresher',
          'branch': 'Candidate',
          'completedStageIds': [],
          'approved': false,
          'updatedAt': FieldValue.serverTimestamp(),
        };
        await candidateRef.set(newCandidateData);
        return AdmissionCandidate.fromMap(newCandidateData, appNo);
      } else {
        // Document exists, check UID association
        final data = candidateSnap.data()!;
        final String existingUid = data['candidateUid'] ?? '';

        if (existingUid == '') {
          // Bind the anonymous UID to the existing record
          await candidateRef.update({
            'candidateUid': currentUser.uid,
            'updatedAt': FieldValue.serverTimestamp(),
          });
          final updatedData = Map<String, dynamic>.from(data);
          updatedData['candidateUid'] = currentUser.uid;
          return AdmissionCandidate.fromMap(updatedData, appNo);
        } else if (existingUid == currentUser.uid) {
          // Already bound to this device/session
          return AdmissionCandidate.fromMap(data, appNo);
        } else {
          // Bound to a different UID (prevent duplicate claims on different devices)
          throw Exception('This Application Number is already registered on another device.');
        }
      }
    } catch (e) {
      debugPrint('Error binding candidate: $e');
      rethrow;
    }
  }

  // 4. Stream Candidate Document in real-time
  Stream<AdmissionCandidate?> streamCandidate(String cycleId, String tempId) {
    return _db
        .collection('admission_cycles')
        .doc(cycleId)
        .collection('candidates')
        .doc(tempId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return AdmissionCandidate.fromMap(doc.data()!, doc.id);
    });
  }

  // 5. Stream active stages list
  Stream<List<AdmissionStage>> streamStages(String cycleId) {
    return _db
        .collection('admission_cycles')
        .doc(cycleId)
        .collection('stages')
        .where('isEnabled', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      final list = snapshot.docs
          .map((doc) => AdmissionStage.fromMap(doc.data(), doc.id))
          .toList();
      // Sort by stageOrder locally or query order (orderBy requires indexes, sorting locally is safe and immediate)
      list.sort((a, b) => a.stageOrder.compareTo(b.stageOrder));
      return list;
    });
  }

  // 6. Stream candidate's completed stage IDs
  Stream<Set<String>> streamCompletedStages(String cycleId, String tempId) {
    return _db
        .collection('admission_cycles')
        .doc(cycleId)
        .collection('candidates')
        .doc(tempId)
        .collection('stage_logs')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.id).toSet();
    });
  }

  // 7. Firebase Account Linking (Upgrades anonymous account to official Google account)
  Future<User?> linkOfficialAccount(AuthCredential credential) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No active session to upgrade.');
      }
      final userCredential = await user.linkWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      debugPrint('Error linking Google account: $e');
      rethrow;
    }
  }

  // 8. Fallback Check: Bind Google Account UID if logged in on a new device
  Future<void> bindGoogleAccountIfMatched(String cycleId, User user) async {
    try {
      if (user.email == null) return;
      
      final candidatesQuery = await _db
          .collection('admission_cycles')
          .doc(cycleId)
          .collection('candidates')
          .where('officialEmail', isEqualTo: user.email)
          .limit(1)
          .get();

      if (candidatesQuery.docs.isNotEmpty) {
        final doc = candidatesQuery.docs.first;
        final currentUid = doc.data()['candidateUid'];
        
        if (currentUid != user.uid) {
          await doc.reference.update({
            'candidateUid': user.uid,
            'updatedAt': FieldValue.serverTimestamp(),
          });
          debugPrint('Successfully matched and bound official Google UID to candidate record.');
        }
      }
    } catch (e) {
      debugPrint('Error during official account UID fallback check: $e');
      // Do not rethrow; fallback is supplementary to primary account linking
    }
  }

  // 9. Find bound candidate tempId for the current session
  Future<String?> getBoundTempId(String cycleId) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) return null;

      final query = await _db
          .collection('admission_cycles')
          .doc(cycleId)
          .collection('candidates')
          .where('candidateUid', isEqualTo: currentUser.uid)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        return query.docs.first.id;
      }
      return null;
    } catch (e) {
      debugPrint('Error getting bound tempId: $e');
      return null;
    }
  }

  // 10. Officer Verification: Verify stage inside a secure transaction
  Future<void> verifyCandidateStage({
    required String cycleId,
    required String tempId,
    required String stageId,
    required String staffUid,
    required List<String> allEnabledStageIds,
  }) async {
    final candidateRef = _db
        .collection('admission_cycles')
        .doc(cycleId)
        .collection('candidates')
        .doc(tempId);
    
    final logRef = candidateRef.collection('stage_logs').doc(stageId);

    try {
      await _db.runTransaction((transaction) async {
        final candidateSnap = await transaction.get(candidateRef);
        if (!candidateSnap.exists) {
          throw Exception('Candidate not found.');
        }

        final data = candidateSnap.data()!;
        final List<String> currentStages = List<String>.from(data['completedStageIds'] ?? []);
        
        if (!currentStages.contains(stageId)) {
          currentStages.add(stageId);
        }

        final bool isAllCompleted = allEnabledStageIds.every((id) => currentStages.contains(id));

        transaction.update(candidateRef, {
          'completedStageIds': currentStages,
          'approved': isAllCompleted,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        transaction.set(logRef, {
          'stageId': stageId,
          'verifiedBy': staffUid,
          'completedAt': FieldValue.serverTimestamp(),
        });
      });
    } catch (e) {
      debugPrint('Error verifying candidate stage: $e');
      rethrow;
    }
  }

  // 11. Verify stage passcode locally via client-side transaction evaluated securely under firestore.rules
  Future<void> verifyStageViaPasscode({
    required String cycleId,
    required String tempId,
    required String stageId,
    required String passcode,
    required List<String> currentCompletedStageIds,
    required List<String> allEnabledStageIds,
  }) async {
    try {
      final candidateRef = _db
          .collection('admission_cycles')
          .doc(cycleId)
          .collection('candidates')
          .doc(tempId);
      
      final logRef = candidateRef.collection('stage_logs').doc(stageId);

      // Compute the SHA-256 hash of the entered passcode locally
      final bytes = utf8.encode(passcode.trim());
      final hash = sha256.convert(bytes).toString();

      // Prepare updated completedStageIds and approved flags
      final List<String> updatedStages = List<String>.from(currentCompletedStageIds);
      if (!updatedStages.contains(stageId)) {
        updatedStages.add(stageId);
      }
      final bool isAllCompleted = allEnabledStageIds.every((id) => updatedStages.contains(id));

      final batch = _db.batch();

      // 1. Create the stage log document (security rules verify passcodeHash against stage config bypassCodeHash)
      batch.set(logRef, {
        'stageId': stageId,
        'verifiedBy': 'desk_officer',
        'passcodeHash': hash,
        'completedAt': FieldValue.serverTimestamp(),
      });

      // 2. Update the candidate document (security rules permit owner candidate UIDs to update progress tracking fields)
      batch.update(candidateRef, {
        'completedStageIds': updatedStages,
        'approved': isAllCompleted,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await batch.commit();
      debugPrint('Successfully verified stage $stageId entirely via secure Firestore rules.');
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw Exception('Incorrect desk verification code.');
      }
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error during passcode verification: $e');
      throw Exception('An unexpected verification error occurred.');
    }
  }
}
