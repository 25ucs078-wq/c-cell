import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/admission_models.dart';
import '../supabase_config.dart';

class AdmissionService {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<AdmissionCandidate?> getCandidateByTempId(String tempId) async {
    final res = await _client
        .from('admission_candidates')
        .select()
        .eq('temp_id', tempId)
        .maybeSingle();

    if (res == null) return null;
    return AdmissionCandidate.fromMap(res);
  }

  Future<AdmissionCandidate> createCandidateFromTempId(String tempId) async {
    final res = await _client.from('admission_candidates').insert({
      'temp_id': tempId,
      'full_name': 'Pending Name',
      'approved': false,
    }).select().single();

    return AdmissionCandidate.fromMap(res);
  }

  Future<List<ChecklistStage>> getStages() async {
    final res = await _client
        .from('checklist_stages')
        .select()
        .order('stage_order');

    return (res as List).map((e) => ChecklistStage.fromMap(e)).toList();
  }

  Future<List<String>> getCompletedStageIds(String candidateId) async {
    final res = await _client
        .from('stage_logs')
        .select('stage_id')
        .eq('candidate_id', candidateId);

    return (res as List).map((e) => e['stage_id'] as String).toList();
  }

  Future<void> markStageComplete({
    required String candidateId,
    required String stageId,
    required String staffCode,
  }) async {
    await _client.from('stage_logs').insert({
      'candidate_id': candidateId,
      'stage_id': stageId,
      'staff_code': staffCode,
      'completed_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> approveCandidate(String candidateId) async {
    await _client.from('admission_candidates').update({
      'approved': true,
    }).eq('id', candidateId);
  }
}