class AdmissionCandidate {
  final String id;
  final String tempId;
  final String fullName;
  final bool approved;
  final String? rollNo;
  final String? collegeEmail;

  AdmissionCandidate({
    required this.id,
    required this.tempId,
    required this.fullName,
    required this.approved,
    this.rollNo,
    this.collegeEmail,
  });

  factory AdmissionCandidate.fromMap(Map<String, dynamic> map) {
    return AdmissionCandidate(
      id: map['id'],
      tempId: map['temp_id'],
      fullName: map['full_name'],
      approved: map['approved'] ?? false,
      rollNo: map['roll_no'],
      collegeEmail: map['college_email'],
    );
  }
}

class ChecklistStage {
  final String id;
  final String title;
  final String department;
  final String roomNo;
  final String instructions;
  final int stageOrder;
  final String adminCode;

  ChecklistStage({
    required this.id,
    required this.title,
    required this.department,
    required this.roomNo,
    required this.instructions,
    required this.stageOrder,
    required this.adminCode,
  });

  factory ChecklistStage.fromMap(Map<String, dynamic> map) {
    return ChecklistStage(
      id: map['id'],
      title: map['title'],
      department: map['department'],
      roomNo: map['room_no'],
      instructions: map['instructions'],
      stageOrder: map['stage_order'],
      adminCode: map['admin_code'],
    );
  }
}