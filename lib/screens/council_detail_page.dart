import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
                                child: _buildItemCard(
                                  context,
                                  item['name']!,
                                  item['role']!,
                                  item['image']!,
                                  item['phone'] ?? '',
                                  item['email'] ?? '',
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      if (councilName.toLowerCase() == 'cultural council') ...[
                        const SizedBox(height: 30),
                        Center(
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildActionButton(
                                context: context,
                                text: 'Clubs',
                                icon: Icons.palette_outlined,
                                route: '/cultural',
                              ),
                              _buildActionButton(
                                context: context,
                                text: 'Fest',
                                icon: Icons.festival_outlined,
                                route: '/vivacity',
                              ),
                            ],
                          ),
                        ),
                      ] else if (councilName.toLowerCase() == 'science & technology council') ...[
                        const SizedBox(height: 30),
                        Center(
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildActionButton(
                                context: context,
                                text: 'Clubs',
                                icon: Icons.computer_outlined,
                                route: '/science_tech',
                              ),
                              _buildActionButton(
                                context: context,
                                text: 'Fest',
                                icon: Icons.festival_outlined,
                                route: '/plinth',
                              ),
                            ],
                          ),
                        ),
                      ] else if (councilName.toLowerCase() == 'sports council') ...[
                        const SizedBox(height: 30),
                        Center(
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildActionButton(
                                context: context,
                                text: 'Clubs',
                                icon: Icons.sports_basketball_outlined,
                                route: '/sports',
                              ),
                              _buildActionButton(
                                context: context,
                                text: 'Fest',
                                icon: Icons.festival_outlined,
                                route: '/desportivos',
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildItemCard(BuildContext context, String name, String role, String image, String phone, String email) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

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

  Widget _buildActionButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required String route,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return SizedBox(
      width: isMobile ? 140 : 180,
      height: isMobile ? 48 : 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
        ).copyWith(
          elevation: WidgetStateProperty.all(0),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.redAccent.withValues(alpha: 0.1),
                Colors.redAccent.withValues(alpha: 0.25),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: isMobile ? 18 : 22),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
