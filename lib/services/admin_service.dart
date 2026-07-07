import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/admission_candidate_model.dart';
import '../models/admission_stage_model.dart';

class AdminService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Audit Logging for Administrative Actions
  Future<void> logAdminAction(String actionType, Map<String, dynamic> details) async {
    try {
      final user = _auth.currentUser;
      await _db.collection('admin_audit_logs').add({
        'actionType': actionType,
        'performedBy': user?.uid ?? 'unknown',
        'performedAt': FieldValue.serverTimestamp(),
        'details': details,
      });
    } catch (e) {
      debugPrint('Error writing admin audit log: $e');
    }
  }

  // 2. Update Global App Configurations (Cycle & Maintenance Settings)
  Future<void> updateAppConfig(Map<String, dynamic> data) async {
    try {
      await _db.collection('configs').doc('app_config').set(data, SetOptions(merge: true));
      await logAdminAction('UPDATE_APP_CONFIG', data);
    } catch (e) {
      debugPrint('Error updating app config: $e');
      rethrow;
    }
  }

  // 3. Stage Configuration CRUD Operations
  Future<void> saveStage(String cycleId, AdmissionStage stage) async {
    try {
      await _db
          .collection('admission_cycles')
          .doc(cycleId)
          .collection('stages')
          .doc(stage.id)
          .set(stage.toMap());
      
      await logAdminAction('SAVE_STAGE', {
        'cycleId': cycleId,
        'stageId': stage.id,
        'title': stage.title,
      });
    } catch (e) {
      debugPrint('Error saving stage: $e');
      rethrow;
    }
  }

  Future<void> deleteStage(String cycleId, String stageId) async {
    try {
      await _db
          .collection('admission_cycles')
          .doc(cycleId)
          .collection('stages')
          .doc(stageId)
          .delete();
      
      await logAdminAction('DELETE_STAGE', {
        'cycleId': cycleId,
        'stageId': stageId,
      });
    } catch (e) {
      debugPrint('Error deleting stage: $e');
      rethrow;
    }
  }

  // 4. Role-Based Access Assignment (Staff & Admin Manager)
  Future<void> assignStaffRole(String uid, String email, String role) async {
    try {
      await _db.collection('users').doc(uid).set({
        'email': email,
        'role': role,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      await logAdminAction('ASSIGN_STAFF_ROLE', {
        'targetUid': uid,
        'email': email,
        'role': role,
      });
    } catch (e) {
      debugPrint('Error assigning staff role: $e');
      rethrow;
    }
  }

  // 5. Bulk Candidate CSV Importing
  Future<int> importCandidatesCsv(String cycleId, String csvContent) async {
    try {
      final lines = csvContent.split('\n');
      int importCount = 0;
      
      // Expected header: tempId, fullName, branch, jeeAppNo, dob
      for (var line in lines) {
        if (line.trim().isEmpty) continue;
        final cols = line.split(',');
        if (cols.length < 5) continue;
        
        final tempId = cols[0].trim();
        final fullName = cols[1].trim();
        final branch = cols[2].trim();
        final jeeAppNo = cols[3].trim();
        final dob = cols[4].trim(); // YYYY-MM-DD
        
        // Skip header line
        if (tempId.toLowerCase() == 'tempid' || tempId.startsWith('#')) continue;
        
        final candidateRef = _db
            .collection('admission_cycles')
            .doc(cycleId)
            .collection('candidates')
            .doc(tempId);
            
        // 1. Create main profile document
        await candidateRef.set({
          'fullName': fullName,
          'branch': branch,
          'approved': false,
          'candidateUid': '',
          'officialEmail': '',
          'completedStageIds': [],
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        // 2. Create private verification data document
        await candidateRef.collection('private').doc('verification').set({
          'jeeAppNo': jeeAppNo,
          'dob': dob,
        });
        
        importCount++;
      }
      
      await logAdminAction('BULK_IMPORT_CANDIDATES', {
        'cycleId': cycleId,
        'count': importCount,
      });
      
      return importCount;
    } catch (e) {
      debugPrint('Error bulk importing candidates: $e');
      rethrow;
    }
  }

  // 6. Allocate Official College Email Account
  Future<void> allocateOfficialEmail(String cycleId, String tempId, String email) async {
    try {
      await _db
          .collection('admission_cycles')
          .doc(cycleId)
          .collection('candidates')
          .doc(tempId)
          .update({
        'officialEmail': email,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      await logAdminAction('ALLOCATE_OFFICIAL_EMAIL', {
        'cycleId': cycleId,
        'tempId': tempId,
        'email': email,
      });
    } catch (e) {
      debugPrint('Error allocating official email: $e');
      rethrow;
    }
  }

  // 7. Stream all candidates for real-time dashboard calculations
  Stream<List<AdmissionCandidate>> streamAllCandidates(String cycleId) {
    return _db
        .collection('admission_cycles')
        .doc(cycleId)
        .collection('candidates')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => AdmissionCandidate.fromMap(doc.data(), doc.id))
            .toList());
  }

  // 8. Stream recent audit logs
  Stream<QuerySnapshot> streamAdminLogs() {
    return _db
        .collection('admin_audit_logs')
        .orderBy('performedAt', descending: true)
        .limit(40)
        .snapshots();
  }
}
