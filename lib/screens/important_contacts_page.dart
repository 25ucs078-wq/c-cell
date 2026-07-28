import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/glass_card.dart';
import '../utils/asset_utils.dart';

class ImportantContactsPage extends StatelessWidget {
  const ImportantContactsPage({super.key});

  static const List<Map<String, String>> contactsList = [
    {
      "name": "Prof. Rahul Banerjee",
      "designation": "Director",
      "image": "assets/assets/pages/faces/rahul_banerjee_2.jpg",
      "email": "registrar@lnmiit.ac.in",
    },
    {
      "name": "Dr. Vikas Gupta",
      "designation": "Dean of Academic Affairs",
      "image": "assets/assets/pages/faces/dr-vikas-gupta.jpg",
      "email": "doaa@lnmiit.ac.in",
    },
    {
      "name": "Dr. Nabyendu Das",
      "designation": "Dean of Student Affairs",
      "image": "assets/assets/pages/faces/nabyendu_das.jpg",
      "email": "dosa@lnmiit.ac.in",
    },
    {
      "name": "Mr. Rajeev Saxena",
      "designation": "Assistant Registrar - Academic Affairs",
      "image": "assets/assets/pages/faces/rajeev_saxena.jpg",
      "email": "dofa@lnmiit.ac.in",
    },
    {
      "name": "Mr. Samar Singh",
      "designation": "Assistant Registrar - Student Affairs",
      "image": "assets/assets/pages/faces/samar_singh.jpg",
      "email": "chief-warden@lnmiit.ac.in",
    },
    {
      "name": "Mr. Devaram Rabri",
      "designation": "Finance Assistant",
      "image": "assets/assets/pages/faces/devaram_rabri.jpg",
      "email": "tpo@lnmiit.ac.in",
    },
    {
      "name": "Dr. Chand Singh Panwar",
      "designation": "Resident Doctor",
      "image": "assets/assets/pages/faces/dr_chand.jpg",
      "email": "coe@lnmiit.ac.in",
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
          "IMPORTANT CONTACTS",
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
                    "KEY ADMINISTRATION",
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 36,
                      letterSpacing: 2,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Key administrative officials and institutional authority contacts at LNMIIT.",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
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
                        children: contactsList.map((contact) {
                          return SizedBox(
                            width: cardWidth,
                            child: _buildContactCard(context, contact, isMobile),
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

  Widget _buildContactCard(BuildContext context, Map<String, String> contact, bool isMobile) {
    final String name = contact['name']!;
    final String designation = contact['designation']!;
    final String image = contact['image']!;
    final String email = contact['email']!;

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
              border: Border.all(color: Colors.tealAccent.withValues(alpha: 0.8), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withValues(alpha: 0.25),
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
                alignment: Alignment.topCenter,
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
              color: Colors.teal.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.tealAccent.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              designation,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: Colors.tealAccent.shade100,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 4,
              shadowColor: Colors.teal.withValues(alpha: 0.4),
            ),
            onPressed: () => _launchEmail(context, email),
            icon: const Icon(Icons.email_outlined, size: 18),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Send Email",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
