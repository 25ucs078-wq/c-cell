import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/glass_card.dart';

class HostelContactsPage extends StatelessWidget {
  const HostelContactsPage({super.key});

  static const List<Map<String, dynamic>> hostelSections = [
    {
      "sectionTitle": "Administration",
      "contacts": [
        {
          "name": "Dr. Servesh Kumar Agnihotri",
          "designation": "Chief Warden",
          "image": "assets/images/logo.jpeg",
          "email1": "chief-warden@lnmiit.ac.in",
        },
        {
          "name": " Dr. Vikas Sharma",
          "designation": "Associate Chief Warden & Mess Warden",
          "image": "assets/images/logo.jpeg",
          "email1": "cwoffice@lnmiit.ac.in",
        },
        {
          "name": "Dr. Poonam Gera",
          "designation": "Warden - Girls Hostel",
          "image": "assets/images/logo.jpeg",
          "email1": "warden-gh@lnmiit.ac.in",
        },
        {
          "name": "Mr. Parvez Ahmed",
          "designation": "Assistant Warden – Boy’s Hostel",
          "image": "assets/images/logo.jpeg",
          "email1": "asst.warden.bh1@lnmiit.ac.in",
          "email2": "asst.warden.bh2@lnmiit.ac.in",
          
        },
        {
          "name": "Dr. Poonam Gera",
          "designation": "Warden - Girls Hostel",
          "image": "assets/images/logo.jpeg",
          "email": "warden-gh@lnmiit.ac.in",
        },
      ],
    },
    {
      "sectionTitle": "Boys Hostel 1 (BH-1)",
      "contacts": [
        {
          "name": "BH1",
          "image": "assets/images/logo.jpeg",
          "phone1": "+91 141 2688128",
        },
        {
          "name": "Mr. Namo Narayan Meena",
          "designation": "Jr. Hostel Superintendent BH1",
          "image": "assets/assets/pages/faces/namo_narayan_meena.jpg",
          "email": "jhs-bh1@lnmiit.ac.in",
          "phone1": "+91 141 3526145",
          "phone2": "+917851948930",
        },
        {
          "name": "Mr. Prahlad Sharma",
          "designation": "Hostel Support BH1",
          "image": "assets/assets/pages/faces/prahlad_sharma.jpg",
          "email": "bh1-support@lnmiit.ac.in",
          "phone1": "+91 141 3526145",
          "phone2": "+917851948930",
        },
        {
          "name": "Mr. Kajor Meena",
          "designation": "Hostel Support BH1",
          "image": "assets/images/logo.jpeg",
          "email": "bh1-support@lnmiit.ac.in",
          "phone1": "+91 141 3526145",
          "phone2": "+917851948930",
        },
        {
          "name": "Mr. Abhishek Sharma",
          "designation": "Hostel Support BH1",
          "image": "assets/images/logo.jpeg",
          "email": "bh1-support@lnmiit.ac.in",
          "phone1": "+91 141 3526145",
          "phone2": "+917851948930",
        },
      ],
    },
    {
      "sectionTitle": "Boys Hostel 2 (BH-2)",
      "contacts": [
        {
          "name": "BH2",
          "image": "assets/images/logo.jpeg",
          "phone1": "+91 141 2688129",
        },
        {
          "name": "Mr. Namo Narayan Meena",
          "designation": "Jr. Hostel Superintendent BH2",
          "image": "assets/assets/pages/faces/namo_narayan_meena.jpg",
          "email": "jhs-bh2@lnmiit.ac.in",
          "phone1": "+91 141 3526148",
          "phone2": "+917852824457",
        },
        {
          "name": "Mr. Kamlesh Kumar Meena",
          "designation": "Hostel Support BH2",
          "image": "assets/images/logo.jpeg",
          "email": "bh2-support@lnmiit.ac.in",
          "phone1": "+91 141 3526148",
          "phone2": "+917852824457",
        },
        {
          "name": "Mr. Suresh Chand Danka",
          "designation": "Hostel Support BH2",
          "image": "assets/images/logo.jpeg",
          "email": "bh2-support@lnmiit.ac.in",
          "phone1": "+91 141 3526148",
          "phone2": "+917852824457",
        }
      ],
    },
    {
      "sectionTitle": "Boys Hostel 3 (BH-3)",
      "contacts": [
        {
          "name": "BH3",
          "image": "assets/images/logo.jpeg",
          "phone1": "+91 141 2688130",
        },
        {
          "name": "Mr. Ghanshyam Sharma",
          "designation": "Jr. Hostel Superintendent BH3",
          "image": "assets/images/logo.jpeg",
          "email": "jhs-bh3@lnmiit.ac.in",
          "phone1": "+91 141 3526151",
          "phone2": "+917852833867",
        },
        {
          "name": "Mr. Rahul Sharma",
          "designation": "Hostel Support BH3",
          "image": "assets/images/logo.jpeg",
          "email": "bh3-support@lnmiit.ac.in",
          "phone1": "+91 141 3526151",
          "phone2": "+917852833867",
        },
        {
          "name": "Mr. Ram Kumar Singh",
          "designation": "Hostel Support BH3",
          "image": "assets/images/logo.jpeg",
          "email": "bh3-support@lnmiit.ac.in",
          "phone1": "+91 141 3526151",
          "phone2": "+917852833867",
        },
        {
          "name": "Mr. Madhu Sudan Sharma",
          "designation": "Hostel Support BH3",
          "image": "assets/images/logo.jpeg",
          "email": "bh3-support@lnmiit.ac.in",
          "phone1": "+91 141 3526151",
          "phone2": "+917852833867",
        },
      ],
    },
    {
      "sectionTitle": "Boys Hostel 4 (BH-4)",
      "contacts": [
        {
          "name": "BH4",
          "image": "assets/images/logo.jpeg",
          "phone1": "+91 141 2688131",
        },
        {
          "name": "Mr. Ghanshyam Sharma",
          "designation": "Jr. Hostel Superintendent BH4",
          "image": "assets/images/logo.jpeg",
          "email": "jhs-bh4@lnmiit.ac.in",
          "phone1": "+91 141 3526153",
          "phone2": "+917852832339",
        },
        {
          "name": "Mr. Praveen Kumar Danka",
          "designation": "Hostel Support BH4",
          "image": "assets/images/logo.jpeg",
          "email": "bh4-support@lnmiit.ac.in",
          "phone1": "+91 141 3526153",
          "phone2": "+917852832339",
        },
        {
          "name": "Mr. Manoj Kumar Pancholi",
          "designation": "Hostel Support BH4",
          "image": "assets/images/logo.jpeg",
          "email": "bh4-support@lnmiit.ac.in",
          "phone1": "+91 141 3526153",
          "phone2": "+917852832339",
        },
      ],
    },
    {
      "sectionTitle": "Girls Hostel",
      "contacts": [
        {
          "name": "Girls Hostel",
          "image": "assets/images/logo.jpeg",
          "phone1": "+91 141 2688132",
        },
        {
          "name": "Dr. Poonam Gera",
          "designation": "GH Warden",
          "image": "assets/assets/pages/faces/poonam_gera.jpg",
          "email": "warden-gh@lnmiit.ac.in",
          "phone1": "+91 141 3526225",
        },
        {
          "name": "Mrs. Sakshi Sharma",
          "designation": "Hostel Support GH",
          "image": "assets/images/logo.jpeg",
          "email": "gh-support@lnmiit.ac.in",
          "phone1": "+91 141 3526158",
          "phone2": "+917851941316",
        },
        {
          "name": "Mrs. Pankesh Sharma",
          "designation": "Hostel Support GH",
          "image": "assets/images/logo.jpeg",
          "email": "gh-support@lnmiit.ac.in",
          "phone1": "+91 141 3526158",
          "phone2": "+917851941316",
        },
        {
          "name": "Mrs. Manju Kunwar",
          "designation": "Hostel Support GH",
          "image": "assets/images/logo.jpeg",
          "email": "gh-support@lnmiit.ac.in",
          "phone1": "+91 141 3526158",
          "phone2": "+917851941316",
        },
      ],
    },
    {
      "sectionTitle": "Pre FEB Building",
      "contacts": [
        {
          "name": "Dr. Poonam Gera",
          "designation": "GH Warden",
          "image": "assets/assets/pages/faces/poonam_gera.jpg",
          "email": "warden-gh@lnmiit.ac.in",
          "phone1": "+91 141 3526225",
        },
      ],
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

  Future<void> _launchPhone(BuildContext context, String phoneNumber) async {
    final String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri uri = Uri(scheme: 'tel', path: cleanNumber);
    try {
      if (!await launchUrl(uri)) {
        throw 'Could not launch $uri';
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not initiate call to $phoneNumber'),
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
          "HOSTEL CONTACTS",
          style: GoogleFonts.playfairDisplay(
            color: Colors.orangeAccent,
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
                    "HOSTEL ADMINISTRATION",
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 36,
                      letterSpacing: 2,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Wardens, caretakers, and administration contacts across all LNMIIT hostels.",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ...hostelSections.map((section) {
                    final String sectionTitle = section['sectionTitle'];
                    final List<Map<String, String>> contacts =
                        List<Map<String, String>>.from(section['contacts']);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.orangeAccent.withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            sectionTitle.toUpperCase(),
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.orangeAccent,
                              fontSize: isMobile ? 18 : 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
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

                            double cardWidth =
                                (parentWidth - (crossAxisCount - 1) * 20) / crossAxisCount;

                            return Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: contacts.map((contact) {
                                return SizedBox(
                                  width: cardWidth,
                                  child: _buildContactCard(context, contact, isMobile),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, Map<String, String> contact, bool isMobile) {
    final String name = contact['name'] ?? '';
    final String? designation = contact['designation'];
    final String image = contact['image'] ?? 'assets/images/logo.jpeg';
    
    String? email1 = contact['email1'] ?? contact['email'];
    String? email2 = contact['email2'];

    if (email1 != null && email2 == null && (email1.contains(',') || email1.contains(';'))) {
      final parts = email1.split(RegExp(r'[,;]'));
      if (parts.length >= 2) {
        email1 = parts[0].trim();
        email2 = parts[1].trim();
      }
    }

    final String? phone1 = contact['phone1'];
    final String? phone2 = contact['phone2'];

    final bool hasDesignation = designation != null && designation.trim().isNotEmpty;
    final bool hasEmail1 = email1 != null && email1.trim().isNotEmpty;
    final bool hasEmail2 = email2 != null && email2.trim().isNotEmpty;
    final bool hasPhone1 = phone1 != null && phone1.trim().isNotEmpty;
    final bool hasPhone2 = phone2 != null && phone2.trim().isNotEmpty;

    return GlassCard(
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orangeAccent.withValues(alpha: 0.8), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.25),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[850],
                    child: const Icon(
                      Icons.person,
                      color: Colors.white54,
                      size: 44,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (hasDesignation) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orangeAccent.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                designation,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.orangeAccent.shade100,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          if (hasEmail1 && hasEmail2) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () => _launchEmail(context, email1!),
                    icon: const Icon(Icons.email_outlined, size: 14),
                    label: Text(
                      "Email 1",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () => _launchEmail(context, email2!),
                    icon: const Icon(Icons.email_outlined, size: 14),
                    label: Text(
                      "Email 2",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else if (hasEmail1 || hasEmail2) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                onPressed: () => _launchEmail(context, (hasEmail1 ? email1 : email2)!),
                icon: const Icon(Icons.email_outlined, size: 16),
                label: Text(
                  "Send Email",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
          if ((hasEmail1 || hasEmail2) && (hasPhone1 || hasPhone2)) const SizedBox(height: 10),
          if (!(hasEmail1 || hasEmail2) && (hasPhone1 || hasPhone2)) const SizedBox(height: 16),
          if (hasPhone1 && hasPhone2)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.orangeAccent,
                      side: BorderSide(color: Colors.orangeAccent.withValues(alpha: 0.7)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _launchPhone(context, phone1),
                    icon: const Icon(Icons.call, size: 14),
                    label: Text(
                      "Call 1",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.amberAccent,
                      side: BorderSide(color: Colors.amberAccent.withValues(alpha: 0.7)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _launchPhone(context, phone2),
                    icon: const Icon(Icons.phone_in_talk, size: 14),
                    label: Text(
                      "Call 2",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else if (hasPhone1 || hasPhone2)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orangeAccent,
                  side: BorderSide(color: Colors.orangeAccent.withValues(alpha: 0.7)),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => _launchPhone(context, (hasPhone1 ? phone1 : phone2)!),
                icon: const Icon(Icons.call, size: 14),
                label: Text(
                  "Call",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
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
