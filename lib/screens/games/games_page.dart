import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:c_cell_app/services/app_state.dart';
import '../../widgets/glass_card.dart';
import '../../utils/asset_utils.dart';
import 'block_blast_page.dart';
import 'flappy_bird_page.dart';
import 'fruit_ninja_page.dart';
import 'game_2048_page.dart';
import 'memory_match_page.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  int hoveredCard = -1;

  final List<Map<String, dynamic>> gamesList = [
    {
      'title': 'Block Blast',
      'category': 'PUZZLE',
      'cover': 'assets/games/cover_block_blast.png',
      'icon': Icons.grid_on_rounded,
      'color': Colors.indigoAccent,
      'description': 'Drag and drop block shapes into the 8x8 grid to clear full lines and score combo streaks!',
      'getHighScore': () => AppState().blockBlastHS,
      'routeBuilder': (BuildContext context) => const BlockBlastPage(),
    },
    {
      'title': '2048',
      'category': 'LOGIC',
      'cover': 'assets/games/cover_2048.png',
      'icon': Icons.format_list_numbered_rounded,
      'color': Colors.amberAccent,
      'description': 'Swipe to slide and merge matching numbered tiles to reach the legendary 2048 tile!',
      'getHighScore': () => AppState().score2048HS,
      'routeBuilder': (BuildContext context) => const Game2048Page(),
    },
    {
      'title': 'Flappy Bird',
      'category': 'ARCADE',
      'cover': 'assets/games/cover_flappy_bird.png',
      'icon': Icons.flight_takeoff_rounded,
      'color': Colors.tealAccent,
      'description': 'Tap or press space to flap wings and navigate through challenging obstacles!',
      'getHighScore': () => AppState().flappyBirdHS,
      'routeBuilder': (BuildContext context) => const FlappyBirdPage(),
    },
    {
      'title': 'Fruit Ninja',
      'category': 'ACTION',
      'cover': 'assets/games/cover_fruit_ninja.png',
      'icon': Icons.cut_rounded,
      'color': Colors.deepOrangeAccent,
      'description': 'Swipe across the screen to slice juicy fruits while dodging dangerous bombs!',
      'getHighScore': () => AppState().fruitNinjaHS,
      'routeBuilder': (BuildContext context) => const FruitNinjaPage(),
    },
    {
      'title': 'Memory Match',
      'category': 'MEMORY',
      'cover': 'assets/games/cover_memory_match.png',
      'icon': Icons.style_rounded,
      'color': Colors.purpleAccent,
      'description': 'Flip cards to discover and match identical pairs before time runs out!',
      'getHighScore': () => AppState().memoryMatchHS,
      'routeBuilder': (BuildContext context) => const MemoryMatchPage(),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "CAMPUS GAMES",
          style: GoogleFonts.playfairDisplay(
            color: Colors.amberAccent,
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.amberAccent, width: 2),
                        ),
                        child: const Icon(
                          Icons.sports_esports,
                          color: Colors.amberAccent,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CAMPUS ARCADE HUB",
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.white,
                                fontSize: isMobile ? 24 : 36,
                                letterSpacing: 2,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Challenge yourself with instant-play arcade & puzzle games!",
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: isMobile ? 13 : 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
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
                        children: gamesList.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final Map<String, dynamic> game = entry.value;
                          return SizedBox(
                            width: cardWidth,
                            child: _buildGameCard(context, game, index, isMobile),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context,
    Map<String, dynamic> game,
    int index,
    bool isMobile,
  ) {
    final String title = game['title'];
    final String category = game['category'];
    final String cover = game['cover'];
    final IconData icon = game['icon'];
    final Color color = game['color'];
    final String description = game['description'];
    final int highScore = (game['getHighScore'] as Function)();
    final bool isHovered = hoveredCard == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredCard = index),
      onExit: (_) => setState(() => hoveredCard = -1),
      child: AnimatedScale(
        scale: isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: GlassCard(
          borderRadius: BorderRadius.circular(24),
          blur: 20,
          color: isHovered
              ? color.withValues(alpha: 0.16)
              : Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: isHovered
                ? color.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.12),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? color.withValues(alpha: 0.35)
                  : Colors.black.withValues(alpha: 0.4),
              blurRadius: isHovered ? 28 : 16,
              spreadRadius: isHovered ? 2 : 0,
              offset: const Offset(0, 8),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image Header with Glass Gradient Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          buildCachedImage(
                            cover,
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                            errorWidget: (context, url, error) {
                              return Container(
                                color: color.withValues(alpha: 0.2),
                                child: Center(
                                  child: Icon(icon, color: color, size: 54),
                                ),
                              );
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFF050816).withValues(alpha: 0.8),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.poppins(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: color.withValues(alpha: 0.4)),
                          ),
                          child: Icon(icon, color: color, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.amberAccent.withValues(alpha: 0.4)),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.emoji_events_rounded,
                                color: Colors.amberAccent,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "BEST: $highScore",
                                style: GoogleFonts.poppins(
                                  color: Colors.amberAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 5,
                            shadowColor: color.withValues(alpha: 0.5),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: game['routeBuilder'],
                              ),
                            ).then((_) => setState(() {}));
                          },
                          icon: const Icon(Icons.play_arrow_rounded, size: 20),
                          label: Text(
                            "PLAY NOW",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
