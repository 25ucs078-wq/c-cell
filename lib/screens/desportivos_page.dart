import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_page.dart';

class DesportivosPage extends StatelessWidget {
  const DesportivosPage({super.key});

  static const List<Map<String, String>> items = [
    {"name": "Inter-College Matches", "image": "assets/images/logo.jpeg", "role": "Sports"},
    {"name": "Athletics", "image": "assets/images/logo.jpeg", "role": "Track & Field"},
    {"name": "Tournaments", "image": "assets/images/logo.jpeg", "role": "Competitive"},
  ];

  static const List<String> galleryImages = [
    "assets/images/hero_new.jpeg",
    "assets/images/poster.jpeg",
    "assets/images/team_poster.jpeg",
  ];

  static const List<Map<String, String>> festHeads = [
    {"name": "Abhas Chaudhary", "role": "Fest Head"},
    {"name": "Arnav Rinawa", "role": "Fest Head"},
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
          "DESPORTIVOS",
          style: GoogleFonts.playfairDisplay(
            color: Colors.redAccent,
            fontSize: 38,
            letterSpacing: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: double.infinity, height: 260, child: Image.asset("assets/images/hero_new.jpeg", fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("DESPORTIVOS HIGHLIGHTS", style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 32, letterSpacing: 2)),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 320,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final p = items[index];
                        return _buildCard(context, p['name']!, p['image']!, p['role']!);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "PHOTO GALLERY",
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
                  const SizedBox(height: 28),
                  Text(
                    "FEST HEADS",
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: festHeads
                        .map(
                          (head) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: _buildHeadBox(head['name']!, head['role']!),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                ],
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

  Widget _buildHeadBox(String name, String role) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            role,
            style: GoogleFonts.poppins(
              color: Colors.redAccent,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String name, String image, String role) {
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
        decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset(image, width: 140, height: 140, fit: BoxFit.cover)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(name, textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(role, textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Spacer(),
            Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 12), decoration: const BoxDecoration(color: Color(0xFFB20710), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))), child: Center(child: Text("VIEW PROFILE", style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 22, letterSpacing: 2)))),
          ],
        ),
      ),
    );
  }
}
