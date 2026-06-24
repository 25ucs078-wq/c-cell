import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/science_tech/science_tech_page.dart';
import 'screens/science_tech/science_tech_club_detail_page.dart';
import 'screens/cultural/cultural_page.dart';
import 'screens/cultural/cultural_club_detail_page.dart';
import 'screens/sports/sports_page.dart';
import 'screens/sports/sports_club_detail_page.dart';
import 'screens/office_bearers_page.dart';
import 'screens/more_page.dart';
import 'screens/student_fests_page.dart';
import 'screens/councils_page.dart';
import 'screens/vivacity_page.dart';
import 'screens/plinth_page.dart';
import 'screens/desportivos_page.dart';
import 'screens/profile_page.dart';
import 'screens/council_detail_page.dart';

void main() {
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
            builder = (context) => const HomePage();
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
            );
            break;
          case '/science_tech_detail':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => ScienceTechClubDetailPage(
              clubName: args['clubName']!,
              clubImage: args['clubImage']!,
              coordinators: args['coordinators']!,
              galleryImages: args['galleryImages']!,
            );
            break;
          case '/sports_detail':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => SportsClubDetailPage(
              clubName: args['clubName']!,
              clubImage: args['clubImage']!,
              coordinators: args['coordinators']!,
              galleryImages: args['galleryImages']!,
            );
            break;
          case '/cultural_detail':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => CulturalClubDetailPage(
              clubName: args['clubName']!,
              clubImage: args['clubImage']!,
              coordinators: args['coordinators']!,
              galleryImages: args['galleryImages']!,
            );
            break;
          case '/council_detail':
            final args = settings.arguments as Map<String, dynamic>;
            builder = (context) => CouncilDetailPage(
              councilName: args['councilName']!,
              items: args['items']!,
            );
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
