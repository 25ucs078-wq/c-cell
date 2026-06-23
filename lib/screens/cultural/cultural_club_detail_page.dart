import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../profile_page.dart';

class CulturalClubDetailPage extends StatelessWidget {
  final String clubName;
  final String clubImage;

  const CulturalClubDetailPage({super.key, required this.clubName, required this.clubImage});

  static const List<Map<String, String>> coordinators = [
    {
      'name': 'Ananya Sharma',
      'role': 'Club Coordinator',
      'image': 'assets/images/logo.jpeg',
    },
    {
      'name': 'Rohan Mehta',
      'role': 'Co-Coordinator',
      'image': 'assets/images/logo.jpeg',
    },
  ];

  static const List<String> galleryImages = [
    'assets/images/hero_new.jpeg',
    'assets/images/team_poster.jpeg',
    'assets/images/photowalk.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050816),
        elevation: 0,
        centerTitle: true,
        title: Text(
          clubName.toUpperCase(),
          style: GoogleFonts.playfairDisplay(
            color: Colors.redAccent,
            fontSize: 38,
            letterSpacing: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  clubImage,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'COORDINATORS',
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 32,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: coordinators.length,
                  itemBuilder: (context, index) {
                    final person = coordinators[index];
                    return _buildCoordinatorCard(
                      context,
                      person['name']!,
                      person['role']!,
                      person['image']!,
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'PHOTO GALLERY',
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: galleryImages.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return _buildGalleryImage(galleryImages[index]);
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoordinatorCard(BuildContext context, String name, String role, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (context, animation, secondaryAnimation) {
              return ProfilePage(name: name, image: image, role: role);
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
              final slideAnimation = Tween(begin: const Offset(0, 0.15), end: Offset.zero)
                  .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
              return FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(position: slideAnimation, child: child),
              );
            },
          ),
        );
      },
      child: Container(
        width: 210,
        margin: const EdgeInsets.only(right: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Hero(
              tag: name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  image,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    role,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFB20710),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  'VIEW PROFILE',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        image,
        width: 220,
        height: 140,
        fit: BoxFit.cover,
      ),
    );
  }
}
