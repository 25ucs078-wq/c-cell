import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; 

class NotesPyqsPage extends StatefulWidget {
  const NotesPyqsPage({super.key});

  @override
  State<NotesPyqsPage> createState() => _NotesPyqsPageState();
}

class _NotesPyqsPageState extends State<NotesPyqsPage> {
  int hoveredCard = -1;

  // 2. Function to safely launch Google Drive URLs
  Future<void> _launchDriveURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication, 
        );
      } else {
        debugPrint("Could not launch $urlString");
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }

  Widget semesterCard(
    int index,
    Color accentColor,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    bool isHovered = hoveredCard == index;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 550),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: MouseRegion(
          onEnter: (_) => setState(() => hoveredCard = index),
          onExit: (_) => setState(() => hoveredCard = -1),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              height: 72,
              decoration: BoxDecoration(
                color: isHovered ? const Color(0xff161A33) : const Color(0xff0F1123),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isHovered ? accentColor : const Color(0xff1E2243).withOpacity(0.6),
                  width: 1.2,
                ),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: accentColor.withOpacity(0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: accentColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedPadding(
                    padding: EdgeInsets.only(left: isHovered ? 8.0 : 0.0),
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: isHovered ? accentColor : Colors.white54,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090B18),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F1123),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xff1E2243),
            width: 1,
          ),
        ),
        title: Text(
          "Notes / PYQs",
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            semesterCard(
              1,
              const Color(0xff3B82F6),
              Icons.menu_book_rounded,
              "Semester 1",
              () {
                _launchDriveURL("https://drive.google.com/drive/folders/1R8MWh7VAa1TAMuv2pTFzVQh_u1ALcx9y?usp=drive_link");
              },
            ),
            semesterCard(
              2,
              const Color(0xffA855F7),
              Icons.auto_stories_rounded,
              "Semester 2",
              () {
                _launchDriveURL("https://drive.google.com/drive/folders/1CYAcO9cEk8r8bQwXmsHF8dvxXme80D8z?usp=drive_link");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotesRoute {
  static Widget builder(BuildContext context) => const NotesPyqsPage();
}