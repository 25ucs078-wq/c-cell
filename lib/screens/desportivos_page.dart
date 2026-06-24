import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesportivosPage extends StatelessWidget {
  const DesportivosPage({super.key});

  static const List<String> galleryImages = [
    "assets/images/hero_new.jpeg",
    "assets/images/poster.jpeg",
    "assets/images/team_poster.jpeg",
  ];

  static const List<Map<String, String>> festHeads = [
    {"name": "Abhas Chaudhary", "image": "assets/images/logo.jpeg", "role": "Fest Head"},
    {"name": "Arnav Rinawa", "image": "assets/images/logo.jpeg", "role": "Fest Head"},
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
            SizedBox(
              width: double.infinity,
              height: 260,
              child: Image.asset(
                "assets/images/hero_new.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FEST HEADS",
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 32,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double parentWidth = constraints.maxWidth;
                      int crossAxisCount = 1;
                      if (parentWidth >= 1100) {
                        crossAxisCount = 4;
                      } else if (parentWidth >= 600) {
                        crossAxisCount = 2;
                      } else {
                        crossAxisCount = 1;
                      }

                      // Calculate item width dynamically
                      double cardWidth = (parentWidth - (crossAxisCount - 1) * 20) / crossAxisCount;

                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: festHeads.map((p) {
                          return SizedBox(
                            width: cardWidth,
                            child: _buildCard(context, p['name']!, p['image']!, p['role']!),
                          );
                        }).toList(),
                      );
                    },
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

  Widget _buildCard(BuildContext context, String name, String image, String role) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/profile',
          arguments: {'name': name, 'image': image, 'role': role},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF262626),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.redAccent, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Hero(
                      tag: name,
                      child: ClipOval(
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(
                               Icons.person,
                               color: Colors.white54,
                               size: 50,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    role,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/profile',
                          arguments: {'name': name, 'image': image, 'role': role},
                        );
                      },
                      child: Text(
                        'VIEW PROFILE',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
