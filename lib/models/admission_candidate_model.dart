class AdmissionCandidate {
  final String tempId;
  final String fullName;
  final String branch;
  final bool approved;
  final String candidateUid;
  final String officialEmail;
  final List<String> completedStageIds;

  AdmissionCandidate({
    required this.tempId,
    required this.fullName,
    required this.branch,
    required this.approved,
    required this.candidateUid,
    required this.officialEmail,
    required this.completedStageIds,
  });

  factory AdmissionCandidate.fromMap(Map<String, dynamic> map, String docId) {
    return AdmissionCandidate(
      tempId: docId,
      fullName: map['fullName'] ?? '',
      branch: map['branch'] ?? '',
      approved: map['approved'] ?? false,
      candidateUid: map['candidateUid'] ?? '',
      officialEmail: map['officialEmail'] ?? '',
      completedStageIds: List<String>.from(map['completedStageIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'branch': branch,
      'approved': approved,
      'candidateUid': candidateUid,
      'officialEmail': officialEmail,
      'completedStageIds': completedStageIds,
    };
  }

  bool isStageCompleted(String stageId) => completedStageIds.contains(stageId);
}
