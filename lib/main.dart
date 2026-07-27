import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'screens/auth/auth_wrapper.dart';
import 'screens/auth/google_login_page.dart';
import 'screens/loading/animated_loading_page.dart';
import 'screens/admissions/admissions_timeline_page.dart';
import 'screens/admin/admin_dashboard_page.dart';
import 'screens/home_page.dart';
import 'screens/science_tech/science_tech_page.dart';
import 'screens/science_tech/science_tech_club_detail_page.dart';
import 'screens/cultural/cultural_page.dart';
import 'screens/cultural/cultural_club_detail_page.dart';
import 'screens/sports/sports_page.dart';
import 'screens/sports/sports_club_detail_page.dart';
import 'screens/office_bearers_page.dart';
import 'screens/more_page.dart';
import 'screens/fests/student_fests_page.dart';
import 'screens/councils/councils_page.dart';
import 'screens/fests/vivacity_page.dart';
import 'screens/fests/plinth_page.dart';
import 'screens/fests/desportivos_page.dart';
import 'screens/profile_page.dart';
import 'screens/councils/council_detail_page.dart';
import 'screens/events/events_page.dart';
import 'screens/events/event_detail_page.dart';
import 'screens/curriculum_page.dart';
import 'screens/pdf_viewer_page.dart';
import 'screens/hods_page.dart';
import 'screens/important_contacts_page.dart';
import 'screens/hostel_contacts_page.dart';
import 'screens/important_links_page.dart';
import 'screens/campus_buzz_page.dart';
import 'screens/admin/send_notification_page.dart';
import 'services/fcm_service.dart';
import 'screens/spi_calculator_page.dart';
import 'screens/games/games_page.dart';
import 'screens/games/block_blast_page.dart';
import 'screens/games/flappy_bird_page.dart';
import 'screens/games/fruit_ninja_page.dart';
import 'screens/games/game_2048_page.dart';
import 'screens/games/memory_match_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  try {
    await GoogleSignIn.instance.initialize();
  } catch (e) {
    debugPrint('GoogleSignIn initialization failed: $e');
  }

  try {
    await FcmService().initialize();
  } catch (e) {
    debugPrint('FCM initialization failed: $e');
  }

  if (kDebugMode) {
    // Uncomment these lines to connect to local Firebase Emulators for testing:
    // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    // FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    // FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "C-CELL",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (context) => const AuthWrapper();
            break;
          case '/admissions':
            builder = (context) => const AdmissionsTimelinePage();
            break;
          case '/admin':
            builder = (context) => const AdminDashboardPage();
            break;
          case '/admin/send_notification':
            builder = (context) => const SendNotificationPage();
            break;
          case '/campus_buzz':
            builder = (context) => const CampusBuzzPage();
            break;
          case '/login':
            builder = (context) => const GoogleLoginPage();
            break;
          case '/loading':
            builder = (context) => const AnimatedLoadingPage();
            break;
          case '/home':
            builder = (context) => const HomePage();
            break;
          case '/spi_calculator':
            builder = (context) => const SpiCalculatorPage();
            break;
          case '/science_tech':
            builder = (context) => const ScienceTechPage();
            break;
          case '/cultural':
            builder = (context) => const CulturalPage();
            break;
          case '/sports':
            builder = (context) => const SportsPage();
            break;
          case '/office_bearers':
            builder = (context) => const OfficeBearersPage();
            break;
          case '/hods':
            builder = (context) => const HodsPage();
            break;
          case '/important_contacts':
            builder = (context) => const ImportantContactsPage();
            break;
          case '/hostel_contacts':
            builder = (context) => const HostelContactsPage();
            break;
          case '/important_links':
            builder = (context) => const ImportantLinksPage();
            break;
          case '/curriculum':
            builder = (context) => const CurriculumPage();
            break;
          case '/pdf_viewer':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => PdfViewerPage(
              title: args['title']!,
              pdfPath: args['pdfPath']!,
              imagePath: args['imagePath'],
            );
            break;
          case '/more':
            builder = (context) => const MorePage();
            break;
          case '/student_fests':
            builder = (context) => const StudentFestsPage();
            break;
          case '/councils':
            builder = (context) => const CouncilsPage();
            break;
          case '/vivacity':
            builder = (context) => const VivacityPage();
            break;
          case '/plinth':
            builder = (context) => const PlinthPage();
            break;
          case '/desportivos':
            builder = (context) => const DesportivosPage();
            break;
          case '/profile':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => ProfilePage(
              name: args['name']!,
              image: args['image']!,
              role: args['role']!,
              phone: args['phone'] ?? '',
              email: args['email'] ?? '',
              instagram: args['instagram'] ?? '',
              linkedin: args['linkedin'] ?? '',
            );
            break;
          case '/science_tech_detail':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => ScienceTechClubDetailPage(
              clubName: args['clubName']!,
              clubImage: args['clubImage']!,
              coordinators: args['coordinators']!,
              galleryImages: args['galleryImages']!,
              description: args['description']!,
              instagram: args['instagram'] ?? '',
              email: args['email'] ?? '',
            );
            break;
          case '/sports_detail':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => SportsClubDetailPage(
              clubName: args['clubName']!,
              clubImage: args['clubImage']!,
              coordinators: args['coordinators']!,
              galleryImages: args['galleryImages']!,
              description: args['description']!,
              instagram: args['instagram'] ?? '',
              email: args['email'] ?? '',
            );
            break;
          case '/cultural_detail':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => CulturalClubDetailPage(
              clubName: args['clubName']!,
              clubImage: args['clubImage']!,
              coordinators: args['coordinators']!,
              galleryImages: args['galleryImages']!,
              description: args['description']!,
              instagram: args['instagram'] ?? '',
              email: args['email'] ?? '',
            );
            break;
          case '/council_detail':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => CouncilDetailPage(
              councilName: args['councilName']!,
              items: args['items']!,
              councilImage: args['councilImage'] ?? 'assets/assets/images/gymkhana.jpg',
            );
            break;
          case '/events':
            builder = (context) => const EventsPage();
            break;
          case '/event_detail':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => EventDetailPage(
              eventName: args['eventName']!,
              eventImage: args['eventImage']!,
              coordinators: args['coordinators']!,
              galleryImages: args['galleryImages']!,
              description: args['description']!,
              instagram: args['instagram'] ?? '',
              email: args['email'] ?? '',
              youtube: args['youtube'] ?? '',
              website: args['website'] ?? '',
            );
            break;
          case '/games':
            builder = (context) => const GamesPage();
            break;
          case '/block_blast':
            builder = (context) => const BlockBlastPage();
            break;
          case '/flappy_bird':
            builder = (context) => const FlappyBirdPage();
            break;
          case '/fruit_ninja':
            builder = (context) => const FruitNinjaPage();
            break;
          case '/game_2048':
            builder = (context) => const Game2048Page();
            break;
          case '/memory_match':
            builder = (context) => const MemoryMatchPage();
            break;
          default:
            builder = (context) => const HomePage();
        }

        return PageRouteBuilder(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
            final slideAnimation = Tween(begin: const Offset(0, 0.15), end: Offset.zero)
                .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(position: slideAnimation, child: child),
            );
          },
        );
      },
    );
  }
}
