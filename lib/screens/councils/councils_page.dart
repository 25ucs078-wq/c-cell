import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/glass_card.dart';

class CouncilsPage extends StatelessWidget {
  const CouncilsPage({super.key});

  static const List<Map<String, dynamic>> councils = [
    {
      'title': 'Presidential Council',
      'icon': 'assets/assets/images/gymkhana.jpg',
      'subtitle': 'Campus leadership and policy',
      'items': [
        {'name': 'Hemendra Yadav', 'role': 'President', 'image': 'assets/images/logo.jpeg', 'phone': '+919999999999', 'email': 'gym.president@lnmiit.ac.in'}, // phone number not added
        {'name': 'Priyanshu Kumar', 'role': 'Vice President', 'image': 'assets/images/logo.jpeg', 'phone': '+918888888888', 'email': 'gym.vicepresident@lnmiit.ac.in'}, // phone number not added
        {'name': 'Adarsh Mishra', 'role': 'Finance Convenor', 'image': 'assets/images/logo.jpeg', 'phone': '+917777777777', 'email': 'gym.financeconvenor@lnmiit.ac.in'}, // phone number not added
        {'name': 'Shashwat Anand', 'role': 'Senate Convenor', 'image': 'assets/images/logo.jpeg', 'phone': '+916666666666', 'email': 'gym.senateconvenor@lnmiit.ac.in'}, // phone number not added
        {'name': 'Rishi Raj', 'role': 'COSHA Head', 'image': 'assets/images/logo.jpeg', 'phone': '+915555555555', 'email': 'cosha@lnmiit.ac.in'}, // phone number not added
        {'name': 'Dr. Nabyendu Das', 'role': 'Dean of Student Affairs', 'image': 'assets/images/logo.jpeg', 'phone': '+914444444444', 'email': 'dean.students@lnmiit.ac.in'}, // phone number not added
        {'name': 'Dr. Akash Gupta', 'role': 'Faculty Mentor', 'image': 'assets/images/logo.jpeg', 'phone': '+913333333333', 'email': 'akash.gupta@lnmiit.ac.in'}, // phone number not added
        {'name': 'Samar Singh', 'role': 'Assistant Registrar-Student Affairs', 'image': 'assets/images/logo.jpeg', 'phone': '+912222222222', 'email': 'arss@lnmiit.ac.in'},  // phone number not added
      ],
    },
    {
      'title': 'Cultural Council',
      'icon': 'assets/assets/images/cult_logo.jpeg',
      'subtitle': 'Arts, music, and performance',
      'items': [
        {'name': 'Kanishq Singhal', 'role': 'General Secretary', 'image': 'assets/images/logo.jpeg', 'phone': '+919999999999', 'email': 'gsec.cultural@lnmiit.ac.in'}, // phone number not added
        {'name': 'Ishita Khandelwal', 'role': 'Associate Secretary', 'image': 'assets/images/logo.jpeg', 'phone': '+918888888888', 'email': 'assoc.cultural@lnmiit.ac.in'}, // phone number and email not added
        {'name': 'Tanmay Jain', 'role': 'Finance Convenor', 'image': 'assets/images/logo.jpeg', 'phone': '+917777777777', 'email': 'finance.cultural@lnmiit.ac.in'}, // phone number and email not added
        {'name': 'Dr. Joyeeta Singha', 'role': 'Faculty Mentor', 'image': 'assets/images/logo.jpeg', 'phone': '+916666666666', 'email': 'joyeeta.singha@lnmiit.ac.in'}, // phone number and email not added
      ],
    },
    {
      'title': 'Science & Technology Council',
      'icon': 'assets/assets/images/tech_logo.jpg',
      'subtitle': 'Innovation and technical events',
      'items': [
        {'name': 'Tushar Agrawal', 'role': 'General Secretary', 'image': 'assets/images/logo.jpeg', 'phone': '+919999999999', 'email': 'gsec.science@lnmiit.ac.in'}, // phone number not added
        {'name': 'Anmol Adwani', 'role': 'Associate Secretary', 'image': 'assets/images/logo.jpeg', 'phone': '+918888888888', 'email': 'assoc.science@lnmiit.ac.in'}, // phone number and email not added
        {'name': 'Devashish Tripathi', 'role': 'Finance Convenor', 'image': 'assets/images/logo.jpeg', 'phone': '+917777777777', 'email': 'finance.science@lnmiit.ac.in'}, // phone number and email not added
        {'name': 'Dr. Ashish Kumar Dwivedi', 'role': 'Faculty Mentor', 'image': 'assets/images/logo.jpeg', 'phone': '+916666666666', 'email': 'ashish@lnmiit.ac.in'}, // phone number and email not added
      ],
    },
    {
      'title': 'Sports Council',
      'icon': 'assets/assets/images/sports_logo.jpg',
      'subtitle': 'Competitions and athletics',
      'items': [
        {'name': 'Arihant Bhura', 'role': 'General Secretary', 'image': 'assets/images/logo.jpeg', 'phone': '+919999999999', 'email': 'gsec.sports@lnmiit.ac.in'}, // phone number not added
        {'name': 'Priyal Maheshwari', 'role': 'Associate Secretary', 'image': 'assets/images/logo.jpeg', 'phone': '+918888888888', 'email': 'assoc.sports@lnmiit.ac.in'}, // phone number and email not added
        {'name': 'Raghav Khandelwal', 'role': 'Finance Convenor', 'image': 'assets/images/logo.jpeg', 'phone': '+917777777777', 'email': 'finance.sports@lnmiit.ac.in'}, // phone number and email not added
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
    final String icon = council['icon'] as String;
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
                child: ClipOval(
                  child: Image.asset(
                    icon,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.group,
                          color: Colors.white,
                          size: 28,
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
                    child: ClipOval(
                      child: Image.asset(
                        icon,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.group,
                              color: Colors.white,
                              size: 70,
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
