import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sports_club_detail_page.dart';

class SportsPage extends StatelessWidget {
  const SportsPage({super.key});

  static List<Map<String, String>> _getCoordinators(String clubName) {
    if (clubName == 'Badminton') {
      return [
        {
          'name': 'Gourav Bansal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/badminton/badminton_logo.jpeg',
          'phone': '+919999999999',
          'email': '24ucs047@lnmiit.ac.in',
        },
        {
          'name': 'Jivya Jain',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/badminton/badminton_logo.jpeg',
          'phone': '+918888888888',
          'email': '24uec037@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Basketball') {
      return [
        {
          'name': 'Aryan Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/basketball/basketball_logo.png',
          'phone': '+919999999999',
          'email': '24ucs038@lnmiit.ac.in',
        },
        {
          'name': 'Aviral Goyal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/basketball/basketball_logo.png',
          'phone': '+918888888888',
          'email': '24uec242@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Chess') {
      return [
        {
          'name': 'Karun Pancholi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/chess/chess_logo.jpg',
          'phone': '+919999999999',
          'email': '24ucs074@lnmiit.ac.in',
        },
        {
          'name': 'Sushmit Sharma',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/chess/chess_logo.jpg',
          'phone': '+918888888888',
          'email': '24ucs257@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Cricket') {
      return [
        {
          'name': 'Dhruv Semalti',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/cricket/cricket_logo.jpeg',
          'phone': '+919999999999',
          'email': '24ucs283@lnmiit.ac.in',
        },
        {
          'name': 'Sandarbh Gyan',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/cricket/cricket_logo.jpeg',
          'phone': '+918888888888',
          'email': '24uec019@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Football') {
      return [
        {
          'name': 'Amrendra Vikram Singh',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/football/football_logo.jpg',
          'phone': '+919999999999',
          'email': '24uec092@lnmiit.ac.in',
        },
        {
          'name': 'Ninaad Mathur',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/football/football_logo.jpg',
          'phone': '+918888888888',
          'email': '24ucs013@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Kabaddi') {
      return [
        {
          'name': 'Nitish Matta',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/kabaddi/kabaddi_logo.jpeg',
          'phone': '+919999999999',
          'email': '24uec217@lnmiit.ac.in',
        },
        {
          'name': 'Vaibhav Rawat',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/kabaddi/kabaddi_logo.jpeg',
          'phone': '+918888888888',
          'email': '24ucs095@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Lawn Tennis') {
      return [
        {
          'name': 'Lokik Ganeriwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/lawn_tennis/lawnt_logo.png',
          'phone': '+918875967149',
          'email': '23ucs634@lnmiit.ac.in',
        },
        {
          'name': 'Arjit Mathur',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/lawn_tennis/lawnt_logo.png',
          'phone': '+919352888935',
          'email': '24ucs545@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Squash') {
      return [
        {
          'name': 'Lakshya Mangal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/squash/squash_logo.jpeg',
          'phone': '+919999999999',
          'email': '24ucs220@lnmiit.ac.in',
        },
        {
          'name': 'Ritesh Sarawagi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/squash/squash_logo.jpeg',
          'phone': '+918888888888',
          'email': '24ucc064@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Table Tennis') {
      return [
        {
          'name': 'Aalekh Narain',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/table_tennis/tablet_logo.png',
          'phone': '+919999999999',
          'email': '24ucs224@lnmiit.ac.in',
        },
        {
          'name': 'Akansh Saxena',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/table_tennis/tablet_logo.png',
          'phone': '+918888888888',
          'email': '24uec155@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Volleyball') {
      return [
        {
          'name': 'Ruhani Sukhija',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/volleyball/volleyball_logo.jpg',
          'phone': '+918888888888',
          'email': '24ucs108@lnmiit.ac.in',
        },
        {
          'name': 'Karun Pancholi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/sports/volleyball/volleyball_logo.jpg',
          'phone': '+919999999999',
          'email': '24ucs074@lnmiit.ac.in',
        },
      ];
    }

    return [
      {
        'name': '$clubName Coordinator 1',
        'role': 'Club Coordinator',
        'image': 'assets/assets/images/tech_logo.jpg',
        'phone': '+919876543210',
        'email': '${clubName.toLowerCase().replaceAll(' ', '')}_coord1@lnmiit.ac.in',
      },
    ];
  }

  static List<String> _getGallery(String clubName) {
    if (clubName == 'Badminton') {
      return [
        'assets/assets/images/sports/badminton/bad1.jpeg',
        'assets/assets/images/sports/badminton/bad2.jpeg',
        'assets/assets/images/sports/badminton/bad3.jpeg',
      ];
    }
    if (clubName == 'Basketball') {
      return [
        'assets/assets/images/sports/basketball/basket1.jpeg',
        'assets/assets/images/sports/basketball/basket2.jpeg',
        'assets/assets/images/sports/basketball/basket3.jpeg',
      ];
    }
    if (clubName == 'Chess') {
      return [
        'assets/assets/images/sports/chess/chess1.jpg',
        'assets/assets/images/sports/chess/chess2.jpg',
      ];
    }
    if (clubName == 'Cricket') {
      return [
        'assets/assets/images/sports/cricket/cricket1.jpeg',
        'assets/assets/images/sports/cricket/cricket2.jpeg',
        'assets/assets/images/sports/cricket/cricket3.jpeg',
      ];
    }
    if (clubName == 'Football') {
      return [
        'assets/assets/images/sports/football/foot1.jpg',
        'assets/assets/images/sports/football/foot2.jpg',
        'assets/assets/images/sports/football/foot3.jpg',
      ];
    }
    if (clubName == 'Kabaddi') {
      return [
        'assets/assets/images/sports/kabaddi/kabaddi1.jpeg',
        'assets/assets/images/sports/kabaddi/kabaddi2.jpeg',
        'assets/assets/images/sports/kabaddi/kabaddi3.jpeg',
      ];
    }
    if (clubName == 'Lawn Tennis') {
      return [
        'assets/assets/images/sports/lawn_tennis/lawn1.jpeg',
        'assets/assets/images/sports/lawn_tennis/lawn2.jpeg',
        'assets/assets/images/sports/lawn_tennis/lawn3.jpeg',
      ];
    }
    if (clubName == 'Squash') {
      return [
        'assets/assets/images/sports/squash/squash1.jpeg',
        'assets/assets/images/sports/squash/squash2.jpg',
        'assets/assets/images/sports/squash/squash3.jpg',
      ];
    }
    if (clubName == 'Table Tennis') {
      return [
        'assets/assets/images/sports/table_tennis/tablt1.jpg',
        'assets/assets/images/sports/table_tennis/talblt2.jpg',
        'assets/assets/images/sports/table_tennis/tablt3.jpg',
      ];
    }
    if (clubName == 'Volleyball') {
      return [
        'assets/assets/images/sports/volleyball/volley1.jpg',
        'assets/assets/images/sports/volleyball/volley2.jpg',
        'assets/assets/images/sports/volleyball/volley5.jpg',
      ];
    }

    return [
      'assets/images/hero_new.jpeg',
      'assets/images/team_poster.jpeg',
      'assets/images/photowalk.jpeg',
    ];
  }

  static final List<Map<String, dynamic>> sportsClubs = [
    {
      'name': 'Badminton',
      'icon': 'assets/assets/images/sports/badminton/badminton_logo.jpeg',
      'subtitle': 'Badminton Club of LNMIIT',
      'image': 'assets/assets/images/sports/badminton/badminton_logo.jpeg',
      'coordinators': _getCoordinators('Badminton'),
      'gallery': _getGallery('Badminton'),
    },
    {
      'name': 'Basketball',
      'icon': 'assets/assets/images/sports/basketball/basketball_logo.png',
      'subtitle': 'Basketball Club of LNMIIT',
      'image': 'assets/assets/images/sports/basketball/basketball_logo.png',
      'coordinators': _getCoordinators('Basketball'),
      'gallery': _getGallery('Basketball'),
    },
    {
      'name': 'Chess',
      'icon': 'assets/assets/images/sports/chess/chess_logo.jpg',
      'subtitle': 'Chess Club of LNMIIT',
      'image': 'assets/assets/images/sports/chess/chess_logo.jpg',
      'coordinators': _getCoordinators('Chess'),
      'gallery': _getGallery('Chess'),
    },
    {
      'name': 'Cricket',
      'icon': 'assets/assets/images/sports/cricket/cricket_logo.jpeg',
      'subtitle': 'Cricket Club of LNMIIT',
      'image': 'assets/assets/images/sports/cricket/cricket_logo.jpeg',
      'coordinators': _getCoordinators('Cricket'),
      'gallery': _getGallery('Cricket'),
    },
    {
      'name': 'Football',
      'icon': 'assets/assets/images/sports/football/football_logo.jpg',
      'subtitle': 'Football Club of LNMIIT',
      'image': 'assets/assets/images/sports/football/football_logo.jpg',
      'coordinators': _getCoordinators('Football'),
      'gallery': _getGallery('Football'),
    },
    {
      'name': 'Kabaddi',
      'icon': 'assets/assets/images/sports/kabaddi/kabaddi_logo.jpeg',
      'subtitle': 'Kabaddi Club of LNMIIT',
      'image': 'assets/assets/images/sports/kabaddi/kabaddi_logo.jpeg',
      'coordinators': _getCoordinators('Kabaddi'),
      'gallery': _getGallery('Kabaddi'),
    },
    {
      'name': 'Lawn Tennis',
      'icon': 'assets/assets/images/sports/lawn_tennis/lawnt_logo.png',
      'subtitle': 'Lawn Tennis Club of LNMIIT',
      'image': 'assets/assets/images/sports/lawn_tennis/lawnt_logo.png',
      'coordinators': _getCoordinators('Lawn Tennis'),
      'gallery': _getGallery('Lawn Tennis'),
    },
    {
      'name': 'Squash',
      'icon': 'assets/assets/images/sports/squash/squash_logo.jpeg',
      'subtitle': 'Squash Club of LNMIIT',
      'image': 'assets/assets/images/sports/squash/squash_logo.jpeg',
      'coordinators': _getCoordinators('Squash'),
      'gallery': _getGallery('Squash'),
    },
    {
      'name': 'Table Tennis',
      'icon': 'assets/assets/images/sports/table_tennis/tablet_logo.png',
      'subtitle': 'Table Tennis Club of LNMIIT',
      'image': 'assets/assets/images/sports/table_tennis/tablet_logo.png',
      'coordinators': _getCoordinators('Table Tennis'),
      'gallery': _getGallery('Table Tennis'),
    },
    {
      'name': 'Volleyball',
      'icon': 'assets/assets/images/sports/volleyball/volleyball_logo.jpg',
      'subtitle': 'Volleyball Club of LNMIIT',
      'image': 'assets/assets/images/sports/volleyball/volleyball_logo.jpg',
      'coordinators': _getCoordinators('Volleyball'),
      'gallery': _getGallery('Volleyball'),
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
          'SPORTS CLUBS',
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
                'EXPLORE SPORTS CLUBS',
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
                    children: sportsClubs.map((club) {
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
            builder: (context) => SportsClubDetailPage(
              clubName: club['name'] as String,
              clubImage: club['image'] as String,
              coordinators: List<Map<String, String>>.from(
                (club['coordinators'] as List).map(
                  (item) => Map<String, String>.from(item as Map),
                ),
              ),
              galleryImages: List<String>.from(club['gallery'] as List),
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
                            builder: (context) => SportsClubDetailPage(
                              clubName: club['name'] as String,
                              clubImage: club['image'] as String,
                              coordinators: List<Map<String, String>>.from(
                                (club['coordinators'] as List).map(
                                  (item) => Map<String, String>.from(item as Map),
                                ),
                              ),
                              galleryImages: List<String>.from(club['gallery'] as List),
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
