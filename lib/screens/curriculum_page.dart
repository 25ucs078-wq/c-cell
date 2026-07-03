import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pdf_viewer_page.dart';

class CurriculumPage extends StatefulWidget {
  const CurriculumPage({super.key});

  @override
  State<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage> {
  int hoveredCard = -1;

  static const List<Map<String, String>> courses = [
    {
      'title': 'B.Tech. Computer Science & Engineering',
      'shortName': 'B.Tech CSE',
      'degree': '4-Year UG Program',
      'pdf': 'assets/assets/pdfs/curriculum/btech_cse.pdf',
    },
    {
      'title': 'B.Tech. Communication & Computer Engineering',
      'shortName': 'B.Tech CCE',
      'degree': '4-Year UG Program',
      'pdf': 'assets/assets/pdfs/curriculum/btech_cce.pdf',
    },
    {
      'title': 'B.Tech. Electronics & Communication Engineering',
      'shortName': 'B.Tech ECE',
      'degree': '4-Year UG Program',
      'pdf': 'assets/assets/pdfs/curriculum/btech_ece.pdf',
    },
    {
      'title': 'B.Tech. Mechanical-Mechatronics Engineering',
      'shortName': 'B.Tech MME',
      'degree': '4-Year UG Program',
      'pdf': 'assets/assets/pdfs/curriculum/btech_mme.pdf',
    },
    {
      'title': 'Integrated B.Tech. - M.Tech. (CSE)',
      'shortName': 'Dual Degree CSE',
      'degree': '5-Year Integrated Program',
      'pdf': 'assets/assets/pdfs/curriculum/cse_integrated.pdf',
    },
    {
      'title': 'Integrated B.Tech. - M.Tech. (ECE)',
      'shortName': 'Dual Degree ECE',
      'degree': '5-Year Integrated Program',
      'pdf': 'assets/assets/pdfs/curriculum/ece_integrated.pdf',
    },
    {
      'title': 'M.Tech. Computer Science & Engineering',
      'shortName': 'M.Tech CSE',
      'degree': '2-Year PG Program',
      'pdf': 'assets/assets/pdfs/curriculum/mtech_cse.pdf',
    },
    {
      'title': 'M.Tech. Electronics & Communication Engineering',
      'shortName': 'M.Tech ECE',
      'degree': '2-Year PG Program',
      'pdf': 'assets/assets/pdfs/curriculum/mtech_ece.pdf',
    },
  ];

  final List<Color> _accentColors = const [
    Color(0xFF3B82F6), // Blue
    Color(0xFF8B5CF6), // Purple
    Color(0xFFEC4899), // Pink
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFF06B6D4), // Cyan
    Color(0xFF6366F1), // Indigo
    Color(0xFFEF4444), // Red
  ];

  void _openPdf(String title, String pdfPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(
          title: title,
          pdfPath: pdfPath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1123),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "CURRICULUM",
          style: GoogleFonts.playfairDisplay(
            color: Colors.redAccent,
            fontSize: isMobile ? 22 : 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFF1E2243),
            width: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 32,
          vertical: isMobile ? 20 : 32,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ACADEMIC CURRICULA",
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Official course schemes & syllabus for programs offered by LNMIIT",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: isMobile ? 13 : 15,
                  ),
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    final Color accentColor = _accentColors[index % _accentColors.length];
                    final bool isHovered = hoveredCard == index;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => hoveredCard = index),
                        onExit: (_) => setState(() => hoveredCard = -1),
                        child: GestureDetector(
                          onTap: () => _openPdf(course['title']!, course['pdf']!),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutCubic,
                            padding: EdgeInsets.all(isMobile ? 14 : 18),
                            decoration: BoxDecoration(
                              color: isHovered
                                  ? const Color(0xFF161A33)
                                  : const Color(0xFF0F1123).withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isHovered
                                    ? accentColor
                                    : const Color(0xFF1E2243).withValues(alpha: 0.7),
                                width: 1.5,
                              ),
                              boxShadow: isHovered
                                  ? [
                                      BoxShadow(
                                        color: accentColor.withValues(alpha: 0.2),
                                        blurRadius: 16,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.3),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: accentColor.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: accentColor.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.picture_as_pdf_rounded,
                                    color: accentColor,
                                    size: isMobile ? 24 : 28,
                                  ),
                                ),
                                SizedBox(width: isMobile ? 12 : 18),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        course['title']!,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: isMobile ? 15 : 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: accentColor.withValues(alpha: 0.2),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              course['degree']!,
                                              style: GoogleFonts.poppins(
                                                color: accentColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "•  Tap to view PDF",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white38,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedPadding(
                                  padding: EdgeInsets.only(left: isHovered ? 6.0 : 0.0),
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: isHovered ? accentColor : Colors.white38,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
