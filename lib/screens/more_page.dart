import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/glass_card.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  static const List<Map<String, String>> facultyConvenors = [
    {
      "name": "Dr. Usha Kanoongo",
      "image": "assets/assets/images/usha_mam.jpg",
      "role": "FACULTY CONVENOR",
    },
  ];

  static const List<Map<String, String>> mentors = [
    {
      "name": "Aditya Kansal",
      "image": "assets/assets/images/aditya_kansal.webp",
      "role": "TEAM MENTOR",
    },
    {
      "name": "Kunal Sharma",
      "image": "assets/assets/images/kunal_sharma.png",
      "role": "TEAM MENTOR",
    },
    {
      "name": "Neha Raniwala",
      "image": "assets/assets/images/neha_raniwala.jpg",
      "role": "TEAM MENTOR",
    },
  ];

  static const List<Map<String, String>> coordinators = [
    {
      "name": "Krishna Khairnar",
      "image": "assets/images/krishna.png",
      "role": "COORDINATOR",
      "phone": "+918552956224",
      "email": "24dec032@lnmiit.ac.in",
      "instagram": "https://instagram.com/the.whitehairedguy/",
      "linkedin": "https://linkedin.com/in/krishna-khairnar-229291318/",
    },
    {
      "name": "Harshita Jain",
      "image": "assets/images/harshita.png",
      "role": "COORDINATOR",
      "phone": "+919893708722",
      "email": "24ucc111@lnmiit.ac.in",
      "instagram": "https://instagram.com/harshitajain_1812/",
      "linkedin": "https://linkedin.com/in/harshitajain-1812-alegria/",
    },
    {
      "name": "Rahul Sanjay Mukhi",
      "image": "assets/images/rahul.png",
      "role": "COORDINATOR",
      "phone": "+918233531319",
      "email": "24dcs036@lnmiit.ac.in",
      "instagram": "https://instagram.com/_rahul.mukhi_/",
      "linkedin": "https://linkedin.com/in/rahul-sanjay-mukhi-2410b3323/",
    },
  ];

  static const List<Map<String, String>> associates = [
    {
      "name": "Nishra Kothari",
      "image": "assets/images/nishra.png",
      "role": "ASSOCIATE COORDINATOR",
      "phone": "+916300188181",
      "email": "24uec220@lnmiit.ac.in",
      "instagram": "https://instagram.com/nishra_kothari/",
      "linkedin": "https://linkedin.com/in/nishra-kothari-b6735a3a7/",
    },
    {
      "name": "Shashwat Kanoongo",
      "image": "assets/images/shashwat.png",
      "role": "ASSOCIATE COORDINATOR",
      "phone": "+918118829684",
      "email": "24ume092@lnmiit.ac.in",
      "instagram": "https://instagram.com/_shashwat_kanoongo/",
      "linkedin": "https://linkedin.com/in/shashwat-kanoongo-465370370/",
    },
    {
      "name": "Parth Arora",
      "image": "assets/images/parth.png",
      "role": "ASSOCIATE COORDINATOR",
      "phone": "+918949092441",
      "email": "24imai005@lnmiit.ac.in",
      "instagram": "https://instagram.com/parth_arora._/",
      "linkedin": "https://linkedin.com/in/parth-arora19/",
    },
    {
      "name": "Krishangee Tayal",
      "image": "assets/images/krishangee.png",
      "role": "ASSOCIATE COORDINATOR",
      "phone": "+919652156622",
      "email": "24ucc084@lnmiit.ac.in",
      "instagram": "https://instagram.com/krishangeetayal/",
      "linkedin": "https://linkedin.com/in/krishangee-tayal-96a861242/",
    },
    {
      "name": "Yug Nahar",
      "image": "assets/images/yug.png",
      "role": "ASSOCIATE COORDINATOR",
      "phone": "+918079061367",
      "email": "24ucs004@lnmiit.ac.in",
      "instagram": "https://instagram.com/yugnahar/",
      "linkedin": "https://linkedin.com/in/yug-nahar-32538a317/",
    },
    {
      "name": "Plaksha Gulati",
      "image": "assets/images/plaksha.png",
      "role": "ASSOCIATE COORDINATOR",
      "phone": "+917887232545",
      "email": "24ucs242@lnmiit.ac.in",
      "instagram": "https://instagram.com/_.plaksha._/",
      "linkedin": "https://linkedin.com/in/plaksha-gulati-7b8685313/",
    },
  ];

  static const List<Map<String, String>> developers = [

    {
      "name": "Ayush Sharma",
      "image": "assets/images/ayush.jpeg",
      "role": "DEVELOPER",
      "phone": "+918851543730",
      "email": "25ucc140@lnmiit.ac.in",
      "instagram": "https://instagram.com/_ayu_sh95/",
      "linkedin": "https://linkedin.com/in/ayush-sharma-799bba41b/",
    },
    {
      "name": "Dhwani Patel",
      "image": "assets/images/Dhwani.jpeg",
      "role": "DEVELOPER",
      "phone": "+917016339927",
      "email": "25ucs059@lnmiit.ac.in",
      "instagram": "https://instagram.com/dhwani21_/",
    },
    {
      "name": "Harsh Kumar",
      "image": "assets/images/harsh.jpeg",
      "role": "DEVELOPER",
      "phone": "+919431255973",
      "email": "25ucc152@lnmiit.ac.in",
      "instagram": "https://instagram.com/itz_harsh_9000/",
      "linkedin": "https://linkedin.com/in/harsh-kumar-5819b4374/",
    },
    {
      "name": "Khushi Bajaj",
      "image": "assets/images/khushi.jpeg",
      "role": "DEVELOPER",
      "phone": "+918619313133",
      "email": "25ucc178@lnmiit.ac.in",
      "instagram": "https://instagram.com/khushibajaj62/",
    },
    {
      "name": "Kunal Agarwal",
      "image": "assets/images/Kunal.jpeg",
      "role": "DEVELOPER",
      "phone": "+919079359051",
      "email": "kunal@lnmiit.ac.in",
      "instagram": "https://instagram.com/kunal_a_23/",
    },
    {
      "name": "Lavanya Gupta",
      "image": "assets/images/lavanya.jpeg",
      "role": "DEVELOPER",
      "phone": "+918233924320",
      "email": "25ucc069@lnmiit.ac.in",
      "instagram": "https://instagram.com/_lavanyagupta_2008/",
      "linkedin": "https://linkedin.com/in/lavanya-gupta-41251a38b/",
    },
    {
      "name": "Raghav Khandelwal",
      "image": "assets/images/raghav.jpeg",
      "role": "DEVELOPER",
      "phone": "+919950924277",
      "email": "25ucs226@lnmiit.ac.in",
      "instagram": "https://instagram.com/_.raghav_khandelwal._/",
    },
    {
      "name": "Sakshi Jain",
      "image": "assets/images/sakshi.jpeg",
      "role": "DEVELOPER",
      "phone": "+917357558385",
      "email": "25uec231@lnmiit.ac.in",
      "instagram": "https://instagram.com/sakshi_j2908/",
    },
    {
      "name": "Saumya Gaur",
      "image": "assets/images/saumya.jpeg",
      "role": "DEVELOPER",
      "phone": "+919194609093",
      "email": "25uec184@lnmiit.ac.in",
      "instagram": "https://instagram.com/saumya._gaur/",
      "linkedin": "https://linkedin.com/in/saumya-gaur-b60811418/",
    },
    {
      "name": "Vaniya Chopra",
      "image": "assets/images/vaniya.jpeg",
      "role": "DEVELOPER",
      "phone": "+916367492977",
      "email": "25uec079@lnmiit.ac.in",
      "instagram": "https://instagram.com/vaniyachopraa/",
      "linkedin": "https://linkedin.com/in/vaniya-chopra-7b17b53a4/",
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
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                        "Nobody walks LNMIIT alone.\n\nGuiding minds.\nBuilding friendships.\nCreating bonds.",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: isMobile ? 14 : 18,
                          height: 1.7,
                        ),
                      ),
                      SizedBox(height: isMobile ? 30 : 40),
                      buildSectionTitle("FACULTY CONVENOR"),
                      const SizedBox(height: 20),
                      buildResponsiveGrid(facultyConvenors),
                      SizedBox(height: isMobile ? 30 : 40),
                      buildSectionTitle("TEAM MENTORS"),
                      const SizedBox(height: 20),
                      buildResponsiveGrid(mentors),
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
          alignment: WrapAlignment.center,
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
    final String phone = person['phone'] ?? '';
    final String email = person['email'] ?? '';
    final String instagram = person['instagram'] ?? '';
    final String linkedin = person['linkedin'] ?? '';

    final bool enableProfile = role != 'TEAM MENTOR';

    if (isMobile) {
      return GestureDetector(
        onTap: enableProfile
            ? () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                  arguments: {
                    'name': name,
                    'image': image,
                    'role': role,
                    'phone': phone,
                    'email': email,
                    'instagram': instagram,
                    'linkedin': linkedin,
                  },
                );
              }
            : null,
        child: GlassCard(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
              if (phone.isNotEmpty || email.isNotEmpty) ...[
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
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
                ),
                const SizedBox(width: 6),
              ],
              if (enableProfile)
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.redAccent,
                  size: 16,
                ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: enableProfile
          ? () {
              Navigator.pushNamed(
                context,
                '/profile',
                arguments: {
                  'name': name,
                  'image': image,
                  'role': role,
                  'phone': phone,
                  'email': email,
                  'instagram': instagram,
                  'linkedin': linkedin,
                },
              );
            }
          : null,
      child: GlassCard(
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
              padding: const EdgeInsets.all(16),
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    role,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (phone.isNotEmpty || email.isNotEmpty) ...[
                    const SizedBox(height: 14),
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
                  if (enableProfile) ...[
                    const SizedBox(height: 14),
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
                            arguments: {
                              'name': name,
                              'image': image,
                              'role': role,
                              'phone': phone,
                              'email': email,
                              'instagram': instagram,
                              'linkedin': linkedin,
                            },
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
                ],
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
}