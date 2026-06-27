import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/interactive_gallery_viewer.dart';

class EventDetailPage extends StatelessWidget {
  final String eventName;
  final String eventImage;
  final List<Map<String, String>> coordinators;
  final List<String> galleryImages;
  final String description;
  final String instagram;
  final String email;
  final String youtube;
  final String website;

  const EventDetailPage({
    super.key,
    required this.eventName,
    required this.eventImage,
    required this.coordinators,
    required this.galleryImages,
    required this.description,
    this.instagram = '',
    this.email = '',
    this.youtube = '',
    this.website = '',
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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          eventName.toUpperCase(),
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 20,
                vertical: isMobile ? 16 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: isMobile ? 120 : 180,
                      height: isMobile ? 120 : 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.redAccent, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withValues(alpha: 0.3),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          eventImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.white54,
                                size: isMobile ? 48 : 64,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 24 : 32),
                  // Event Description
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: isMobile ? 28 : 36),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double parentWidth = constraints.maxWidth;
                      int crossAxisCount = 1;
                      if (parentWidth >= 900) {
                        crossAxisCount = 4;
                      } else if (parentWidth >= 600) {
                        crossAxisCount = 2;
                      } else {
                        crossAxisCount = 1;
                      }

                      // Calculate item width dynamically
                      double cardWidth = (parentWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: coordinators.map((person) {
                          return SizedBox(
                            width: cardWidth,
                            child: _buildCoordinatorCard(context, person),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'PHOTO GALLERY',
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
                  if (instagram.isNotEmpty || email.isNotEmpty || youtube.isNotEmpty || website.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.start,
                      children: [
                        if (instagram.isNotEmpty)
                          _buildEventSocialButton(
                            context: context,
                            icon: Icons.camera_alt,
                            label: "Instagram",
                            color: const Color(0xFFE1306C),
                            onTap: () => _launchWebUrl(context, instagram),
                          ),
                        if (email.isNotEmpty)
                          _buildEventSocialButton(
                            context: context,
                            icon: Icons.email,
                            label: "Email",
                            color: Colors.redAccent,
                            onTap: () => _launchEmail(context, email),
                          ),
                        if (youtube.isNotEmpty)
                          _buildEventSocialButton(
                            context: context,
                            icon: Icons.play_circle_filled,
                            label: "YouTube",
                            color: const Color(0xFFFF0000),
                            onTap: () => _launchWebUrl(context, youtube),
                          ),
                        if (website.isNotEmpty)
                          _buildEventSocialButton(
                            context: context,
                            icon: Icons.language,
                            label: "Website",
                            color: Colors.blueAccent,
                            onTap: () => _launchWebUrl(context, website),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoordinatorCard(BuildContext context, Map<String, String> person) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final String name = person['name'] ?? 'TBD';
    final String role = person['role'] ?? 'Organizer';
    final String image = person['image'] ?? 'assets/images/logo.jpeg';
    final String phone = person['phone'] ?? '';
    final String email = person['email'] ?? '';

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildContactButton(
                      context: context,
                      icon: Icons.phone,
                      isEnabled: phone.isNotEmpty,
                      tooltip: 'Call',
                      onTap: () => _launchPhone(context, phone),
                    ),
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

  Widget _buildEventSocialButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Container(
      height: 48,
      constraints: BoxConstraints(
        minWidth: isMobile ? 100 : 140,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onTap,
        icon: label.toLowerCase() == 'instagram'
            ? Image.asset(
                'assets/assets/images/instagram.png',
                width: 18,
                height: 18,
              )
            : label.toLowerCase() == 'email'
                ? Image.asset(
                    'assets/assets/images/gmail.png',
                    width: 18,
                    height: 18,
                  )
                : label.toLowerCase() == 'youtube'
                    ? Image.asset(
                        'assets/assets/images/youtube.png',
                        width: 18,
                        height: 18,
                      )
                    : Icon(
                        icon,
                        color: color,
                        size: 18,
                      ),
        label: Text(
          label.toUpperCase(),
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: isMobile ? 12 : 14,
            letterSpacing: 1.0,
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
