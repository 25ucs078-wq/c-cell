import 'package:flutter/material.dart';
import 'supabase_config.dart';
import 'pages/admission_landing_page.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College Admission App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      routes: {
        '/': (_) => const AdmissionLandingPage(),
        '/login': (_) => const LoginPage(),
      },
    );
  }
}
