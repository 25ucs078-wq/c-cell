import 'package:cloud_firestore/cloud_firestore.dart';

class CampusBuzzNotification {
  final String id;
  final String title;
  final String message;
  final String senderEmail;
  final DateTime? timestamp;

  CampusBuzzNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.senderEmail,
    this.timestamp,
  });

  factory CampusBuzzNotification.fromMap(Map<String, dynamic> map, String docId) {
    DateTime? parsedTimestamp;
    final rawTimestamp = map['timestamp'];

    if (rawTimestamp is Timestamp) {
      parsedTimestamp = rawTimestamp.toDate();
    } else if (rawTimestamp is String) {
      parsedTimestamp = DateTime.tryParse(rawTimestamp);
    }

    return CampusBuzzNotification(
      id: docId,
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      senderEmail: map['senderEmail'] ?? '',
      timestamp: parsedTimestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'senderEmail': senderEmail,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }
}
