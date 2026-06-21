import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_page.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  static const List<Map<String, String>> coordinators = [
    {
      "name": "Krishna Khairnar",
      "image": "assets/images/Krishna.jpeg",
      "role": "COORDINATOR",
    },
    {
      "name": "Harshita Jain",
      "image": "assets/images/Harshita.jpeg",
      "role": "COORDINATOR",
    },
    {
      "name": "Rahul Sanjay Mukhi",
      "image": "assets/images/Rahul.jpeg",
      "role": "COORDINATOR",
    },
  ];

  static const List<Map<String, String>> associates = [
    {
      "name": "Nishra Kothari",
      "image": "assets/images/Nishra.jpeg",
      "role": "ASSOCIATE COORDINATOR",
    },
    {
      "name": "Shashwat Kanoongo",
      "image": "assets/images/Shashwat.jpeg",
      "role": "ASSOCIATE COORDINATOR",
    },
    {
      "name": "Yug Nahar",
      "image": "assets/images/Yug.jpeg",
      "role": "ASSOCIATE COORDINATOR",
    },
    {
      "name": "Krishangee Tayal",
      "image": "assets/images/Krishangee.jpeg",
      "role": "ASSOCIATE COORDINATOR",
    },
    {
      "name": "Parth Arora",
      "image": "assets/images/Parth.jpeg",
      "role": "ASSOCIATE COORDINATOR",
    },
    {
      "name": "Plaksha Gulati",
      "image": "assets/images/Plaksha.jpeg",
      "role": "ASSOCIATE COORDINATOR",
    },
  ];

  static const List<Map<String, String>> developers = [
    {
      "name": "Harsh Kumar",
      "image": "assets/images/harsh.jpeg",
      "role": "DEVELOPER",
    },
    {
      "name": "Kunal Agarwal",
      "image": "assets/images/Kunal.jpeg",
      "role": "DEVELOPER",
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
        "C-CELL",
        style: GoogleFonts.playfairDisplay(
          color: Colors.redAccent,
          fontSize: 38,
          letterSpacing: 4,
      ),
    ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
          SizedBox(
  width: double.infinity,
  height: 280,

  child: Stack(
    fit: StackFit.expand,

    children: [

      Image.asset(
        "assets/images/poster.jpeg",
        fit: BoxFit.cover,
      ),

      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [

              Colors.black.withValues(alpha: 0.15),

              Colors.black.withValues(alpha: 0.35),

              const Color(0xFF050816),

            ],
          ),
        ),
      ),
    ],
  ),
),

            Transform.translate(
              offset: const Offset(25, -70),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.redAccent,
                    width: 5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withValues(alpha: 0.5),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                    "assets/images/logo.jpeg",
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

             Text(
              "THE LNM INSTITUTE OF\nINFORMATION TECHNOLOGY",
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 42,
                letterSpacing: 2,
                height: 1.1,
              ),
            ),

                  const SizedBox(height: 25),

                       Text(
                    "Nobody walks LNMIIT alone.\n\nGuiding minds.\nBuilding friendships.\nCreating families.",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 18,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 40),

                  buildSectionTitle("COORDINATORS"),

                  const SizedBox(height: 20),

                  buildHorizontalSlider(coordinators),

                  const SizedBox(height: 40),

                  buildSectionTitle("ASSOCIATE COORDINATORS"),

                  const SizedBox(height: 20),

                  buildHorizontalSlider(associates),

                  const SizedBox(height: 40),

                  buildSectionTitle("DEVELOPERS"),

                  const SizedBox(height: 20),

                  buildHorizontalSlider(developers),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget buildHorizontalSlider(List<Map<String, String>> people) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: people.length,
        itemBuilder: (context, index) {
          return buildPersonCard(
          context,
          people[index]["name"]!,
          people[index]["image"]!,
          people[index]["role"]!,
        );
        },
      ),
    );
  }
 Widget buildPersonCard(
  BuildContext context,
  String name,
  String image,
  String role,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
  context,
  PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 700),

    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) {
      return ProfilePage(
        name: name,
        image: image,
        role: role,
      );
    },

    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {

      final fadeAnimation = Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(animation);

      final slideAnimation = Tween(
        begin: const Offset(0, 0.15),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
      );

      return FadeTransition(
        opacity: fadeAnimation,

        child: SlideTransition(
          position: slideAnimation,
          child: child,
        ),
      );
    },
  ),
);
    },

    child: Container(
      width: 210,
      margin: const EdgeInsets.only(right: 18),

      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        children: [

          const SizedBox(height: 20),

          Hero(
          tag: name,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),

            child: Image.asset(
              image,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),

            child: Text(
              name,
              textAlign: TextAlign.center,

              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Spacer(),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),

            decoration: const BoxDecoration(
              color: Color(0xFFB20710),

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),

            child: Center(
                child: Text(
                "VIEW PROFILE",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}