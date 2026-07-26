import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:c_cell_app/services/app_state.dart';
import 'widgets/game_gui_widgets.dart';
import 'widgets/game_layout_utils.dart';

class MMCard {
  final int id;
  final IconData icon;
  bool isFlipped = false;
  bool isMatched = false;

  MMCard({required this.id, required this.icon});
}

class MemoryMatchPage extends StatefulWidget {
  const MemoryMatchPage({super.key});

  @override
  State<MemoryMatchPage> createState() => _MemoryMatchPageState();
}

class _MemoryMatchPageState extends State<MemoryMatchPage> {
  static const int gridSize = 4; // 4x4 grid
  late List<MMCard> _cards;
  int? _firstFlippedIdx;
  int? _secondFlippedIdx;
  bool _isProcessing = false;

  int _score = 0;
  int _highScore = 0;
  int _turnsCount = 0;
  int _elapsedSeconds = 0;
  bool _isGameOver = false;
  Timer? _gameTimer;

  final List<IconData> _iconPool = [
    Icons.auto_awesome,
    Icons.sports_esports,
    Icons.favorite,
    Icons.flash_on,
    Icons.extension,
    Icons.lightbulb,
    Icons.rocket_launch,
    Icons.star_rounded,
  ];

  @override
  void initState() {
    super.initState();
    _highScore = AppState().memoryMatchHS;
    _resetGame();
  }

  void _resetGame() {
    _gameTimer?.cancel();
    _elapsedSeconds = 0;
    _isGameOver = false;
    _turnsCount = 0;
    _score = 1000; // start score decays with wrong turns
    _firstFlippedIdx = null;
    _secondFlippedIdx = null;
    _isProcessing = false;

    // Duplicate icons to form pairs
    List<IconData> cardsList = [];
    for (var icon in _iconPool) {
      cardsList.add(icon);
      cardsList.add(icon);
    }

    // Shuffle cards
    cardsList.shuffle(math.Random());

    _cards = List.generate(
      cardsList.length,
      (idx) => MMCard(id: idx, icon: cardsList[idx]),
    );

    _startTimer();
    setState(() {});
  }

  void _startTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _handleCardTap(int index) {
    if (_isGameOver || _isProcessing) return;

    final clickedCard = _cards[index];
    if (clickedCard.isFlipped || clickedCard.isMatched) return;

    setState(() {
      clickedCard.isFlipped = true;

      if (_firstFlippedIdx == null) {
        _firstFlippedIdx = index;
      } else {
        _secondFlippedIdx = index;
        _turnsCount++;
        _checkMatch();
      }
    });
  }

  void _checkMatch() {
    _isProcessing = true;
    final card1 = _cards[_firstFlippedIdx!];
    final card2 = _cards[_secondFlippedIdx!];

    if (card1.icon == card2.icon) {
      // MATCH FOUND
      card1.isMatched = true;
      card2.isMatched = true;
      _score += 150; // positive reward for correct match

      _firstFlippedIdx = null;
      _secondFlippedIdx = null;
      _isProcessing = false;

      _checkWinCondition();
    } else {
      // NO MATCH
      _score = math.max(0, _score - 40); // penalty for incorrect match

      Timer(const Duration(milliseconds: 700), () {
        if (!mounted) return;
        setState(() {
          card1.isFlipped = false;
          card2.isFlipped = false;

          _firstFlippedIdx = null;
          _secondFlippedIdx = null;
          _isProcessing = false;
        });
      });
    }
  }

