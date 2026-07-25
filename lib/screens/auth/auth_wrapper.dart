import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import '../home_page.dart';
import 'google_login_page.dart';

import '../../services/fcm_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // If snapshot connection is active, wait for session state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF050816),
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ),
          );
        }

        // If user is already authenticated and has a valid session
        if (snapshot.hasData && snapshot.data != null) {
          FcmService().subscribeToCampusBuzzTopic();
          return const HomePage();
        }

        // Fallback: not logged in, redirect to Google Login Page
        return const GoogleLoginPage();
      },
    );
  }
}
