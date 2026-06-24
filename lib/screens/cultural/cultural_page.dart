import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cultural_club_detail_page.dart';

class CulturalPage extends StatelessWidget {
  const CulturalPage({super.key});

  static final List<Map<String, dynamic>> culturalClubs = [
    {
      'name': 'Aaveg',
      'icon': 'assets/assets/images/cultural/aaveg/aaveg_logo.png',
      'subtitle': 'Movement, rhythm and stagecraft',
      'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png',
    },
    {
      'name': 'Capriccio',
      'icon': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg',
      'subtitle': 'Songs, instruments and performances',
      'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg',
    },
    {
      'name': 'Eminence',
      'icon': 'assets/assets/images/cultural/eminence/eminence_logo.jpg',
      'subtitle': 'Plays, skits and storytelling',
      'image': 'assets/assets/images/cultural/eminence/eminence_logo.jpg',
    },
    {
      'name': 'Finlogue',
      'icon': 'assets/assets/images/cultural/fundoo/fundoo_logo.jpg',
      'subtitle': 'Frames, light and campus life',
      'image': 'assets/assets/images/cultural/fundoo/fundoo_logo.jpg',
    },
    {
      'name': 'Imagination',
      'icon': 'assets/assets/images/cultural/imagination/imagi_logo.jpg',
      'subtitle': 'Frames, light and campus life',
      'image': 'assets/assets/images/cultural/imagination/imagination_logo.jpeg',
    },
    {
      'name': 'Insignia',
      'icon': 'assets/assets/images/cultural/insignia/insignia_logo.jpg',
      'subtitle': 'Frames, light and campus life',
      'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg',
    },
    {
      'name': 'Literary Committee',
      'icon': 'assets/assets/images/cultural/lc/lc_logo.jpg',
      'subtitle': 'Frames, light and campus life',
      'image': 'assets/assets/images/cultural/lc/lc_logo.jpg',
    },
    {
      'name': 'Media Cell',
      'icon': 'assets/assets/images/cultural/mediacell/media_logo.jpg',
      'subtitle': 'Frames, light and campus life',
      'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg',
    },
    {
      'name': 'Rendition',
      'icon': 'assets/assets/images/cultural/rendition/rendition_logo.png',
      'subtitle': 'Frames, light and campus life',
      'image': 'assets/assets/images/cultural/rendition/rendition_logo.png',
    },
    {
      'name': 'Sankalp',
      'icon': 'assets/assets/images/cultural/sankalp/sankalp_logo.jpg',
      'subtitle': 'Frames, light and campus life',
      'image': 'assets/assets/images/cultural/sankalp/sankalp_logo.jpg',
    },
    {
      'name': 'Vignette',
      'icon': 'assets/assets/images/cultural/vignette/logo_unit.png',
      'subtitle': 'Frames, light and campus life',
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
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: culturalClubs.map((club) {
                  return _buildClubCard(context, club);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClubCard(BuildContext context, Map<String, dynamic> club) {
    return SizedBox(
      width: 320,
      child: GestureDetector(
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Icon(
                  club['icon'] as IconData,
                  color: Colors.white,
                  size: 42,
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
      ),
    );
  }
}
