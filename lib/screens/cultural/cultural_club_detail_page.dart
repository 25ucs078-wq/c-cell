import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
      'phone': '',
      'email': '',
    },
    {
      'name': 'Rohan Mehta',
      'role': 'Co-Coordinator',
      'image': 'assets/images/logo.jpeg',
      'phone': '',
      'email': '',
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
                      person['phone'] ?? '',
                      person['email'] ?? '',
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

  Widget _buildCoordinatorCard(BuildContext context, String name, String role, String image, String phone, String email) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.phone,
                    color: phone.isNotEmpty ? Colors.white : Colors.white38,
                  ),
                  tooltip: 'Call',
                  onPressed: phone.isNotEmpty
                      ? () => _launchPhone(context, phone)
                      : null,
                ),
                IconButton(
                  icon: Icon(
                    Icons.email,
                    color: email.isNotEmpty ? Colors.white : Colors.white38,
                  ),
                  tooltip: 'Email',
                  onPressed: email.isNotEmpty
                      ? () => _launchEmail(context, email)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 8),
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

  Future<void> _launchUrl(BuildContext context, Uri uri) async {
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $uri';
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open contact'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _launchPhone(BuildContext context, String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    await _launchUrl(context, uri);
  }

  Future<void> _launchEmail(BuildContext context, String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    await _launchUrl(context, uri);
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
