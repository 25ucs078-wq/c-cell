import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:c_cell_app/models/notification_model.dart';

void main() {
  group('CampusBuzzNotification Model Tests', () {
    test('Correctly parses valid map with Timestamp', () {
      final now = DateTime.now();
      final map = {
        'title': 'Test Title',
        'message': 'Test Message',
        'senderEmail': 'c-cell@lnmiit.ac.in',
        'timestamp': Timestamp.fromDate(now),
      };

      final notification = CampusBuzzNotification.fromMap(map, 'doc_123');

      expect(notification.id, 'doc_123');
      expect(notification.title, 'Test Title');
      expect(notification.message, 'Test Message');
      expect(notification.senderEmail, 'c-cell@lnmiit.ac.in');
      expect(notification.timestamp, isNotNull);
    });

    test('Safely handles null timestamp (pending serverTimestamp resolution)', () {
      final map = {
        'title': 'Pending Title',
        'message': 'Pending Message',
        'senderEmail': 'c-cell@lnmiit.ac.in',
        'timestamp': null,
      };

      final notification = CampusBuzzNotification.fromMap(map, 'doc_456');

      expect(notification.id, 'doc_456');
      expect(notification.title, 'Pending Title');
      expect(notification.timestamp, isNull);
    });

    test('toMap converts notification back to Map', () {
      final notification = CampusBuzzNotification(
        id: 'doc_789',
        title: 'Title',
        message: 'Message',
        senderEmail: 'c-cell@lnmiit.ac.in',
        timestamp: DateTime(2026, 7, 25, 12, 0),
      );

      final map = notification.toMap();

      expect(map['title'], 'Title');
      expect(map['message'], 'Message');
      expect(map['senderEmail'], 'c-cell@lnmiit.ac.in');
      expect(map['timestamp'], isA<Timestamp>());
    });
  });
}
