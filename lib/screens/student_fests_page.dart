import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_page.dart';

class StudentFestsPage extends StatelessWidget {
  const StudentFestsPage({super.key});

  static const List<Map<String, String>> fests = [
    {
      "name": "Vivacity",
      "logo": "assets/images/logo.jpeg",
      "role": "CULTURAL FEST",
    },
    {
      "name": "Plinth",
      "logo": "assets/images/logo.jpeg",
      "role": "TECH FEST",
    },
    {
      "name": "Desportivos",
      "logo": "assets/images/logo.jpeg",
      "role": "SPORTS FEST",
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
          "STUDENT FESTS",
          style: GoogleFonts.bebasNeue(
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
                "DISCOVER OUR MAJOR FESTS",
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 34,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Three flagship fests that define the student experience at LNMIIT.",
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 30),
              buildFestCards(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFestCards(BuildContext context) {
    return Column(
      children: fests.map((fest) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return ProfilePage(
                      name: fest['name']!,
                      image: fest['logo']!,
                      role: fest['role']!,
                    );
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    final fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
                    return FadeTransition(
                      opacity: fadeAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.45),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(fest['logo']!),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.redAccent, width: 2),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fest['name']!,
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: 28,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            fest['role']!,
                            style: GoogleFonts.poppins(
                              color: Colors.redAccent,
                              fontSize: 16,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
