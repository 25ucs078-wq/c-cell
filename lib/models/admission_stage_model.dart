class AdmissionStage {
  final String id;
  final String title;
  final String department;
  final String roomNo;
  final String instructions;
  final int stageOrder;
  final bool isEnabled;
  final String assignedRole;

  AdmissionStage({
    required this.id,
    required this.title,
    required this.department,
    required this.roomNo,
    required this.instructions,
    required this.stageOrder,
    required this.isEnabled,
    required this.assignedRole,
  });

  factory AdmissionStage.fromMap(Map<String, dynamic> map, String docId) {
    return AdmissionStage(
      id: docId,
      title: map['title'] ?? '',
      department: map['department'] ?? '',
      roomNo: map['roomNo'] ?? '',
      instructions: map['instructions'] ?? '',
      stageOrder: map['stageOrder'] ?? 0,
      isEnabled: map['isEnabled'] ?? true,
      assignedRole: map['assignedRole'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'department': department,
      'roomNo': roomNo,
      'instructions': instructions,
      'stageOrder': stageOrder,
      'isEnabled': isEnabled,
      'assignedRole': assignedRole,
    };
  }
}
