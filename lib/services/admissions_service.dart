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

  // 3. Verify candidate and bind their Anonymous Firebase UID
  Future<AdmissionCandidate> bindCandidate({
    required String cycleId,
    required String tempId,
    required String jeeAppNo,
    required String dob,
  }) async {
    try {
      final candidateRef = _db
          .collection('admission_cycles')
          .doc(cycleId)
          .collection('candidates')
          .doc(tempId);

      // 1. Fetch the private verification document first.
      // Under firestore.rules, this is allowed for any authenticated user
      // ONLY IF the parent candidate document has candidateUid == "".
      final verificationRef = candidateRef.collection('private').doc('verification');
      DocumentSnapshot<Map<String, dynamic>> verificationSnap;
      try {
        verificationSnap = await verificationRef.get();
      } on FirebaseException catch (e) {
        if (e.code == 'permission-denied') {
          // If permission is denied, it means either:
          // a) The candidate does not exist.
          // b) The candidate is already bound to a UID (so candidateUid == "" is false).
          throw Exception('Verification failed: Candidate ID not found or already bound to a device.');
        }
        rethrow;
      }

      if (!verificationSnap.exists) {
        throw Exception('Verification record missing. Please contact admissions desk.');
      }

      final verData = verificationSnap.data()!;
      final dbJee = verData['jeeAppNo']?.toString().trim();
      final dbDob = verData['dob']?.toString().trim();

      if (dbJee != jeeAppNo.trim() || dbDob != dob.trim()) {
        throw Exception('Incorrect JEE Application Number or Date of Birth.');
      }

      // 2. Bind UID
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Authentication session lost. Please reload the app.');
      }

      // Perform the update. This is allowed under rules because:
      // - The user is authenticated.
      // - The old candidateUid is "".
      // - The new candidateUid matches currentUser.uid.
      await candidateRef.update({
        'candidateUid': currentUser.uid,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // 3. Fetch the candidate data now that the UID is successfully bound!
      // Since candidateUid is now equal to the currentUser's UID,
      // the read rule allows this read!
      final candidateSnap = await candidateRef.get();
      final candidateData = candidateSnap.data();

      return AdmissionCandidate.fromMap(
        {...?candidateData, 'candidateUid': currentUser.uid},
        tempId,
      );
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
