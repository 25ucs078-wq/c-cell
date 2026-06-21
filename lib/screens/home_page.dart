import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'more_page.dart';
import 'office_bearers_page.dart';
import 'student_fests_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int hoveredCard = -1;
  int hoveredHeaderLink = -1;

  final GlobalKey eventsKey = GlobalKey();
  final GlobalKey gymkhanaKey = GlobalKey();
  final GlobalKey trendingKey = GlobalKey();
  final GlobalKey clubsKey = GlobalKey();
  final GlobalKey quickKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();

  late final ScrollController _scrollController;
  double _scrollOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final opacity = (offset / 150).clamp(0.0, 1.0);
      if (opacity != _scrollOpacity) {
        setState(() {
          _scrollOpacity = opacity;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToSection(
    int index,
    GlobalKey key,
  ) {
    setState(() {
      selectedIndex = index;
    });

    if (Scaffold.of(context).isDrawerOpen) {
      Navigator.pop(context);
    }

    Future.delayed(
      const Duration(milliseconds: 250),
      () {
        if (key.currentContext != null) {
          Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(
              milliseconds: 700,
            ),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen, double screenWidth) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 20 : screenWidth * 0.05,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF050816).withValues(alpha: _scrollOpacity * 0.85),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: _scrollOpacity * 0.08),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (isSmallScreen) ...[
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withValues(alpha: 0.35),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/logo.jpeg"),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "C-CELL",
                style: GoogleFonts.bebasNeue(
                  color: Colors.redAccent,
                  fontSize: 28,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          if (!isSmallScreen)
            Row(
              children: [
                _buildHeaderNavLink(0, "Events", eventsKey),
                _buildHeaderNavLink(1, "Gymkhana", gymkhanaKey),
                _buildHeaderNavLink(2, "Trending", trendingKey),
                _buildHeaderNavLink(3, "Clubs", clubsKey),
                _buildHeaderNavLink(4, "Quick Access", quickKey),
                _buildHeaderNavLink(5, "About", aboutKey),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MorePage(),
                      ),
                    );
                  },
                  child: Text(
                    "Meet the Team",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildHeaderNavLink(int index, String title, GlobalKey key) {
    final isSelected = selectedIndex == index;
    final isHovered = hoveredHeaderLink == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredHeaderLink = index),
      onExit: (_) => setState(() => hoveredHeaderLink = -1),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          if (key.currentContext != null) {
            Scrollable.ensureVisible(
              key.currentContext!,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? Colors.redAccent
                    : isHovered
                        ? Colors.redAccent.withValues(alpha: 0.5)
                        : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: isSelected
                  ? Colors.white
                  : isHovered
                      ? Colors.white.withValues(alpha: 0.9)
                      : Colors.white70,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionContent({
    required List<Widget> children,
    required double height,
    required bool isSmallScreen,
  }) {
    if (isSmallScreen) {
      return SizedBox(
        height: height,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: children,
        ),
      );
    } else {
      return Wrap(
        spacing: 20,
        runSpacing: 20,
        children: children,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isSmallScreen = screenWidth < 800;
    final heroHeight = (screenHeight * (isSmallScreen ? 0.55 : 0.60)).clamp(420.0, 650.0);
    final sectionSpacing = isSmallScreen ? 40.0 : 60.0;
    final titleFontSize = isSmallScreen ? 48.0 : 82.0;
    final sectionTitleFontSize = isSmallScreen ? 28.0 : 34.0;
    final bodyFontSize = isSmallScreen ? 15.0 : 18.0;
    final buttonSpacing = isSmallScreen ? 12.0 : 15.0;
    final heroTopPadding = isSmallScreen ? 140.0 : 180.0;
    final listCardHeight = isSmallScreen ? 180.0 : 220.0;
    final aboutCardHeight = isSmallScreen ? 160.0 : 180.0;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF050816),
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            const SizedBox(height: 30),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withValues(alpha: 0.35),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage(
                    "assets/images/logo.jpeg",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "C-CELL",
              style: GoogleFonts.bebasNeue(
                color: Colors.redAccent,
                fontSize: 46,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withValues(alpha: 0.15),
                    blurRadius: 25,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WELCOME BACK",
                    style: GoogleFonts.bebasNeue(
                      color: Colors.redAccent,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "KUNAL AGARWAL",
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 32,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Explore your campus universe",
                    style: GoogleFonts.poppins(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: selectedIndex == 0
                      ? [
                          Colors.redAccent.withValues(alpha: 0.45),
                          Colors.redAccent.withValues(alpha: 0.15),
                        ]
                      : [
                          Colors.transparent,
                          Colors.transparent,
                        ],
                ),
                boxShadow: selectedIndex == 0
                    ? [
                        BoxShadow(
                          color: Colors.redAccent.withValues(alpha: 0.35),
                          blurRadius: 25,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 0 ? Colors.redAccent : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Freshers Events",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        navigateToSection(
                          0,
                          eventsKey,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: selectedIndex == 1
                      ? [
                          Colors.redAccent.withValues(alpha: 0.35),
                          Colors.redAccent.withValues(alpha: 0.12),
                        ]
                      : [
                          Colors.transparent,
                          Colors.transparent,
                        ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 1 ? Colors.redAccent : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.account_balance,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Gymkhana Councils",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        navigateToSection(
                          1,
                          gymkhanaKey,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: selectedIndex == 2
                      ? [
                          Colors.redAccent.withValues(alpha: 0.35),
                          Colors.redAccent.withValues(alpha: 0.12),
                        ]
                      : [
                          Colors.transparent,
                          Colors.transparent,
                        ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 2 ? Colors.redAccent : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.local_fire_department,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Trending Campus",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        navigateToSection(
                          2,
                          trendingKey,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: selectedIndex == 3
                      ? [
                          Colors.redAccent.withValues(alpha: 0.35),
                          Colors.redAccent.withValues(alpha: 0.12),
                        ]
                      : [
                          Colors.transparent,
                          Colors.transparent,
                        ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 3 ? Colors.redAccent : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.groups,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Clubs & Societies",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        navigateToSection(
                          3,
                          clubsKey,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: selectedIndex == 4
                      ? [
                          Colors.redAccent.withValues(alpha: 0.35),
                          Colors.redAccent.withValues(alpha: 0.12),
                        ]
                      : [
                          Colors.transparent,
                          Colors.transparent,
                        ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 4 ? Colors.redAccent : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.flash_on,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Quick Access",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        navigateToSection(
                          4,
                          quickKey,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: selectedIndex == 5
                      ? [
                          Colors.redAccent.withValues(alpha: 0.35),
                          Colors.redAccent.withValues(alpha: 0.12),
                        ]
                      : [
                          Colors.transparent,
                          Colors.transparent,
                        ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 5 ? Colors.redAccent : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "About Us",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        navigateToSection(
                          5,
                          aboutKey,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.redAccent.withValues(alpha: 0.25),
                    Colors.black,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "💎 PRO TIP",
                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Check back daily\nfor new events!",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF050816),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: heroHeight,
                  child: Image.asset(
                    "assets/images/hero_new.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: heroHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.25),
                        Colors.black.withValues(alpha: 0.55),
                        const Color(0xFF050816),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: isSmallScreen ? 20 : 40,
                        right: isSmallScreen ? 20 : 40,
                        top: heroTopPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: isSmallScreen ? 70 : 100),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "LNMIIT EXCLUSIVE",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            "THE C-CELL APP",
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: titleFontSize,
                              letterSpacing: 3,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "LNMIIT's Ultimate Campus Experience\nEvents, Clubs and Everything Campus.",
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: bodyFontSize,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 28 : 35),
                          Wrap(
                            spacing: buttonSpacing,
                            runSpacing: buttonSpacing,
                            children: [
                              SizedBox(
                                width: isSmallScreen ? double.infinity : null,
                                child: Builder(
                                  builder: (context) {
                                    return ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      icon: const Icon(Icons.grid_view_rounded),
                                      label: Text(
                                        "Explore",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: isSmallScreen ? double.infinity : null,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white.withValues(alpha: 0.15),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MorePage(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.info_outline),
                                  label: Text(
                                    "More Info",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: isSmallScreen ? 80 : 100),
                          Container(
                            key: eventsKey,
                          ),
                          Text(
                            "EVENTS FOR FRESHERS",
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: sectionTitleFontSize,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildSectionContent(
                            height: listCardHeight,
                            isSmallScreen: isSmallScreen,
                            children: [
                              buildPosterCard(0, "assets/images/treasure_hunt.jpeg", "Treasure Hunt", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(1, "assets/images/y25_talent.jpeg", "Y25 Got Talent", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(2, "assets/images/duologue.jpeg", "Duologue", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(3, "assets/images/dalgona.jpeg", "Dalgona Trials", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(4, "assets/images/astro_lens.jpeg", "Astro Lens", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(5, "assets/images/freshers_quiz.jpeg", "Freshers Quiz", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(6, "assets/images/survive_skies.jpeg", "Survive The Skies", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(7, "assets/images/agree_disagree.jpeg", "Agree To Disagree", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(8, "assets/images/micro_mayhem.jpeg", "Micro Mayhem", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(9, "assets/images/dance_workshop.jpeg", "Dance Workshop", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(10, "assets/images/imaginarium.jpeg", "Imaginarium", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(11, "assets/images/casecraft.jpeg", "Casecraft", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(12, "assets/images/photowalk.jpeg", "Photowalk", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(13, "assets/images/market_moguls.jpeg", "Market Moguls", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                              buildPosterCard(14, "assets/images/batch_photography.jpeg", "Batch Photography", isSmallScreen: isSmallScreen, listCardHeight: listCardHeight),
                            ],
                          ),
                          SizedBox(height: sectionSpacing),
                          Container(
                            key: gymkhanaKey,
                          ),
                          Text(
                            "STUDENT GYMKHANA",
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: sectionTitleFontSize,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildSectionContent(
                            height: listCardHeight,
                            isSmallScreen: isSmallScreen,
                            children: [
                              buildEventCard(
                                100,
                                Colors.redAccent,
                                Icons.account_balance,
                                "Office Bearers",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const OfficeBearersPage(),
                                    ),
                                  );
                                },
                              ),
                              buildEventCard(
                                101,
                                Colors.deepPurple,
                                Icons.groups,
                                "Councils",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                102,
                                Colors.teal,
                                Icons.celebration,
                                "Student Fests",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const StudentFestsPage(),
                                    ),
                                  );
                                },
                              ),
                              buildEventCard(
                                103,
                                Colors.indigo,
                                Icons.event,
                                "Events",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                            ],
                          ),
                          SizedBox(height: sectionSpacing),
                          Container(
                            key: trendingKey,
                          ),
                          Text(
                            "TRENDING ON CAMPUS",
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: sectionTitleFontSize,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildSectionContent(
                            height: listCardHeight,
                            isSmallScreen: isSmallScreen,
                            children: [
                              buildEventCard(
                                200,
                                Colors.pink,
                                Icons.campaign,
                                "Campus Buzz",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                201,
                                Colors.orange,
                                Icons.local_fire_department,
                                "Vivacity Merch",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                202,
                                Colors.red,
                                Icons.architecture,
                                "Plinth Merch",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                203,
                                Colors.blueGrey,
                                Icons.sports_esports,
                                "Desportivos Merch",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                            ],
                          ),
                          SizedBox(height: sectionSpacing),
                          Container(
                            key: clubsKey,
                          ),
                          Text(
                            "CLUBS & SOCIETIES",
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: sectionTitleFontSize,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildSectionContent(
                            height: listCardHeight,
                            isSmallScreen: isSmallScreen,
                            children: [
                              buildEventCard(
                                300,
                                Colors.purple,
                                Icons.palette,
                                "Cultural",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                301,
                                Colors.green,
                                Icons.science,
                                "Technical",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                302,
                                Colors.blue,
                                Icons.sports,
                                "Sports",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                303,
                                Colors.amber,
                                Icons.volunteer_activism,
                                "Social",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                            ],
                          ),
                          SizedBox(height: sectionSpacing),
                          Container(
                            key: quickKey,
                          ),
                          Text(
                            "QUICK ACCESS",
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: sectionTitleFontSize,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildSectionContent(
                            height: listCardHeight,
                            isSmallScreen: isSmallScreen,
                            children: [
                              buildEventCard(
                                400,
                                Colors.indigo,
                                Icons.calendar_month,
                                "Academic Calendar",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                401,
                                Colors.teal,
                                Icons.map,
                                "Campus Map",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                402,
                                Colors.deepOrange,
                                Icons.restaurant,
                                "Mess Menu",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                403,
                                Colors.pink,
                                Icons.map,
                                "Bus Schedule",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                              buildEventCard(
                                404,
                                Colors.redAccent,
                                Icons.phone,
                                "Emergency",
                                isSmallScreen: isSmallScreen,
                                listCardHeight: listCardHeight,
                              ),
                            ],
                          ),
                          const SizedBox(height: 60),
                          Container(
                            key: aboutKey,
                          ),
                          Text(
                            "CONTINUE YOUR JOURNEY",
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: sectionTitleFontSize,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MorePage(),
                                ),
                              );
                            },
                            child: Container(
                              height: aboutCardHeight,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/team_poster.jpeg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.2),
                                      Colors.black.withValues(alpha: 0.8),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "ABOUT US",
                                        style: GoogleFonts.bebasNeue(
                                          color: Colors.white,
                                          fontSize: 40,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      Text(
                                        "Meet the C-CELL Team",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          SizedBox(height: isSmallScreen ? 40 : 50),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _scrollOpacity > 0
                ? ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 8 * _scrollOpacity,
                        sigmaY: 8 * _scrollOpacity,
                      ),
                      child: _buildHeader(context, isSmallScreen, screenWidth),
                    ),
                  )
                : _buildHeader(context, isSmallScreen, screenWidth),
          ),
        ],
      ),
    );
  }

  Widget buildEventCard(
    int index,
    Color color,
    IconData icon,
    String title, {
    VoidCallback? onTap,
    required bool isSmallScreen,
    required double listCardHeight,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            hoveredCard = index;
          });
        },
        onExit: (_) {
          setState(() {
            hoveredCard = -1;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 250,
          ),
          width: hoveredCard == index ? 185 : 170,
          height: hoveredCard == index ? listCardHeight : listCardHeight - 10,
          margin: EdgeInsets.only(
            right: isSmallScreen ? 15 : 0,
            top: hoveredCard == index ? 0 : 10,
            bottom: hoveredCard == index ? 10 : 0,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.9),
                color.withValues(alpha: 0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: hoveredCard == index
                ? [
                    BoxShadow(
                      color: color.withValues(
                        alpha: 0.45,
                      ),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: hoveredCard == index ? 50 : 45,
                ),
                const Spacer(),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: hoveredCard == index ? 22 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPosterCard(
    int index,
    String image,
    String title, {
    required bool isSmallScreen,
    required double listCardHeight,
  }) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoveredCard = index;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredCard = -1;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 250,
        ),
        width: hoveredCard == index ? 185 : 170,
        height: hoveredCard == index ? listCardHeight : listCardHeight - 10,
        margin: EdgeInsets.only(
          right: isSmallScreen ? 15 : 0,
          top: hoveredCard == index ? 0 : 10,
          bottom: hoveredCard == index ? 10 : 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: hoveredCard == index
              ? [
                  BoxShadow(
                    color: Colors.redAccent.withValues(
                      alpha: 0.4,
                    ),
                    blurRadius: 25,
                    spreadRadius: 3,
                  ),
                ]
              : [],
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black87,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              16,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: hoveredCard == index ? 31 : 28,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
