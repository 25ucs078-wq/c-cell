import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

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
            fontSize: isMobile ? 22 : 38,
            letterSpacing: isMobile ? 2 : 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: isMobile ? 180 : 280,
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
                  offset: Offset(isMobile ? 16 : 25, isMobile ? -45 : -70),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.redAccent,
                        width: isMobile ? 3 : 5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withValues(alpha: 0.5),
                          blurRadius: isMobile ? 15 : 25,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: isMobile ? 40 : 60,
                      backgroundImage: const AssetImage(
                        "assets/images/logo.jpeg",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "THE LNM INSTITUTE OF\nINFORMATION TECHNOLOGY",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: isMobile ? 24 : 42,
                          letterSpacing: 2,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 25),
                      Text(
                        "Nobody walks LNMIIT alone.\n\nGuiding minds.\nBuilding friendships.\nCreating families.",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: isMobile ? 14 : 18,
                          height: 1.7,
                        ),
                      ),
                      SizedBox(height: isMobile ? 30 : 40),
                      buildSectionTitle("COORDINATORS"),
                      const SizedBox(height: 20),
                      buildResponsiveGrid(coordinators),
                      SizedBox(height: isMobile ? 30 : 40),
                      buildSectionTitle("ASSOCIATE COORDINATORS"),
                      const SizedBox(height: 20),
                      buildResponsiveGrid(associates),
                      SizedBox(height: isMobile ? 30 : 40),
                      buildSectionTitle("DEVELOPERS"),
                      const SizedBox(height: 20),
                      buildResponsiveGrid(developers),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
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

  Widget buildResponsiveGrid(List<Map<String, String>> people) {
    return LayoutBuilder(
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
          children: people.map((person) {
            return SizedBox(
              width: cardWidth,
              child: buildPersonCard(context, person),
            );
          }).toList(),
        );
      },
    );
  }

  Widget buildPersonCard(BuildContext context, Map<String, String> person) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final String name = person['name']!;
    final String image = person['image']!;
    final String role = person['role']!;

    if (isMobile) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/profile',
            arguments: {'name': name, 'image': image, 'role': role},
          );
        },
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
                    border: Border.all(color: Colors.redAccent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withValues(alpha: 0.2),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: name,
                    child: ClipOval(
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.person,
                              color: Colors.white54,
                              size: 24,
                            ),
                          );
                        },
                      ),
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
                        role,
                        style: GoogleFonts.poppins(
                          color: Colors.redAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
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

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/profile',
          arguments: {'name': name, 'image': image, 'role': role},
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
                    child: Hero(
                      tag: name,
                      child: ClipOval(
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.person,
                                color: Colors.white54,
                                size: 50,
                              ),
                            );
                          },
                        ),
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
                    role,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
                          '/profile',
                          arguments: {'name': name, 'image': image, 'role': role},
                        );
                      },
                      child: Text(
                        'VIEW PROFILE',
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