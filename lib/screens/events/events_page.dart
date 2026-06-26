import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/glass_card.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  static final List<Map<String, dynamic>> campusEvents = [
    {
      'name': 'TEDx LNMIIT',
      'logo': 'assets/assets/images/ted/ted_logo.jpg',
      'image': 'assets/assets/images/ted/ted_logo.jpg',
      'subtitle': 'Forging The Future',
      'description': 'TEDxLNMIIT is an independently organized event that brings together thinkers, innovators, and doers to share inspiring ideas and spark meaningful conversations under the global TED banner.',
      'instagram': 'https://www.instagram.com/tedxlnmiit/',
      'email': 'tedx@lnmiit.ac.in',
      'youtube': 'https://www.youtube.com/@tedxlnmiit',
      'website': 'https://tedx.lnmiit.ac.in/',
      'coordinators': [
        {
          'name': 'Pranav Vashisth',
          'role': 'Organizer',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // photo not added yet
          'phone': '+918445681853',
          'email': '24ucs126@lnmiit.ac.in',
        },
        {
          'name': 'Praneel Dev',
          'role': 'Organizer',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // photo not added yet
          'phone': '+918955352024',
          'email': '24ucs202@lnmiit.ac.in',
        },
        {
          'name': 'Samar Goyal',
          'role': 'Organizer', 
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // photo not added yet
          'phone': '+917300458010',
          'email': '24ucs008@lnmiit.ac.in',
        },
        {
          'name': 'Vedha Meghashyam Sinkar',
          'role': 'Organizer',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // photo not added yet
          'phone': '+919588483298',
          'email': '24ume011@lnmiit.ac.in',
        },
      ],
      'gallery': [
        //galeery has old pics of last year so replace with new ones
        'assets/assets/images/ted/ted1.jpg',
        'assets/assets/images/ted/ted2.jpg',
        'assets/assets/images/ted/ted3.jpg',
        'assets/assets/images/ted/ted4.jpg',
        'assets/assets/images/ted/ted5.jpg',
      ],
    },
    {
      'name': 'E-Summit',
      'logo': 'assets/assets/images/esummit/esummit_logo.jpg',
      'image': 'assets/assets/images/esummit/esummit_logo.jpg',
      'subtitle': 'Promoting Innovation and Startup Culture',
      'description': 'E-Summit is the annual flagship entrepreneurship summit of LNMIIT. It serves as a platform to inspire and empower the next generation of startup founders, showcasing innovations, business pitch fests, and expert panel talks.',
      'instagram': 'https://www.instagram.com/esummit_lnmiit/',
      'coordinators': [
        {
          'name': 'Ayush Agarwal',
          'role': 'E-Summit Head',
          'image': 'assets/assets/images/esummit/ayush.jpeg',
          'phone': '+919876543210',
          'email': 'esummit_organizer1@lnmiit.ac.in',
        },
        {
          'name': 'Farhan Sheikh',
          'role': 'E-Summit Head',
          'image': 'assets/assets/images/esummit/farhan.jpeg',
          'phone': '+919876543210',
          'email': 'esummit_organizer2@lnmiit.ac.in',
        },
        {
          'name': 'Yogya Saraf',
          'role': 'E-Summit Head',
          'image': 'assets/assets/images/esummit/yogya.jpeg',
          'phone': '+919876543210',
          'email': 'esummit_organizer3@lnmiit.ac.in',
        },
        {
          'name': 'Yug Patel',
          'role': 'E-Summit Head',
          'image': 'assets/assets/images/esummit/yug.jpeg',
          'phone': '+919876543210',
          'email': 'esummit_organizer4@lnmiit.ac.in',
        },
      ],
      'gallery': [
        //same as ted replace with new ones
        'assets/assets/images/esummit/esummit1.jpg',
        'assets/assets/images/esummit/esummit2.jpg',
        'assets/assets/images/esummit/esummit3.jpg',
        'assets/assets/images/esummit/esummit4.jpg',
      ],
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
          'EVENTS',
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
                    'EXPLORE EVENTS',
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 32,
                      letterSpacing: isMobile ? 1 : 2,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Discover the major campus events, speaker sessions, and entrepreneurship summits of LNMIIT.',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 30),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double parentWidth = constraints.maxWidth;
                      int crossAxisCount = 1;
                      if (parentWidth >= 1100) {
                        crossAxisCount = 3;
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
                        children: campusEvents.map((event) {
                          return SizedBox(
                            width: cardWidth,
                            child: _buildEventCard(context, event),
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

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final String name = event['name'] as String;
    final String image = event['image'] as String;
    final String logo = event['logo'] as String;
    final String subtitle = event['subtitle'] as String;
    final String description = event['description'] as String? ?? '';
    final List<Map<String, String>> coordinators = List<Map<String, String>>.from(
      (event['coordinators'] as List).map(
        (item) => Map<String, String>.from(item as Map),
      ),
    );
    final List<String> galleryImages = List<String>.from(event['gallery'] as List);
    final String instagram = event['instagram'] as String? ?? '';
    final String email = event['email'] as String? ?? '';
    final String youtube = event['youtube'] as String? ?? '';
    final String website = event['website'] as String? ?? '';

    void onCardTap() {
      Navigator.pushNamed(
        context,
        '/event_detail',
        arguments: {
          'eventName': name,
          'eventImage': image,
          'coordinators': coordinators,
          'galleryImages': galleryImages,
          'description': description,
          'instagram': instagram,
          'email': email,
          'youtube': youtube,
          'website': website,
        },
      );
    }

    if (isMobile) {
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
                    logo,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.event,
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
                      name,
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
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
                        logo,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.event,
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
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                        'VIEW DETAILS',
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
