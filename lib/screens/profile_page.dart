import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String image;
  final String role;
  final String phone;
  final String email;
  final String instagram;
  final String linkedin;

  const ProfilePage({
    super.key,
    required this.name,
    required this.image,
    required this.role,
    this.phone = '',
    this.email = '',
    this.instagram = '',
    this.linkedin = '',
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050816),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "PROFILE",
          style: GoogleFonts.playfairDisplay(
            color: Colors.redAccent,
            fontSize: isMobile ? 20 : 24,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 16 : 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: isMobile ? 160 : 200,
                      height: isMobile ? 160 : 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.redAccent, width: 3.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 4,
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
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white54,
                                  size: isMobile ? 60 : 80,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    role.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: isMobile ? 24 : 32),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isMobile ? 16 : 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "❝",
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.redAccent,
                            fontSize: isMobile ? 48 : 60,
                            height: 0.8,
                          ),
                        ),
                        Text(
                          "Making chaos look\nsurprisingly manageable.",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: isMobile ? 20 : 24),
                        Text(
                          "ABOUT",
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.redAccent,
                            fontSize: isMobile ? 20 : 24,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Helping freshers settle into campus life and ensuring that nobody feels alone during their journey at LNMIIT.",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: isMobile ? 14 : 16,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 24 : 32),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB20710),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.redAccent.withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: phone.isNotEmpty ? () => _launchPhone(context, phone) : null,
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            label: Text(
                              "CALL",
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.white,
                                fontSize: isMobile ? 18 : 20,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white24,
                            ),
                          ),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: email.isNotEmpty ? () => _launchEmail(context, email) : null,
                            icon: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            label: Text(
                              "MAIL",
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.white,
                                fontSize: isMobile ? 18 : 20,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (instagram.isNotEmpty || linkedin.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (instagram.isNotEmpty)
                          _buildSocialButton(
                            context: context,
                            icon: Icons.camera_alt,
                            label: "Instagram",
                            color: const Color(0xFFE1306C),
                            onTap: () => _launchWebUrl(context, instagram),
                          ),
                        if (instagram.isNotEmpty && linkedin.isNotEmpty)
                          const SizedBox(width: 16),
                        if (linkedin.isNotEmpty)
                          _buildSocialButton(
                            context: context,
                            icon: Icons.link,
                            label: "LinkedIn",
                            color: const Color(0xFF0077B5),
                            onTap: () => _launchWebUrl(context, linkedin),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Expanded(
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onTap,
          icon: label.toLowerCase() == 'instagram'
              ? Image.asset(
                  'assets/assets/images/instagram.png',
                  width: 20,
                  height: 20,
                )
              : Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
          label: Text(
            label.toUpperCase(),
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: isMobile ? 14 : 16,
              letterSpacing: 1.2,
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
            content: Text('Unable to open link'),
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

  Future<void> _launchWebUrl(BuildContext context, String urlString) async {
    final uri = Uri.parse(urlString);
    await _launchUrl(context, uri);
  }
}