import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:c_cell_app/screens/auth/google_login_page.dart';
import 'package:c_cell_app/screens/admissions/admissions_timeline_page.dart';
import 'package:c_cell_app/services/auth_service.dart';
import 'package:c_cell_app/services/admissions_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Mock implementations utilizing noSuchMethod for dynamic interface compliance

class MockAuthService implements AuthService {
  final Future<User?> Function()? onSignInWithGoogle;

  MockAuthService({this.onSignInWithGoogle});

  @override
  Stream<User?> get authStateChanges => const Stream.empty();

  @override
  Future<User?> signInWithGoogle() async {
    if (onSignInWithGoogle != null) {
      return onSignInWithGoogle!();
    }
    return null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }
}

class MockAdmissionsService implements AdmissionsService {
  final Future<Map<String, dynamic>?> Function()? onGetAppConfig;
  final Future<User?> Function()? onEnsureAuthenticated;
  final Future<String?> Function(String)? onGetBoundTempId;

  MockAdmissionsService({
    this.onGetAppConfig,
    this.onEnsureAuthenticated,
    this.onGetBoundTempId,
  });

  @override
  Future<Map<String, dynamic>?> getAppConfig() async {
    if (onGetAppConfig != null) {
      return onGetAppConfig!();
    }
    return {'activeAdmissionCycle': '2026'};
  }

  @override
  Future<User?> ensureAuthenticated() async {
    if (onEnsureAuthenticated != null) {
      return onEnsureAuthenticated!();
    }
    return null;
  }

  @override
  Future<String?> getBoundTempId(String cycleId) async {
    if (onGetBoundTempId != null) {
      return onGetBoundTempId!(cycleId);
    }
    return null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }
}

void main() {
  testWidgets('1. Google Sign-In failure displays the raw detailed exception', (WidgetTester tester) async {
    // Set screen size to prevent fake overflow errors on small test viewports
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final mockAuth = MockAuthService(
      onSignInWithGoogle: () async {
        throw PlatformException(code: '10', message: 'DEVELOPER_ERROR');
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: GoogleLoginPage(authService: mockAuth),
      ),
    );

    // Tap Google sign-in button
    final googleBtn = find.text('Continue with Google');
    expect(googleBtn, findsOneWidget);
    await tester.tap(googleBtn);
    await tester.pumpAndSettle();

    // Verify error banner is shown with raw error code details
    expect(find.textContaining('Platform error [10]: DEVELOPER_ERROR'), findsOneWidget);
  });

  testWidgets('2. Admissions Bootstrap missing configs displays a friendly setup instruction', (WidgetTester tester) async {
    // Set screen size to prevent fake overflow errors on small test viewports
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final mockAdmissions = MockAdmissionsService(
      onGetAppConfig: () async => null, // Document is absent in Firestore
    );

    await tester.pumpWidget(
      MaterialApp(
        home: AdmissionsTimelinePage(admissionsService: mockAdmissions),
      ),
    );

    await tester.pumpAndSettle();

    // Verify setup warning message is displayed instead of Bootstrap Error crash
    expect(
      find.textContaining('Admissions system is not yet configured. Please create the app configuration (configs/app_config) document.'),
      findsOneWidget,
    );
  });

  testWidgets('3. Admissions Bootstrap network unavailable shows explicit connection warning', (WidgetTester tester) async {
    // Set screen size to prevent fake overflow errors on small test viewports
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final mockAdmissions = MockAdmissionsService(
      onGetAppConfig: () async {
        throw FirebaseException(
          plugin: 'firestore',
          code: 'unavailable',
          message: 'Failed to get document because the client is offline.',
        );
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: AdmissionsTimelinePage(admissionsService: mockAdmissions),
      ),
    );

    await tester.pumpAndSettle();

    // Verify clear network connection message is displayed
    expect(
      find.textContaining('Network Connection Error: Unable to reach Firebase Firestore. Please check your internet connection or emulator settings.'),
      findsOneWidget,
    );
  });

  testWidgets('4. Admissions successful bootstrap loads the Verification Form screen', (WidgetTester tester) async {
    // Set screen size to prevent fake overflow errors on small test viewports
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final mockAdmissions = MockAdmissionsService(
      onGetAppConfig: () async => {'activeAdmissionCycle': '2026'},
      onEnsureAuthenticated: () async => null, // successful anonymous auth
    );

    await tester.pumpWidget(
      MaterialApp(
        home: AdmissionsTimelinePage(admissionsService: mockAdmissions),
      ),
    );

    await tester.pumpAndSettle();

    // Verify Candidate ID Verification form elements load successfully
    expect(find.text('Verify Candidate ID'), findsOneWidget);
    expect(find.text('Temporary ID'), findsOneWidget);
    expect(find.text('JEE Application Number'), findsOneWidget);
    expect(find.text('Date of Birth (YYYY-MM-DD)'), findsOneWidget);
  });
}
