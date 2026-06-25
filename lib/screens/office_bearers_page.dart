import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficeBearersPage extends StatelessWidget {
  const OfficeBearersPage({super.key});

  static const List<Map<String, String>> officeBearers = [
    {
      "name": "Hemendra Yadav",
      "image": "assets/images/logo.jpeg",
      "role": "President",
      "phone": "+919999999999",
      "email": "president.sg@lnmiit.ac.in",
    },
    {
      "name": "Priyanshu Kumar",
      "image": "assets/images/logo.jpeg",
      "role": "Vice President",
      "phone": "+918888888888",
      "email": "vp.sg@lnmiit.ac.in",
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
          "OFFICE BEARERS",
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
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/team_poster.jpeg",
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
                        "MEET THE TEAM BEHIND THE STUDENT GYMKHANA",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: isMobile ? 24 : 36,
                          letterSpacing: 2,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "These student leaders shape campus life and keep the community moving.",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: isMobile ? 14 : 18,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 30),
                      buildSectionTitle("OFFICE BEARERS"),
                      const SizedBox(height: 20),
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
                            children: officeBearers.map((bearer) {
                              return SizedBox(
                                width: cardWidth,
                                child: buildPersonCard(context, bearer),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
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

  Widget buildPersonCard(BuildContext context, Map<String, String> bearer) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final String name = bearer['name']!;
    final String image = bearer['image']!;
    final String role = bearer['role']!;
    final String phone = bearer['phone'] ?? '';
    final String email = bearer['email'] ?? '';

    if (isMobile) {
      return Container(
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContactButton(
                    context: context,
                    icon: Icons.phone,
                    isEnabled: phone.isNotEmpty,
                    tooltip: 'Call',
                    onTap: () => _launchPhone(context, phone),
                  ),
                  const SizedBox(width: 4),
                  _buildContactButton(
                    context: context,
                    icon: Icons.email,
                    isEnabled: email.isNotEmpty,
                    tooltip: 'Email',
                    onTap: () => _launchEmail(context, email),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Hero(
              tag: name,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(19),
                  topRight: Radius.circular(19),
                ),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
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
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.redAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContactButton(
                      context: context,
                      icon: Icons.phone,
                      isEnabled: phone.isNotEmpty,
                      tooltip: 'Call',
                      onTap: () => _launchPhone(context, phone),
                    ),
                    const SizedBox(width: 8),
                    _buildContactButton(
                      context: context,
                      icon: Icons.email,
                      isEnabled: email.isNotEmpty,
                      tooltip: 'Email',
                      onTap: () => _launchEmail(context, email),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required BuildContext context,
    required IconData icon,
    required bool isEnabled,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: isEnabled ? onTap : null,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEnabled 
                  ? Colors.redAccent.withValues(alpha: 0.1) 
                  : Colors.white10,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isEnabled ? Colors.redAccent : Colors.white30,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, Uri uri) async {
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $uri';
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open contact'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _launchPhone(BuildContext context, String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    await _launchUrl(context, uri);
  }

  Future<void> _launchEmail(BuildContext context, String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    await _launchUrl(context, uri);
  }
}
