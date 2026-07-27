import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    debugPrint('FCM Background Message Received: ${message.messageId}');
  }
}

class FcmService {
  static final FcmService _instance = FcmService._internal();
  factory FcmService() => _instance;
  FcmService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _isInitialized = false;

  /// Initializes FCM listeners, permissions, and topic subscriptions
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 1. Request Notification Permissions
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        debugPrint('FCM Notification permission status: ${settings.authorizationStatus}');
      }

      // 2. Set Background Message Handler
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // 3. Foreground Message Listener
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          debugPrint('FCM Foreground Message: ${message.notification?.title} - ${message.notification?.body}');
        }
      });

      // 4. Automatic Subscription to 'campus_buzz' topic
      await subscribeToCampusBuzzTopic();

      _isInitialized = true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('FcmService initialization error: $e');
      }
    }
  }

  /// Subscribes current device to 'campus_buzz' FCM topic
  Future<void> subscribeToCampusBuzzTopic() async {
    try {
      await _messaging.subscribeToTopic('campus_buzz');
      if (kDebugMode) {
        debugPrint('Subscribed to FCM topic: campus_buzz');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error subscribing to campus_buzz topic: $e');
      }
    }
  }

  /// Unsubscribes device from 'campus_buzz' topic
  Future<void> unsubscribeFromCampusBuzzTopic() async {
    try {
      await _messaging.unsubscribeFromTopic('campus_buzz');
      if (kDebugMode) {
        debugPrint('Unsubscribed from FCM topic: campus_buzz');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error unsubscribing from campus_buzz topic: $e');
      }
    }
  }
}
