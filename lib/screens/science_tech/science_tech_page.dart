import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/glass_card.dart';

class ScienceTechPage extends StatelessWidget {
  const ScienceTechPage({super.key});

  static List<Map<String, String>> _getCoordinators(String clubName) {
    if (clubName == 'Cybros') {
      return [
        {
          'name': 'Karun Pancholi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cybros/cybros_logo.jpg', // not updated
          'phone': '+919999999999', // not updated
          'email': '24ucs074@lnmiit.ac.in',
        },
        {
          'name': 'Sushmit Sharma',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cybros/cybros_logo.jpg', // not updated
          'phone': '+918888888888', // not updated
          'email': '24ucs257@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Phoenix') {
      return [
        {
          'name': 'Aryan Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png', // not updated
          'phone': '+919999999999', // not updated
          'email': '24ucs038@lnmiit.ac.in',
        },
        {
          'name': 'Aviral Goyal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png', // not updated
          'phone': '+918888888888', // not updated
          'email': '24uec242@lnmiit.ac.in',
        },
        {
          'name': 'Shamit Rathi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png', // not updated
          'phone': '+918888888888', // not updated
          'email': '24ucc004@lnmiit.ac.in',
        },
        {
          'name': 'Shreekant Kumawat',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png', // not updated
          'phone': '+918888888888', // not updated
          'email': '24uec183@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Quizzinga') {
      return [
        {
          'name': 'Dhruv Semalti',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg', // not updated
          'phone': '+919999999999', // not updated
          'email': '24ucs283@lnmiit.ac.in',
        },
        {
          'name': 'Sandarbh Gyan',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg', // not updated
          'phone': '+917762049885',
          'email': '24uec019@lnmiit.ac.in',
        },
        {
          'name': 'Viha Arvind Kotak',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg', // not updated
          'phone': '+919409633133',
          'email': '24ucc168@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Astronomy') {
      return [
        {
          'name': 'Gourav Bansal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/astronomy/gourav_sir.png', // not updated
          'phone': '+918146507797',
          'email': '24ucs047@lnmiit.ac.in',
        },
        {
          'name': 'Jivya Jain',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/astronomy/jivya.jpeg',
          'phone': '+917597209911',
          'email': '24uec037@lnmiit.ac.in',
        },
        {
          'name': 'Kshitij Verma',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/astronomy/kshitij.jpeg',
          'phone': '+919137243003',
          'email': '24ucc202@lnmiit.ac.in',
        },
        {
          'name': 'Tanushree Sethi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/astronomy/tanushree.jpeg',
          'phone': '+917568164924',
          'email': '24uec127@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Cipher') {
      return [
        {
          'name': 'Amrendra Vikram Singh',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png', // not updated
          'phone': '+919999999999', // not updated
          'email': '24uec092@lnmiit.ac.in',
        },
        {
          'name': 'Ninaad Mathur',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png', // not updated
          'phone': '+918888888888', // not updated
          'email': '24ucs013@lnmiit.ac.in',
        },
        {
          'name': 'Nitish Matta',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png', // not updated
          'phone': '+919999999999', // not updated
          'email': '24uec217@lnmiit.ac.in',
        },
        {
          'name': 'Vaibhav Rawat',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png', // not updated
          'phone': '+918888888888', // not updated
          'email': '24ucs095@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Qbit') {
      return [
        {
          'name': 'Lokik Ganeriwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/qbit/lokik.jpeg',
          'phone': '+918875967149', 
          'email': '23ucs634@lnmiit.ac.in',
        },
        {
          'name': 'Arjit Mathur',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/qbit/arjit.jpeg',
          'phone': '+919352888935',
          'email': '23ucs545@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'E-Cell') {
      return [
        {
          'name': 'Lakshya Mangal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/ecell/lakshya.jpeg',
          'phone': '+918529216481', 
          'email': '24uec196@lnmiit.ac.in',
        },
        {
          'name': 'Panth Moradiya',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/ecell/panth.jpeg',
          'phone': '+919979901008',
          'email': '24ucs120@lnmiit.ac.in',
        },
        {
          'name': 'Ritesh Sarawagi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/ecell/ritesh.jpeg',
          'phone': '+919461834682',
          'email': '24uec050@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'DebSoc') {
      return [
        {
          'name': 'Aalekh Narain',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/debsoc/debsoc_logo.jpg', // not updated
          'phone': '+918851341701',
          'email': '24ucs224@lnmiit.ac.in',
        },
        {
          'name': 'Akansh Saxena',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/debsoc/akansh.jpeg',
          'phone': '+917668010687',
          'email': '24uec155@lnmiit.ac.in',
        },
        {
          'name': 'Ruhani Sukhija',
          'role': 'Coordinator',
          'image': 'assets/assets/images/tech/debsoc/debsoc_logo.jpg', // not updated
          'phone': '+917014531991',
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
        'assets/assets/images/tech/cybros/cybros1.jpg'
      ];
    }
    if (clubName == 'Phoenix') {
      return [
        'assets/assets/images/tech/phoenix/phoenix1.jpg'
      ];
    }
    if (clubName == 'Quizzinga') {
      return [
        'assets/assets/images/tech/quizzinga/quizzinga1.jpg'
      ];
    }
    if (clubName == 'Astronomy') {
      return [
        'assets/assets/images/tech/astronomy/astro1.jpeg'
      ];
    }
    if (clubName == 'Cipher') {
      return [
        'assets/assets/images/tech/cipherclub/cipher1.jpeg'
      ];
    }
    if (clubName == 'Qbit') {
      return [
        'assets/assets/images/tech/qbit/qbit1.jpeg'
      ];
    }
    if (clubName == 'E-Cell') {
      return [
        'assets/assets/images/tech/ecell/ecell1.jpg'
      ];
    }
    if (clubName == 'DebSoc') {
      return [
        'assets/assets/images/tech/debsoc/deb1.jpg'
      ];
    }
    return [];
  }

  static final List<Map<String, dynamic>> techClubs = [
    {
      'name': 'Astronomy',
      'icon': 'assets/assets/images/tech/astronomy/astro_logo.jpg',
      'subtitle': 'The Astronomy Club of LNMIIT',
      'image': 'assets/assets/images/tech/astronomy/astro_logo.jpg',
      'coordinators': _getCoordinators('Astronomy'),
      'gallery': _getGallery('Astronomy'),
      'description': "The Astronomy Club fuels student passion for the wonders of astronomy and space exploration, sparking curiosity about the universe’s endless mysteries. As one of LNMIIT’s most active clubs, we bring together creative and enthusiastic minds to host thrilling, high-energy events that captivate everyone. From stargazing nights to cosmic quizzes, our year-round activities keep the excitement alive—because college life isn’t just about academics, it’s about unforgettable experiences too!",
      'instagram': 'https://www.instagram.com/astronomylnmiit/',
      'email': 'astronomyclub@lnmiit.ac.in',
    },
    {
      'name': 'Cipher',
      'icon': 'assets/assets/images/tech/cipherclub/cipher_logo.png',
      'subtitle': 'Cryptology & Cyber Security Club',
      'image': 'assets/assets/images/tech/cipherclub/cipher_logo.png',
      'coordinators': _getCoordinators('Cipher'),
      'gallery': _getGallery('Cipher'),
      'description': "With the mission to empower and educate, CIPHER is the Cybersecurity and Blockchain club focused on fostering awareness, innovation, and a strong technical culture. It provides a space for students to explore digital security and decentralized technologies, grow through collaboration, and engage with two of the most impactful domains shaping the future.",
      'instagram': 'https://www.instagram.com/cipher.lnmiit/',
      'email': 'cipher@lnmiit.ac.in',
    },
    {
      'name': 'Cybros',
      'icon': 'assets/assets/images/tech/cybros/cybros_logo.jpg',
      'subtitle': 'The Coding Club of LNMIIT',
      'image': 'assets/assets/images/tech/cybros/cybros_logo.jpg',
      'coordinators': _getCoordinators('Cybros'),
      'gallery': _getGallery('Cybros'),
      'description': "Cybros is a competitive programming club dedicated to fostering a strong coding culture within the college. We promote algorithmic thinking, conduct regular contests, and help students build problem-solving skills through consistent practice and collaboration.",
      'instagram': 'https://www.instagram.com/cybros_lnmiit/',
      'email': 'cybrosclub@lnmiit.ac.in',
    },
    {
      'name': 'DebSoc',
      'icon': 'assets/assets/images/tech/debsoc/debsoc_logo.jpg',
      'subtitle': 'The Debating Society of LNMIIT',
      'image': 'assets/assets/images/tech/debsoc/debsoc_logo.jpg',
      'coordinators': _getCoordinators('DebSoc'),
      'gallery': _getGallery('DebSoc'),
      'description': "Lord Byron once said, “Those who will not reason are bigots, those who cannot are fools, and those who dare not are slaves.” At LNMIIT, we believe true growth comes from questioning, debating, and refining your voice. Enter The Debate Society (DebSoc)—where ideas clash, minds sharpen, and words become power. From fiery MUNs and parliamentary debates to gripping extempores, we cultivate rational thinkers and fearless speakers. Whether you're a seasoned orator or a curious beginner, DebSoc shapes you into a master of persuasion—one argument at a time. Because in a world of noise, the strongest voice wins.",
      'instagram': 'https://www.instagram.com/thedebatesocietylnmiit/',
      'email': 'debsoc@lnmiit.ac.in',
    },
    {
      'name': 'E-Cell',
      'icon': 'assets/assets/images/tech/ecell/ecell_logo.jpg',
      'subtitle': 'Innovation & Entrepreneurship Cell of LNMIIT',
      'image': 'assets/assets/images/tech/ecell/ecell_logo.jpg',
      'coordinators': _getCoordinators('E-Cell'),
      'gallery': _getGallery('E-Cell'),
      'description': "Dive into entrepreneurship, crypto, stocks, Web3, and beyond with The Entrepreneurship Club—your hub for mastering the skills that shape tomorrow. From event planning and marketing to management, sponsorships, content creation, and design, we sharpen the tools you need to thrive. We collaborate with top tech colleges across India, bringing you real-world exposure through funding events, startup founder interactions, and deep dives into the startup ecosystem. Here, ideas meet execution—and learners become leaders.",
      'instagram': 'https://www.instagram.com/ecelllnmiit/',
      'email': 'ecell@lnmiit.ac.in',
    },
    {
      'name': 'Phoenix',
      'icon': 'assets/assets/images/tech/phoenix/phoenix_logo.png',
      'subtitle': 'The Robotics Club of LNMIIT',
      'image': 'assets/assets/images/tech/phoenix/phoenix_logo.png',
      'coordinators': _getCoordinators('Phoenix'),
      'gallery': _getGallery('Phoenix'),
      "description": "Phoenix , The Robotics club of LNMIIT Jaipur is a vibrant community of tech enthusiasts committed to hands-on innovation, collaborative problem-solving, and excellence in robotics. We actively design, build, and program intelligent systems while proudly representing our institution in prestigious nationwide competitions, fostering both technical expertise and a spirit of innovation.",
      'instagram': 'https://www.instagram.com/phoenix.lnmiit/',
      'email': 'phoenixclub@lnmiit.ac.in',
    },
    {
      'name': 'Qbit',
      'icon': 'assets/assets/images/tech/qbit/qbit_logo.png',
      'subtitle': 'The Quantum Computing Club of LNMIIT',
      'image': 'assets/assets/images/tech/qbit/qbit_logo.png',
      'coordinators': _getCoordinators('Qbit'),
      'gallery': _getGallery('Qbit'),
      'description': 'The Quantum Computing Club of LNMIIT, Qbit, explores the cutting-edge frontier of quantum algorithms, quantum mechanics, and future computing technologies.',
      'instagram': 'https://www.instagram.com/qbit_lnmiit/',
      'email': 'qbit@lnmiit.ac.in',
    },
    {
      'name': 'Quizzinga',
      'icon': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg',
      'subtitle': 'The Quiz Club of LNMIIT',
      'image': 'assets/assets/images/tech/quizzinga/quizzinga_logo.jpg',
      'coordinators': _getCoordinators('Quizzinga'),
      'gallery': _getGallery('Quizzinga'),
      "description": "We are Quizzinga, The official quizzing club of LNMIIT. Some consider us a cult of nerds (may or may not be true), while others call us a buzzing hivemind of trivia enthusiasts. If you like trivia nights, auctions or winning big prizes, Quizzinga might just be your turf. \nVENI VIDI VICI!!!",
      'instagram': 'https://www.instagram.com/quizzingalnm/',
      'email': 'quizzinga@lnmiit.ac.in',
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
          'SCIENCE & TECH CLUBS',
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
                    'EXPLORE TECH CLUBS',
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
    final String clubDescription = club['description'] as String? ?? '';
    final List<Map<String, String>> coordinators = List<Map<String, String>>.from(
      (club['coordinators'] as List).map(
        (item) => Map<String, String>.from(item as Map),
      ),
    );
    final List<String> galleryImages = List<String>.from(club['gallery'] as List);
    final String clubInstagram = club['instagram'] as String? ?? 'https://instagram.com/${clubName.toLowerCase().replaceAll(' ', '').replaceAll('-', '')}_lnmiit';
    final String clubEmail = club['email'] as String? ?? '${clubName.toLowerCase().replaceAll(' ', '').replaceAll('-', '')}@lnmiit.ac.in';

    void onCardTap() {
      Navigator.pushNamed(
        context,
        '/science_tech_detail',
        arguments: {
          'clubName': clubName,
          'clubImage': clubImage,
          'coordinators': coordinators,
          'galleryImages': galleryImages,
          'description': clubDescription,
          'instagram': clubInstagram,
          'email': clubEmail,
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
