import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/glass_card.dart';
import '../utils/asset_utils.dart';

class HodsPage extends StatelessWidget {
  const HodsPage({super.key});

  static const List<Map<String, String>> hodsList = [
    {
      "name": "Dr. Rajbir Kaur",
      "department": "Department of CSE",
      "image": "assets/assets/pages/faces/rajbir_kaur.jpg",
      "email": "rajbirkaur@lnmiit.ac.in",
    },
    {
      "name": "Dr. Sunil Kumar",
      "department": "Department of CCE",
      "image": "assets/assets/pages/faces/sunil_kumar.png",
      "email": "sunil@lnmiit.ac.in",
    },
    {
      "name": "Prof. Kusum Lata",
      "department": "Department of ECE",
      "image": "assets/assets/pages/faces/kusum_lata.jpg",
      "email": "kusum@lnmiit.ac.in",
    },
    {
      "name": "Dr. Deepak Rajendra Unune",
      "department": "Department of MME",
      "image": "assets/assets/pages/faces/deepak_rajendra_unune.jpg",
      "email": "deepak.unune@lnmiit.ac.in",
    },
    {
      "name": "Dr. Manish Kumar Singh",
      "department": "Department of Physics",
      "image": "assets/assets/pages/faces/manish_kumar_singh.jpg",
      "email": "mksingh@lnmiit.ac.in",
    },
    {
      "name": "Dr. Harsh Chandrakant Trivedi",
      "department": "Department of Mathematics",
      "image": "assets/assets/pages/faces/harsh_chandrakant_trivedi.jpg",
      "email": "harsh.trivedi@lnmiit.ac.in",
    },
    {
      "name": "Dr. Rajbala Singh",
      "department": "Department of HSS",
      "image": "assets/assets/pages/faces/rajbala_singh.jpg",
      "email": "rajbala@lnmiit.ac.in",
    },
  ];

  Future<void> _launchEmail(BuildContext context, String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $uri';
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open mail client for $email'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

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
          "HEADS OF DEPARTMENTS",
          style: GoogleFonts.playfairDisplay(
            color: Colors.redAccent,
            fontSize: isMobile ? 20 : 34,
            letterSpacing: isMobile ? 2 : 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 20 : 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FACULTY LEADERSHIP",
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 36,
                      letterSpacing: 2,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Heads of Departments shaping academic excellence, innovation, and research at LNMIIT.",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Text(
                      "DEPARTMENT HODs",
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.redAccent,
                        fontSize: isMobile ? 20 : 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                      const SizedBox(height: 24),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double parentWidth = constraints.maxWidth;
                          int crossAxisCount = 1;
                          if (parentWidth >= 1000) {
                            crossAxisCount = 3;
                          } else if (parentWidth >= 600) {
                            crossAxisCount = 2;
                          } else {
                            crossAxisCount = 1;
                          }

                          double cardWidth = (parentWidth - (crossAxisCount - 1) * 20) / crossAxisCount;

                          return Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: hodsList.map((hod) {
                              return SizedBox(
                                width: cardWidth,
                                child: _buildHodCard(context, hod, isMobile),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }

  Widget _buildHodCard(BuildContext context, Map<String, String> hod, bool isMobile) {
    final String name = hod['name']!;
    final String department = hod['department']!;
    final String image = hod['image']!;
    final String email = hod['email']!;

    return GlassCard(
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.redAccent.withValues(alpha: 0.8), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withValues(alpha: 0.25),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: buildCachedImage(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Container(
                    color: Colors.grey[850],
                    child: const Icon(
                      Icons.person,
                      color: Colors.white54,
                      size: 48,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.redAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.redAccent.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              department,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: Colors.redAccent.shade100,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 4,
              shadowColor: Colors.redAccent.withValues(alpha: 0.4),
            ),
            onPressed: () => _launchEmail(context, email),
            icon: const Icon(Icons.email_outlined, size: 18),
            label: Text(
              "Send Email",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
