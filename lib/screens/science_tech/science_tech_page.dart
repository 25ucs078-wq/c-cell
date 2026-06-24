import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScienceTechPage extends StatelessWidget {
  const ScienceTechPage({super.key});

  static List<Map<String, String>> _getCoordinators(String clubName) {
    if (clubName == 'Cybros') {
      return [
        {
          'name': 'Karun Pancholi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cybros/cybros_logo.jpg',
          'phone': '+919999999999',
          'email': '24ucs074@lnmiit.ac.in',
        },
        {
          'name': 'Sushmit Sharma',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cybros/cybros_logo.jpg',
          'phone': '+918888888888',
          'email': '24ucs257@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Phoenix') {
      return [
        {
          'name': 'Aryan Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png',
          'phone': '+919999999999',
          'email': '24ucs038@lnmiit.ac.in',
        },
        {
          'name': 'Aviral Goyal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png',
          'phone': '+918888888888',
          'email': '24uec242@lnmiit.ac.in',
        },
        {
          'name': 'Shamit Rathi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png',
          'phone': '+918888888888',
          'email': '24ucc004@lnmiit.ac.in',
        },
        {
          'name': 'Shreekant Kumawat',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png',
          'phone': '+918888888888',
          'email': '24uec183@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Quizzinga') {
      return [
        {
          'name': 'Dhruv Semalti',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg',
          'phone': '+919999999999',
          'email': '24ucs283@lnmiit.ac.in',
        },
        {
          'name': 'Sandarbh Gyan',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg',
          'phone': '+918888888888',
          'email': '24uec019@lnmiit.ac.in',
        },
        {
          'name': 'Viha Arvind Kotak',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg',
          'phone': '+918888888888',
          'email': '24ucc168@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Astronomy') {
      return [
        {
          'name': 'Gourav Bansal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/astronomy/gourav_sir.png',
          'phone': '+919999999999',
          'email': '24ucs047@lnmiit.ac.in',
        },
        {
          'name': 'Jivya Jain',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/astronomy/jivya_boss.png',
          'phone': '+918888888888',
          'email': '24uec037@lnmiit.ac.in',
        },
        {
          'name': 'Kshitij Verma',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/astronomy/kshitij_sir.png',
          'phone': '+918888888888',
          'email': '24ucc202@lnmiit.ac.in',
        },
        {
          'name': 'Tanushree Sethi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/astronomy/tanushree_boss.png',
          'phone': '+918888888888',
          'email': '24uec127@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Cipher') {
      return [
        {
          'name': 'Amrendra Vikram Singh',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png',
          'phone': '+919999999999',
          'email': '24uec092@lnmiit.ac.in',
        },
        {
          'name': 'Ninaad Mathur',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png',
          'phone': '+918888888888',
          'email': '24ucs013@lnmiit.ac.in',
        },
        {
          'name': 'Nitish Matta',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png',
          'phone': '+919999999999',
          'email': '24uec217@lnmiit.ac.in',
        },
        {
          'name': 'Vaibhav Rawat',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png',
          'phone': '+918888888888',
          'email': '24ucs095@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Qbit') {
      return [
        {
          'name': 'Lokik Ganeriwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech_logo.jpg',
          'phone': '+918875967149',
          'email': '23ucs634@lnmiit.ac.in',
        },
        {
          'name': 'Arjit Mathur',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech_logo.jpg',
          'phone': '+919352888935',
          'email': '24ucs545@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'E-Cell') {
      return [
        {
          'name': 'Lakshya Mangal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/ecell/ecell_logo.jpg',
          'phone': '+919999999999',
          'email': '24ucs220@lnmiit.ac.in',
        },
        {
          'name': 'Panth Moradiya',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/ecell/ecell_logo.jpg',
          'phone': '+918888888888',
          'email': '24ucc064@lnmiit.ac.in',
        },
        {
          'name': 'Ritesh Sarawagi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/ecell/ecell_logo.jpg',
          'phone': '+918888888888',
          'email': '24ucc064@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'DebSoc') {
      return [
        {
          'name': 'Aalekh Narain',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/debsoc/debsoc_logo.jpg',
          'phone': '+919999999999',
          'email': '24ucs224@lnmiit.ac.in',
        },
        {
          'name': 'Akansh Saxena',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/debsoc/debsoc_logo.jpg',
          'phone': '+918888888888',
          'email': '24uec155@lnmiit.ac.in',
        },
        {
          'name': 'Ruhani Sukhija',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/debsoc/debsoc_logo.jpg',
          'phone': '+918888888888',
          'email': '24ucs108@lnmiit.ac.in',
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
    if (clubName == 'Cybros') {
      return [
        'assets/assets/images/tech/cybros/cybros1.jpg',
        'assets/assets/images/tech/cybros/cybros2.jpg',
        'assets/assets/images/tech/cybros/cybros3.jpg',
      ];
    }
    if (clubName == 'Phoenix') {
      return [
        'assets/assets/images/tech/phoenix/phoenix1.jpg',
        'assets/assets/images/tech/phoenix/phoenix2.jpg',
        'assets/assets/images/tech/phoenix/phoenix3.jpg',
      ];
    }
    if (clubName == 'Quizzinga') {
      return [
        'assets/assets/images/tech/quizzinga/quizzinga1.jpg',
        'assets/assets/images/tech/quizzinga/quizzinga2.jpg',
        'assets/assets/images/tech/quizzinga/quizzinga3.jpg',
      ];
    }
    if (clubName == 'Astronomy') {
      return [
        'assets/assets/images/tech/astronomy/astro1.jpg',
        'assets/assets/images/tech/astronomy/astro2.jpg',
        'assets/assets/images/tech/astronomy/astro3.JPG',
      ];
    }
    if (clubName == 'Cipher') {
      return [
        'assets/assets/images/tech/cipherclub/cipher1.jpeg',
        'assets/assets/images/tech/cipherclub/cipher2.jpg',
        'assets/assets/images/tech/cipherclub/cipher3.jpeg',
      ];
    }
    if (clubName == 'Qbit') {
      return [
        'assets/images/hero_new.jpeg',
        'assets/images/team_poster.jpeg',
        'assets/images/photowalk.jpeg',
      ];
    }
    if (clubName == 'E-Cell') {
      return [
        'assets/assets/images/tech/ecell/ecell1.jpg',
        'assets/assets/images/tech/ecell/ecell2.jpg',
        'assets/assets/images/tech/ecell/ecell3.jpg',
      ];
    }
    if (clubName == 'DebSoc') {
      return [
        'assets/assets/images/tech/debsoc/deb1.jpg',
        'assets/assets/images/tech/debsoc/deb2.jpg',
        'assets/assets/images/tech/debsoc/deb3.jpg',
      ];
    }

    return [
      'assets/images/hero_new.jpeg',
      'assets/images/team_poster.jpeg',
      'assets/images/photowalk.jpeg',
    ];
  }

  static final List<Map<String, dynamic>> techClubs = [
    {
      'name': 'Astronomy',
      'icon': 'assets/assets/images/tech/astronomy/astro_logo.jpg',
      'subtitle': 'The Astronomy Club of LNMIIT',
      'image': 'assets/assets/images/tech/astronomy/astro_logo.jpg',
      'coordinators': _getCoordinators('Astronomy'),
      'gallery': _getGallery('Astronomy'),
    },
    {
      'name': 'Cipher',
      'icon': 'assets/assets/images/tech/cipherclub/cipher_logo.png',
      'subtitle': 'Cryptology & Cyber Security Club',
      'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png',
      'coordinators': _getCoordinators('Cipher'),
      'gallery': _getGallery('Cipher'),
    },
    {
      'name': 'Cybros',
      'icon': 'assets/assets/images/tech/cybros/cybros_logo.jpg',
      'subtitle': 'The Coding Club of LNMIIT',
      'image': 'assets/assets/images/tech/cybros/cybros_logo.jpg',
      'coordinators': _getCoordinators('Cybros'),
      'gallery': _getGallery('Cybros'),
    },
    {
      'name': 'DebSoc',
      'icon': 'assets/assets/images/tech/debsoc/debsoc_logo.jpg',
      'subtitle': 'The Debating Society of LNMIIT',
      'image': 'assets/assets/images/tech/debsoc/debsoc_logo.jpg',
      'coordinators': _getCoordinators('DebSoc'),
      'gallery': _getGallery('DebSoc'),
    },
    {
      'name': 'E-Cell',
      'icon': 'assets/assets/images/tech/ecell/ecell_logo.jpg',
      'subtitle': 'Innovation & Entrepreneurship Cell of LNMIIT',
      'image': 'assets/assets/images/tech/ecell/ecell_logo.jpg',
      'coordinators': _getCoordinators('E-Cell'),
      'gallery': _getGallery('E-Cell'),
    },
    {
      'name': 'Phoenix',
      'icon': 'assets/assets/images/tech/phoenix/phoenix_logo.png',
      'subtitle': 'The Robotics Club of LNMIIT',
      'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png',
      'coordinators': _getCoordinators('Phoenix'),
      'gallery': _getGallery('Phoenix'),
    },
    {
      'name': 'Qbit',
      'icon': 'assets/assets/images/tech_logo.jpg',
      'subtitle': 'The Quantum Computing Club of LNMIIT',
      'image': 'assets/assets/images/tech_logo.jpg',
      'coordinators': _getCoordinators('Qbit'),
      'gallery': _getGallery('Qbit'),
    },
    {
      'name': 'Quizzinga',
      'icon': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg',
      'subtitle': 'The Quiz Club of LNMIIT',
      'image': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg',
      'coordinators': _getCoordinators('Quizzinga'),
      'gallery': _getGallery('Quizzinga'),
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
          'SCIENCE & TECH CLUBS',
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
                'EXPLORE TECH CLUBS',
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
                    children: techClubs.map((club) {
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
        Navigator.pushNamed(
          context,
          '/science_tech_detail',
          arguments: {
            'clubName': club['name'] as String,
            'clubImage': club['image'] as String,
            'coordinators': List<Map<String, String>>.from(
              (club['coordinators'] as List).map(
                (item) => Map<String, String>.from(item as Map),
              ),
            ),
            'galleryImages': List<String>.from(club['gallery'] as List),
          },
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
                        Navigator.pushNamed(
                          context,
                          '/science_tech_detail',
                          arguments: {
                            'clubName': club['name'] as String,
                            'clubImage': club['image'] as String,
                            'coordinators': List<Map<String, String>>.from(
                              (club['coordinators'] as List).map(
                                (item) => Map<String, String>.from(item as Map),
                              ),
                            ),
                            'galleryImages': List<String>.from(club['gallery'] as List),
                          },
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
