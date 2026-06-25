import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CouncilsPage extends StatelessWidget {
  const CouncilsPage({super.key});

  static const List<Map<String, dynamic>> councils = [
    {
      'title': 'Presidential Council',
      'icon': 'assets/assets/images/gymkhana_logo.jpg',
      'subtitle': 'Campus leadership and policy',
      'items': [
        {'name': 'Hemendra Yadav', 'role': 'President', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Priyanshu Kumar', 'role': 'Vice President', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Adarsh Mishra', 'role': 'Finance Convenor', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Shashwat Anand', 'role': 'Senate Convenor', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Rishi Raj', 'role': 'COSHA Head', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Dr. Nabyendu Das', 'role': 'Dean of Student Affairs', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Dr. Akash Gupta', 'role': 'Faculty Mentor', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Samar Singh', 'role': 'Assistant Registrar-Student Affairs', 'image': 'assets/images/logo.jpeg'},
      ],
    },
    {
      'title': 'Cultural Council',
      'icon': 'assets/assets/images/cult_logo.jpeg',
      'subtitle': 'Arts, music, and performance',
      'items': [
        {'name': 'Kanishq Singhal', 'role': 'General Secretary', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Ishita Khandelwal', 'role': 'Associate Secretary', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Tanmay Jain', 'role': 'Finance Convenor', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Dr. Joyeeta Singha', 'role': 'Faculty Mentor', 'image': 'assets/images/logo.jpeg'},
      ],
    },
    {
      'title': 'Science & Technology Council',
      'icon': 'assets/assets/images/tech_logo.jpg',
      'subtitle': 'Innovation and technical events',
      'items': [
        {'name': 'Tushar Agrawal', 'role': 'General Secretary', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Anmol Adwani', 'role': 'Associate Secretary', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Devashish Tripathi', 'role': 'Finance Convenor', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Dr. Ashish Kumar Dwivedi', 'role': 'Faculty Mentor', 'image': 'assets/images/logo.jpeg'},
      ],
    },
    {
      'title': 'Sports Council',
      'icon': 'assets/assets/images/sports_logo.jpg',
      'subtitle': 'Competitions and athletics',
      'items': [
        {'name': 'Arihant Bhura', 'role': 'General Secretary', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Priyal Maheshwari', 'role': 'Associate Secretary', 'image': 'assets/images/logo.jpeg'},
        {'name': 'Raghav Khandelwal', 'role': 'Finance Convenor', 'image': 'assets/images/logo.jpeg'},
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
        title: Text(
          'COUNCILS',
          style: GoogleFonts.playfairDisplay(
            color: Colors.redAccent,
            fontSize: isMobile ? 22 : 38,
            letterSpacing: isMobile ? 2 : 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: isMobile ? 16 : 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CHOOSE A COUNCIL',
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
                    children: councils.map((council) {
                      return SizedBox(
                        width: cardWidth,
                        child: _buildCouncilCard(context, council),
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

  Widget _buildCouncilCard(BuildContext context, Map<String, dynamic> council) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final String title = council['title'] as String;
    final String subtitle = council['subtitle'] as String;
    final IconData icon = council['icon'] as IconData;
    final List<Map<String, String>> items = List<Map<String, String>>.from(
      (council['items'] as List).map(
        (item) => Map<String, String>.from(item as Map),
      ),
    );

    void onCardTap() {
      Navigator.pushNamed(
        context,
        '/council_detail',
        arguments: {
          'councilName': title,
          'items': items,
        },
      );
    }

    if (isMobile) {
      // Sleek horizontal list card for mobile app
      return GestureDetector(
        onTap: onCardTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF1A1A1A),
                    border: Border.all(color: Colors.redAccent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withValues(alpha: 0.2),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 28,
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
                        title,
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
        ),
      );
    }

    // Original vertical layout for desktop/web
    return GestureDetector(
      onTap: onCardTap,
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
                      color: const Color(0xFF1A1A1A),
                      border: Border.all(color: Colors.redAccent, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 56,
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
                    title,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
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
