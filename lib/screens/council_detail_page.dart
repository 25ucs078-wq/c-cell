import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CouncilDetailPage extends StatelessWidget {
  final String councilName;
  final List<Map<String, String>> items;

  const CouncilDetailPage({super.key, required this.councilName, required this.items});

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
          councilName.toUpperCase(),
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
                  height: isMobile ? 180 : 260,
                  child: Image.asset(
                    "assets/images/poster.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 20,
                    vertical: isMobile ? 16 : 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EXPLORE $councilName",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: isMobile ? 24 : 32,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "A closer look at the people and activities that define $councilName.",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: isMobile ? 14 : 16,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),
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
                            children: items.map((item) {
                              return SizedBox(
                                width: cardWidth,
                                child: _buildItemCard(context, item['name']!, item['role']!, item['image']!),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
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

  Widget _buildItemCard(BuildContext context, String name, String role, String image) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

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
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
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
                  Icons.chevron_right,
                  color: Colors.white54,
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