  void _checkWinCondition() {
    bool allMatched = _cards.every((card) => card.isMatched);
    if (allMatched) {
      _gameTimer?.cancel();
      setState(() {
        _isGameOver = true;
        AppState().updateMemoryMatchScore(_score);
        _highScore = math.max(_highScore, _score);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07130E),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF07130E), Color(0xFF123A2A), Color(0xFF28183A)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compactHeight = constraints.maxHeight < 700;
              final compactWidth = constraints.maxWidth < 390;
              final topBudget = compactWidth ? 154.0 : 132.0;
              final bottomBudget = compactHeight ? 76.0 : 98.0;
              final boardVerticalRoom = math.max(
                168.0,
                constraints.maxHeight - topBudget - bottomBudget - 64.0,
              );
              final boardWidth = resolveResponsiveBoardSize(
                maxWidth: constraints.maxWidth,
                maxHeight: constraints.maxHeight,
                horizontalPadding: compactWidth ? 44 : 56,
                verticalPadding: constraints.maxHeight - boardVerticalRoom,
                maxBoardSize: 360,
                minBoardSize: 168,
                heightRatio: 1,
              );
              final exactBoardSize =
                  (boardWidth / gridSize).floorToDouble() * gridSize;
              final gridSpacing = exactBoardSize > 320 ? 12.0 : 10.0;
              final tileSize =
                  (exactBoardSize - (gridSpacing * (gridSize + 1))) / gridSize;

              return Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          16,
                          18,
                          16,
                          MediaQuery.of(context).viewInsets.bottom + 20,
                        ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ArcadeIconButton(
                                icon: Icons.arrow_back_rounded,
                                onTap: () {
                                  AppState().updateMemoryMatchScore(_score);
                                  Navigator.of(context).pop();
                                },
                                color: const Color(0xFF42E8C4),
                                tooltip: 'Back',
                              ),
                              Text(
                                'Memory Match',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.bebasNeue(
                                  color: Colors.white,
                                  fontSize: compactWidth ? 22 : 26,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _formatTime(_elapsedSeconds),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$_turnsCount moves',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white60,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: compactHeight ? 12 : 18),
                          Row(
                            children: [
                              ArcadeStatCard(
                                label: 'Score',
                                value: '$_score',
                                color: const Color(0xFFFFD166),
                                icon: Icons.stars_rounded,
                              ),
                              const SizedBox(width: 10),
                              ArcadeStatCard(
                                label: 'Best',
                                value: '${math.max(_score, _highScore)}',
                                color: const Color(0xFF42E8C4),
                                icon: Icons.emoji_events_rounded,
                              ),
                            ],
                          ),
                          SizedBox(height: compactHeight ? 12 : 18),
                          Center(
                            child: Container(
                              width: exactBoardSize + (gridSpacing * 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.16),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF42E8C4,
                                    ).withValues(alpha: 0.16),
                                    blurRadius: 28,
                                    offset: const Offset(0, 16),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(gridSpacing),
                              child: Container(
                                width: exactBoardSize,
                                height: exactBoardSize,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF101B22),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _cards.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: gridSize,
                                        crossAxisSpacing: gridSpacing,
                                        mainAxisSpacing: gridSpacing,
                                      ),
                                  itemBuilder: (context, index) {
                                    final card = _cards[index];
                                    final showFace =
                                        card.isFlipped || card.isMatched;

                                    return GestureDetector(
                                      onTap: () => _handleCardTap(index),
                                      child: AnimatedScale(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),
                                        scale: card.isMatched ? 0.94 : 1,
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 250,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: showFace
                                                  ? [
                                                      const Color(0xFFFFD166),
                                                      const Color(0xFFFF8FAB),
                                                    ]
                                                  : [
                                                      const Color(0xFF3841A8),
                                                      const Color(0xFF7D4DFF),
                                                    ],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                            border: Border.all(
                                              color: showFace
                                                  ? Colors.white.withValues(
                                                      alpha: 0.5,
                                                    )
                                                  : Colors.white.withValues(
                                                      alpha: 0.2,
                                                    ),
                                              width: 2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    (showFace
                                                            ? const Color(
                                                                0xFFFFD166,
                                                              )
                                                            : const Color(
                                                                0xFF7D4DFF,
                                                              ))
                                                        .withValues(
                                                          alpha: 0.22,
                                                        ),
                                                blurRadius: showFace ? 10 : 16,
                                                offset: const Offset(0, 8),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: AnimatedSwitcher(
                                              duration: const Duration(
                                                milliseconds: 220,
                                              ),
                                              child: showFace
                                                  ? Icon(
                                                      card.icon,
                                                      key: ValueKey(
                                                        'face-$index',
                                                      ),
                                                      color: const Color(
                                                        0xFF10231B,
                                                      ),
                                                      size: tileSize * 0.45,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .auto_awesome_rounded,
                                                      key: ValueKey(
                                                        'back-$index',
                                                      ),
                                                      color: Colors.white,
                                                      size: tileSize * 0.38,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: compactHeight ? 12 : 18),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSmallButton(
                                  'New Game',
                                  _resetGame,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: compactHeight ? 12 : 20),
                        ],
                      ),
                    ),
                  ),
                  if (_isGameOver)
                    ArcadeResultOverlay(
                      title: 'Board Cleared',
                      subtitle:
                          'Every pair matched. Try again for fewer moves and a higher score.',
                      score:
                          'Score $_score  •  Best ${math.max(_score, _highScore)}',
                      color: const Color(0xFF42E8C4),
                      buttonLabel: 'New Game',
                      onButtonTap: _resetGame,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSmallButton(String label, VoidCallback onPressed) {
    return ArcadeActionButton(
      label: label,
      icon: Icons.restart_alt_rounded,
      color: const Color(0xFF42E8C4),
      onTap: onPressed,
    );
  }
}
