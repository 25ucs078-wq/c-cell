import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/interactive_gallery_viewer.dart';
import '../../widgets/youtube_promo_player.dart';

class DesportivosPage extends StatelessWidget {
  const DesportivosPage({super.key});

  static const List<String> galleryImages = [
    // gallery not updated
    "assets/images/hero_new.jpeg",
    "assets/images/poster.jpeg",
    "assets/images/team_poster.jpeg",
  ];

  static const List<Map<String, String>> festHeads = [
    {"name": "Abhas Chaudhary", "image": "assets/images/logo.jpeg", "role": "Fest Head", "phone": "+919999999999", "email": "desportivos@lnmiit.ac.in"}, // image, phone number not added
    {"name": "Arnav Rinawa", "image": "assets/images/logo.jpeg", "role": "Fest Head", "phone": "+918888888888", "email": "desportivos@lnmiit.ac.in"}, // image, phone number not added
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
          "DESPORTIVOS",
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
                YoutubePromoPlayer(
                  videoId: "eLzT4YhD2o8",
                  fallbackImageUrl: "assets/images/hero_new.jpeg",
                  height: isMobile ? 180 : 260,
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
                        "FEST HEADS",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: isMobile ? 24 : 32,
                          letterSpacing: 2,
                        ),
                      ),
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
                            children: festHeads.map((p) {
                              return SizedBox(
                                width: cardWidth,
                                child: _buildCard(
                                  context,
                                  p['name']!,
                                  p['image']!,
                                  p['role']!,
                                  p['phone'] ?? '',
                                  p['email'] ?? '',
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "PHOTO GALLERY",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: isMobile ? 20 : 24,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 140,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: galleryImages.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 14),
                          itemBuilder: (context, index) {
                            return _buildGalleryImage(context, galleryImages, index);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _buildFestSocialButton(
                            context: context,
                            icon: Icons.camera_alt,
                            label: "Instagram",
                            color: const Color(0xFFE1306C),
                            url: "https://www.instagram.com/desportivos.lnmiit/",
                          ),
                          const SizedBox(width: 12),
                          _buildFestSocialButton(
                            context: context,
                            icon: Icons.play_circle_filled,
                            label: "YouTube",
                            color: const Color(0xFFFF0000),
                            url: "https://www.youtube.com/@desportivoslnmiit2733",
                          ),
                          const SizedBox(width: 12),
                          _buildFestSocialButton(
                            context: context,
                            icon: Icons.language,
                            label: "Website",
                            color: Colors.blueAccent,
                            url: "https://desportivos.lnmiit.ac.in/",
                          ),
                        ],
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

  Widget _buildGalleryImage(BuildContext context, List<String> allImages, int index) {
    final String image = allImages[index];
    return GestureDetector(
      onTap: () => InteractiveGalleryViewer.show(context, allImages, index),
      child: Hero(
        tag: 'gallery_image_${image}_$index',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            image,
            height: 140,
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 220,
                height: 140,
                color: Colors.grey[800],
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.white54,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String name, String image, String role, String phone, String email) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    if (isMobile) {
      return GlassCard(
        borderRadius: BorderRadius.circular(16),
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
      );
    }

    return GlassCard(
      borderRadius: BorderRadius.circular(20),
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

  Widget _buildFestSocialButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required String url,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Expanded(
      child: Container(
        height: 50,
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
          onPressed: () => _launchWebUrl(context, url),
          icon: label.toLowerCase() == 'instagram'
              ? Image.asset(
                  'assets/assets/images/instagram.png',
                  width: isMobile ? 16 : 20,
                  height: isMobile ? 16 : 20,
                )
              : label.toLowerCase() == 'email'
                  ? Image.asset(
                      'assets/assets/images/gmail.png',
                      width: isMobile ? 16 : 20,
                      height: isMobile ? 16 : 20,
                    )
                  : label.toLowerCase() == 'youtube'
                      ? Image.asset(
                          'assets/assets/images/youtube.png',
                          width: isMobile ? 16 : 20,
                          height: isMobile ? 16 : 20,
                        )
                      : Icon(
                          icon,
                          color: color,
                          size: isMobile ? 16 : 20,
                        ),
          label: Text(
            label.toUpperCase(),
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: isMobile ? 10 : 14,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchWebUrl(BuildContext context, String urlString) async {
    final uri = Uri.parse(urlString);
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
}
