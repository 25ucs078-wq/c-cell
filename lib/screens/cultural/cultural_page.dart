import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cultural_club_detail_page.dart';

class CulturalPage extends StatelessWidget {
  const CulturalPage({super.key});

  static final List<Map<String, dynamic>> culturalClubs = [
    {
      'name': 'Aaveg',
      'icon': 'assets/assets/images/cultural/aaveg/aaveg_logo.png',
      'subtitle': 'The Nukkad Mandali of LNMIIT',
      'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png',
    },
    {
      'name': 'Capriccio',
      'icon': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg',
      'subtitle': 'The Music Club of LNMIIT',
      'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg',
    },
    {
      'name': 'Eminence',
      'icon': 'assets/assets/images/cultural/eminence/eminence_logo.jpg',
      'subtitle': 'The Fashion Club of LNMIIT',
      'image': 'assets/assets/images/cultural/eminence/eminence_logo.jpg',
    },
    {
      'name': 'Finlogue',
      'icon': 'assets/assets/images/cultural/fundoo/fundoo_logo.jpg',
      'subtitle': 'Fintech club of LNMIIT',
      'image': 'assets/assets/images/cultural/fundoo/fundoo_logo.jpg',
    },
    {
      'name': 'Imagination',
      'icon': 'assets/assets/images/cultural/imagination/imagi_logo.jpg',
      'subtitle': 'Creative photography and cinematography Club',
      'image': 'assets/assets/images/cultural/imagination/imagination_logo.jpeg',
    },
    {
      'name': 'Insignia',
      'icon': 'assets/assets/images/cultural/insignia/insignia_logo.jpg',
      'subtitle': 'The Dance Club of LNMIIT',
      'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg',
    },
    {
      'name': 'Literary Committee',
      'icon': 'assets/assets/images/cultural/lc/lc_logo.jpg',
      'subtitle': 'Abode of writers of LNMIIT',
      'image': 'assets/assets/images/cultural/lc/lc_logo.jpg',
    },
    {
      'name': 'Media Cell',
      'icon': 'assets/assets/images/cultural/mediacell/media_logo.jpg',
      'subtitle': 'Anchors whose voice fills auditoriums',
      'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg',
    },
    {
      'name': 'Rendition',
      'icon': 'assets/assets/images/cultural/rendition/rendition_logo.png',
      'subtitle': 'The Theatre Society of LNMIIT',
      'image': 'assets/assets/images/cultural/rendition/rendition_logo.png',
    },
    {
      'name': 'Sankalp',
      'icon': 'assets/assets/images/cultural/sankalp/sankalp_logo.jpg',
      'subtitle': 'Social WelfareClub of LNMIIT',
      'image': 'assets/assets/images/cultural/sankalp/sankalp_logo.jpg',
    },
    {
      'name': 'Vignette',
      'icon': 'assets/assets/images/cultural/vignette/logo_unit.png',
      'subtitle': 'Art & Design club of LNMIIT',
      'image': 'assets/assets/images/cultural/vignette/logo_unit.png',
    },
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
          'CULTURAL CLUBS',
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
              Text(
                'EXPLORE CULTURAL CLUBS',
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
                    children: culturalClubs.map((club) {
                      return SizedBox(
                        width: cardWidth,
                        child: _buildClubCard(context, club),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClubCard(BuildContext context, Map<String, dynamic> club) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CulturalClubDetailPage(
              clubName: club['name'] as String,
              clubImage: club['image'] as String,
            ),
          ),
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
                    child: ClipOval(
                      child: Image.asset(
                        club['icon'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.white54,
                              size: 40,
                            ),
                          );
                        },
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
                    club['name'] as String,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    club['subtitle'] as String,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CulturalClubDetailPage(
                              clubName: club['name'] as String,
                              clubImage: club['image'] as String,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'VIEW CLUB',
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

