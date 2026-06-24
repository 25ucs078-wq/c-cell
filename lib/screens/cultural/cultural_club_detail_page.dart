import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CulturalClubDetailPage extends StatelessWidget {
  final String clubName;
  final String clubImage;
  final List<Map<String, String>> coordinators;
  final List<String> galleryImages;

  const CulturalClubDetailPage({
    super.key,
    required this.clubName,
    required this.clubImage,
    required this.coordinators,
    required this.galleryImages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050816),
        elevation: 0,
        centerTitle: true,
        title: Text(
          clubName.toUpperCase(),
          style: GoogleFonts.playfairDisplay(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  clubImage,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'COORDINATORS',
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 32,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double totalWidth = constraints.maxWidth;
                  final double cardWidth = (totalWidth - 16) / 2;
                  
                  List<Widget> rows = [];
                  int i = 0;
                  
                  // Build rows of 2 coordinators
                  while (i + 1 < coordinators.length) {
                    rows.add(
                      Row(
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: _buildCoordinatorCard(context, coordinators[i]),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: cardWidth,
                            child: _buildCoordinatorCard(context, coordinators[i + 1]),
                          ),
                        ],
                      ),
                    );
                    i += 2;
                  }
                  
                  // If there is an odd one left (e.g. 1st, 3rd, or 5th coordinator), center-align it in the next row
                  if (i < coordinators.length) {
                    rows.add(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: _buildCoordinatorCard(context, coordinators[i]),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  if (rows.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  
                  return Column(
                    children: rows.expand((widget) => [widget, const SizedBox(height: 16)]).toList()..removeLast(),
                  );
                },
              ),
              const SizedBox(height: 30),
              Text(
                'PHOTO GALLERY',
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 24,
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
                    return _buildGalleryImage(galleryImages[index]);
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoordinatorCard(BuildContext context, Map<String, String> person) {
    final String name = person['name'] ?? 'TBD';
    final String role = person['role'] ?? 'Coordinator';
    final String image = person['image'] ?? 'assets/images/logo.jpeg';
    final String phone = person['phone'] ?? '';
    final String email = person['email'] ?? '';

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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFB20710),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(19),
                  bottomRight: Radius.circular(19),
                ),
              ),
              child: Center(
                child: Text(
                  'VIEW PROFILE',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildGalleryImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        image,
        width: 220,
        height: 140,
        fit: BoxFit.cover,
      ),
    );
  }
}
