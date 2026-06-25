import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/glass_card.dart';

class CulturalPage extends StatelessWidget {
  const CulturalPage({super.key});

  static List<Map<String, String>> _getCoordinators(String clubName) {
    if (clubName == 'Aaveg') {
      return [
        {
          'name': 'Aditya Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png', // Replace with their actual photo path
          'phone': '+919999999999',
          'email': '24ucs220@lnmiit.ac.in',
        },
        {
          'name': 'Shourya Kavadia',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png', // Replace with their actual photo path
          'phone': '+918888888888',
          'email': '24ucc064@lnmiit.ac.in',
        },
        {
          'name': 'Tanuj Tulsyan',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png', // Replace with their actual photo path
          'phone': '+917777777777',
          'email': '24ucc169@lnmiit.ac.in',
        },
        {
          'name': 'Yash Gupta',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png', // Replace with their actual photo path
          'phone': '+916666666666',
          'email': '24ucc099@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Capriccio') {
      return [
        {
          'name': 'Ashmit Dudani',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg', // Replace with their actual photo path
          'phone': '+919999999999',
          'email': '24dcs014@lnmiit.ac.in',
        },
        {
          'name': 'Nandini Sharma',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg', // Replace with their actual photo path
          'phone': '+918888888888',
          'email': '24ucs273@lnmiit.ac.in',
        },
        {
          'name': 'Nilesh Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg', // Replace with their actual photo path
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
        {
          'name': 'Parth Arora',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg', // Replace with their actual photo path
          'phone': '+916666666666',
          'email': '24imai005@lnmiit.ac.in',
        },
      ];
    }
    
    if (clubName == 'Eminence') {
      return [
        {
          'name': 'Avesh Khan',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/eminence/eminence_logo.jpg', // Replace with their actual photo path
          'phone': '+919999999999',
          'email': '24ucs127@lnmiit.ac.in',
        },
        {
          'name': 'Kushagra',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/eminence/eminence_logo.jpg', // Replace with their actual photo path
          'phone': '+918888888888',
          'email': '24ucc087@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Finlogue') {
      return [
        {
          'name': 'Aditya Tiwari',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/finlogue/aditya.jpeg',
          'phone': '+919999999999',
          'email': '24ucs155@lnmiit.ac.in',
        },
        {
          'name': 'Akshat Thadhani',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/finlogue/akshat.jpeg',
          'phone': '+918888888888',
          'email': '24ucc116@lnmiit.ac.in',
        },
        {
          'name': 'Aryan Mittal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/finlogue/aryan.jpeg',
          'phone': '+917777777777',
          'email': '24ucs152@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Imagination') {
      return [
        {
          'name': 'Aditya Prakash',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/imagination/imagi_logo.jpg', // Replace with their actual photo path
          'phone': '+919639837550',
          'email': '24uec087@lnmiit.ac.in',
        },
        {
          'name': 'Avirat Kaushik',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/imagination/imagi_logo.jpg', // Replace with their actual photo path
          'phone': '+919311148142',
          'email': '24ucs235@lnmiit.ac.in',
        },
        {
          'name': 'Ayush Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/imagination/imagi_logo.jpg', // Replace with their actual photo path
          'phone': '+917355568914',
          'email': '24ucc171@lnmiit.ac.in',
        },
        {
          'name': 'Siddhesh Chintamani',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/imagination/imagi_logo.jpg', // Replace with their actual photo path
          'phone': '+918485829571',
          'email': '24uec119@lnmiit.ac.in',
        },
      ];
    }

    if(clubName == 'Insignia')
    {
      return [
        {
          'name': 'Ananya Surana',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg', // Replace with their actual photo path
          'phone': '+919999999999',
          'email': '24dcs014@lnmiit.ac.in',
        },
        {
          'name': 'Kavin Goyal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg', // Replace with their actual photo path
          'phone': '+918888888888',
          'email': '24ucs273@lnmiit.ac.in',
        },
        {
          'name': 'Shivansh Singh',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg', // Replace with their actual photo path
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
      ];
    }

    if(clubName == 'Literary Committee')
    {
      return [
        {
          'name': 'Armaan Jain',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/lc/lc_logo.jpg', // Replace with their actual photo path
          'phone': '+919999999999',
          'email': '24dcs014@lnmiit.ac.in',
        },
        {
          'name': 'Mriganka Kothari',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/lc/lc_logo.jpg', // Replace with their actual photo path
          'phone': '+918888888888',
          'email': '24ucs273@lnmiit.ac.in',
        },
        {
          'name': 'Parth Chaturvedi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/lc/lc_logo.jpg', // Replace with their actual photo path
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
        {
          'name': 'Poorvi Jagga',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/lc/lc_logo.jpg', // Replace with their actual photo path
          'phone': '+919999999999',
          'email': '24dcs014@lnmiit.ac.in',
        },
      ];
    }

    if(clubName == 'Media Cell')
    {
      return [
        {
          'name': 'Pranav Vashisth',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // Replace with their actual photo path
          'phone': '+919999999999',
          'email': '24dcs014@lnmiit.ac.in',
        },
        {
          'name': 'Praneel Dev',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // Replace with their actual photo path
          'phone': '+918888888888',
          'email': '24ucs273@lnmiit.ac.in',
        },
        {
          'name': 'Samar Goyal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // Replace with their actual photo path
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
        {
          'name': 'Vedha Sinkar',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // Replace with their actual photo path
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
      ];
    }
    
    if(clubName == 'Rendition')
    {
      return [
        {
          'name': 'Madhav Agrawal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/rendition/rendition_logo.png', // Replace with their actual photo path
          'phone': '+919999999999',
          'email': '24dcs014@lnmiit.ac.in',
        },
        {
          'name': 'Nikhila S Hari',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/rendition/rendition_logo.png', // Replace with their actual photo path
          'phone': '+918888888888',
          'email': '24ucs273@lnmiit.ac.in',
        },
        {
          'name': 'Shah Manav Tarakkumar',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/rendition/rendition_logo.png', // Replace with their actual photo path
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
      ];
    }
    
    if(clubName == 'Sankalp')
    {
      return [
        {
          'name': 'Amisha Paliwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/amisha.jpeg',
          'phone': '+919999999999',
          'email': '24dcs014@lnmiit.ac.in',
        },
        {
          'name': 'Arnav Dubey',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/arnav.jpeg',
          'phone': '+918888888888',
          'email': '24ucs273@lnmiit.ac.in',
        },
        {
          'name': 'Gaurav Kalal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/gaurav.jpeg',
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
        {
          'name': 'Lakshya Chandak',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/lakshya.jpeg', 
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
        {
          'name': 'Raghav Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/raghav.jpeg',
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
      ];
    }
    
    if(clubName == 'Vignette')
    {
      return [
        {
          'name': 'Akshat Mishra',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/vignette/akshat.jpeg',
          'phone': '+919999999999',
          'email': '24dcs014@lnmiit.ac.in',
        },
        {
          'name': 'Divyansh Patil',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/vignette/divyansh.jpeg',
          'phone': '+918888888888',
          'email': '24ucs273@lnmiit.ac.in',
        },
        {
          'name': 'Hiya Gera',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/vignette/hiya.jpeg',
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
        {
          'name': 'Jahanvi Garg',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/vignette/jahanvi.jpeg',
          'phone': '+917777777777',
          'email': '24uec214@lnmiit.ac.in',
        },
      ];
    }
    
    // Default fallback list for other clubs until you fill them in
    return [
      {
        'name': '$clubName Coordinator 1',
        'role': 'Club Coordinator',
        'image': 'assets/images/logo.jpeg',
        'phone': '+919876543210',
        'email': '${clubName.toLowerCase().replaceAll(' ', '')}_coord1@lnmiit.ac.in',
      },
      {
        'name': '$clubName Coordinator 2',
        'role': 'Co-Coordinator',
        'image': 'assets/images/logo.jpeg',
        'phone': '+918765432109',
        'email': '${clubName.toLowerCase().replaceAll(' ', '')}_coord2@lnmiit.ac.in',
      },
      {
        'name': '$clubName Coordinator 3',
        'role': 'Co-Coordinator',
        'image': 'assets/images/logo.jpeg',
        'phone': '+917654321098',
        'email': '${clubName.toLowerCase().replaceAll(' ', '')}_coord3@lnmiit.ac.in',
      },
      {
        'name': '$clubName Coordinator 4',
        'role': 'Sub-Coordinator',
        'image': 'assets/images/logo.jpeg',
        'phone': '+916543210987',
        'email': '${clubName.toLowerCase().replaceAll(' ', '')}_coord4@lnmiit.ac.in',
      },
    ];
  }

  static List<String> _getGallery(String clubName) {
    if (clubName == 'Aaveg') {
      return [
        'assets/assets/images/cultural/aaveg/aaveg_logo.png', // Example path
        'assets/images/hero_new.jpeg',
        'assets/images/team_poster.jpeg',
      ];
    }

    if (clubName == 'Finlogue') {
      return [
        'assets/assets/images/cultural/finlogue/fundoo1.jpg',
        'assets/assets/images/cultural/finlogue/fundoo3.jpg',
        'assets/assets/images/cultural/finlogue/fundoo4.jpg',
        'assets/assets/images/cultural/finlogue/fundoo6.jpg',
        'assets/assets/images/cultural/finlogue/fundoo7.jpg',
      ];
    }

    return [
      'assets/images/hero_new.jpeg',
      'assets/images/team_poster.jpeg',
      'assets/images/photowalk.jpeg',
    ];
  }

  static final List<Map<String, dynamic>> culturalClubs = [
    {
      'name': 'Aaveg',
      'icon': 'assets/assets/images/cultural/aaveg/aaveg_logo.png',
      'subtitle': 'The Nukkad Mandali of LNMIIT',
      'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png',
      'coordinators': _getCoordinators('Aaveg'),
      'gallery': _getGallery('Aaveg'),
    },
    {
      'name': 'Capriccio',
      'icon': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg',
      'subtitle': 'The Music Club of LNMIIT',
      'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg',
      'coordinators': _getCoordinators('Capriccio'),
      'gallery': _getGallery('Capriccio'),
    },
    {
      'name': 'Eminence',
      'icon': 'assets/assets/images/cultural/eminence/eminence_logo.jpg',
      'subtitle': 'The Fashion Club of LNMIIT',
      'image': 'assets/assets/images/cultural/eminence/eminence_logo.jpg',
      'coordinators': _getCoordinators('Eminence'),
      'gallery': _getGallery('Eminence'),
    },
    {
      'name': 'Finlogue',
      'icon': 'assets/assets/images/cultural/finlogue/finlogue_logo.jpeg',
      'subtitle': 'Fintech club of LNMIIT',
      'image': 'assets/assets/images/cultural/finlogue/finlogue_logo.jpeg',
      'coordinators': _getCoordinators('Finlogue'),
      'gallery': _getGallery('Finlogue'),
    },
    {
      'name': 'Imagination',
      'icon': 'assets/assets/images/cultural/imagination/imagi_logo.jpg',
      'subtitle': 'Creative photography and cinematography Club',
      'image': 'assets/assets/images/cultural/imagination/imagination_logo.jpeg',
      'coordinators': _getCoordinators('Imagination'),
      'gallery': _getGallery('Imagination'),
    },
    {
      'name': 'Insignia',
      'icon': 'assets/assets/images/cultural/insignia/insignia_logo.jpg',
      'subtitle': 'The Dance Club of LNMIIT',
      'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg',
      'coordinators': _getCoordinators('Insignia'),
      'gallery': _getGallery('Insignia'),
    },
    {
      'name': 'Literary Committee',
      'icon': 'assets/assets/images/cultural/lc/lc_logo.jpg',
      'subtitle': 'Abode of writers of LNMIIT',
      'image': 'assets/assets/images/cultural/lc/lc_logo.jpg',
      'coordinators': _getCoordinators('Literary Committee'),
      'gallery': _getGallery('Literary Committee'),
    },
    {
      'name': 'Media Cell',
      'icon': 'assets/assets/images/cultural/mediacell/media_logo.jpg',
      'subtitle': 'Anchors whose voice fills auditoriums',
      'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg',
      'coordinators': _getCoordinators('Media Cell'),
      'gallery': _getGallery('Media Cell'),
    },
    {
      'name': 'Rendition',
      'icon': 'assets/assets/images/cultural/rendition/rendition_logo.png',
      'subtitle': 'The Theatre Society of LNMIIT',
      'image': 'assets/assets/images/cultural/rendition/rendition_logo.png',
      'coordinators': _getCoordinators('Rendition'),
      'gallery': _getGallery('Rendition'),
    },
    {
      'name': 'Sankalp',
      'icon': 'assets/assets/images/cultural/sankalp/sankalp_logo.jpg',
      'subtitle': 'Social WelfareClub of LNMIIT',
      'image': 'assets/assets/images/cultural/sankalp/sankalp_logo.jpg',
      'coordinators': _getCoordinators('Sankalp'),
      'gallery': _getGallery('Sankalp'),
    },
    {
      'name': 'Vignette',
      'icon': 'assets/assets/images/cultural/vignette/logo_unit.png',
      'subtitle': 'Art & Design club of LNMIIT',
      'image': 'assets/assets/images/cultural/vignette/logo_unit.png',
      'coordinators': _getCoordinators('Vignette'),
      'gallery': _getGallery('Vignette'),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050816),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'CULTURAL CLUBS',
          style: GoogleFonts.playfairDisplay(
            color: Colors.redAccent,
            fontSize: isMobile ? 22 : 38,
            letterSpacing: isMobile ? 2 : 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 20,
                vertical: isMobile ? 16 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EXPLORE CULTURAL CLUBS',
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 32,
                      letterSpacing: isMobile ? 1 : 2,
                    ),
                  ),
                  SizedBox(height: isMobile ? 16 : 20),
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
        ),
      ),
    );
  }

  Widget _buildClubCard(BuildContext context, Map<String, dynamic> club) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final String clubName = club['name'] as String;
    final String clubImage = club['image'] as String;
    final String clubIcon = club['icon'] as String;
    final String clubSubtitle = club['subtitle'] as String;
    final List<Map<String, String>> coordinators = List<Map<String, String>>.from(
      (club['coordinators'] as List).map(
        (item) => Map<String, String>.from(item as Map),
      ),
    );
    final List<String> galleryImages = List<String>.from(club['gallery'] as List);

    void onCardTap() {
      Navigator.pushNamed(
        context,
        '/cultural_detail',
        arguments: {
          'clubName': clubName,
          'clubImage': clubImage,
          'coordinators': coordinators,
          'galleryImages': galleryImages,
        },
      );
    }

    if (isMobile) {
      // Sleek horizontal list card for mobile app
      return GestureDetector(
        onTap: onCardTap,
        child: GlassCard(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.redAccent, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    clubIcon,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.white54,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      clubName,
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      clubSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.redAccent,
                size: 16,
              ),
            ],
          ),
        ),
      );
    }

    // Original vertical layout for desktop/web
    return GestureDetector(
      onTap: onCardTap,
      child: GlassCard(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 180,
                    height: 180,
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
                        clubIcon,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.white54,
                              size: 60,
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
                    clubName,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    clubSubtitle,
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
                      onPressed: onCardTap,
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

