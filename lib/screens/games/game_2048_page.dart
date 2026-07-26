import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:c_cell_app/services/app_state.dart';
import 'widgets/game_gui_widgets.dart';
import 'widgets/game_layout_utils.dart';

class Game2048Page extends StatefulWidget {
  const Game2048Page({super.key});

  @override
  State<Game2048Page> createState() => _Game2048PageState();
}

class _Game2048PageState extends State<Game2048Page> {
  static const int boardSize = 4;
  late List<List<int>> _grid;
  int _score = 0;
  int _highScore = 0;
  bool _isGameOver = false;
  bool _hasWon = false;
  bool _keepPlayingAfterWin = false;
  Offset? _panStartPos;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _highScore = AppState().score2048HS;
    _initBoard();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _initBoard() {
    _grid = List.generate(
      boardSize,
      (_) => List.generate(boardSize, (_) => 0),
    );
    _score = 0;
    _isGameOver = false;
    _hasWon = false;
    _keepPlayingAfterWin = false;
    _spawnTile();
    _spawnTile();
  }

  void _resetGame() {
    setState(() {
      _initBoard();
    });
  }

  void _spawnTile() {
    List<Point> emptyCells = [];
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        if (_grid[r][c] == 0) {
          emptyCells.add(Point(c, r));
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      final rand = math.Random();
      final cell = emptyCells[rand.nextInt(emptyCells.length)];
      // 90% chance of 2, 10% chance of 4
      _grid[cell.y][cell.x] = rand.nextDouble() < 0.9 ? 2 : 4;
    }
  }

  Color _getTileColor(int value) {
    switch (value) {
      case 2:
        return const Color(0xFF4A90E2);
      case 4:
        return const Color(0xFFE74C3C);
      case 8:
        return const Color(0xFFF1C40F);
      case 16:
        return const Color(0xFFF39C12);
      case 32:
        return const Color(0xFF9B59B6);
      case 64:
        return const Color(0xFF2ECC71);
      case 128:
        return const Color(0xFF3498DB);
      case 256:
        return const Color(0xFF1ABC9C);
      case 512:
        return const Color(0xFF8E44AD);
      case 1024:
        return const Color(0xFFE67E22);
      case 2048:
        return const Color(0xFFE74C3C);
      default:
        return const Color(0xFFD64541);
    }
  }

  Color _getTileTextColor(int value) {
    if (value == 0) return const Color(0xFF7A6B57);
    if (value <= 8) return Colors.white;
    return Colors.white;
  }

  void _handleSwipe(int dx, int dy) {
    if (_isGameOver) return;

    bool gridChanged = false;

    if (dx != 0) {
      gridChanged = _slideHorizontal(dx > 0);
    } else if (dy != 0) {
      gridChanged = _slideVertical(dy > 0);
    }

    if (gridChanged) {
      setState(() {
        _spawnTile();
        _checkGameStatus();
        if (_score > _highScore) {
          _highScore = _score;
        }
        AppState().update2048Score(_score);
      });
    }
  }

  bool _slideHorizontal(bool toRight) {
    bool changed = false;
    for (int r = 0; r < boardSize; r++) {
      List<int> row = _grid[r].where((val) => val != 0).toList();
      List<int> newRow = [];

      if (toRight) {
        // process from right to left
        row = row.reversed.toList();
        for (int i = 0; i < row.length; i++) {
          if (i + 1 < row.length && row[i] == row[i + 1]) {
            int mergedVal = row[i] * 2;
            newRow.add(mergedVal);
            _score += mergedVal;
            i++;
          } else {
            newRow.add(row[i]);
          }
        }
        newRow = newRow.reversed.toList();
        // pad left with zeros
        while (newRow.length < boardSize) {
          newRow.insert(0, 0);
        }
      } else {
        // process left to right
        for (int i = 0; i < row.length; i++) {
          if (i + 1 < row.length && row[i] == row[i + 1]) {
            int mergedVal = row[i] * 2;
            newRow.add(mergedVal);
            _score += mergedVal;
            i++;
          } else {
            newRow.add(row[i]);
          }
        }
        // pad right with zeros
        while (newRow.length < boardSize) {
          newRow.add(0);
        }
      }

      for (int c = 0; c < boardSize; c++) {
        if (_grid[r][c] != newRow[c]) {
          changed = true;
        }
        _grid[r][c] = newRow[c];
      }
    }
    return changed;
  }

  bool _slideVertical(bool toBottom) {
    bool changed = false;
    for (int c = 0; c < boardSize; c++) {
      List<int> col = [];
      for (int r = 0; r < boardSize; r++) {
        if (_grid[r][c] != 0) col.add(_grid[r][c]);
      }
      List<int> newCol = [];

      if (toBottom) {
        // bottom to top
        col = col.reversed.toList();
        for (int i = 0; i < col.length; i++) {
          if (i + 1 < col.length && col[i] == col[i + 1]) {
            int mergedVal = col[i] * 2;
            newCol.add(mergedVal);
            _score += mergedVal;
            i++;
          } else {
            newCol.add(col[i]);
          }
        }
        newCol = newCol.reversed.toList();
        while (newCol.length < boardSize) {
          newCol.insert(0, 0);
        }
      } else {
        // top to bottom
        for (int i = 0; i < col.length; i++) {
          if (i + 1 < col.length && col[i] == col[i + 1]) {
            int mergedVal = col[i] * 2;
            newCol.add(mergedVal);
            _score += mergedVal;
            i++;
          } else {
            newCol.add(col[i]);
          }
        }
        while (newCol.length < boardSize) {
          newCol.add(0);
        }
      }

      for (int r = 0; r < boardSize; r++) {
        if (_grid[r][c] != newCol[r]) {
          changed = true;
        }
        _grid[r][c] = newCol[r];
      }
    }
    return changed;
  }

  void _checkGameStatus() {
    // Check for win (2048 tile)
    if (!_keepPlayingAfterWin && !_hasWon) {
      for (int r = 0; r < boardSize; r++) {
        for (int c = 0; c < boardSize; c++) {
          if (_grid[r][c] == 2048) {
            _hasWon = true;
            return;
          }
        }
      }
    }

    // Check if empty cells exist
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        if (_grid[r][c] == 0) return;
      }
    }

    // Check if adjacent identical cells exist (merges possible)
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        int val = _grid[r][c];
        if (c + 1 < boardSize && _grid[r][c + 1] == val) return;
        if (r + 1 < boardSize && _grid[r + 1][c] == val) return;
      }
    }

    // No moves possible -> Game Over
    _isGameOver = true;
  }

  Widget _buildStatCard(String title, String value, Color accent) {
    final compactWidth = MediaQuery.of(context).size.width < 390;
    return Container(
      width: compactWidth ? double.infinity : 110,
      padding: EdgeInsets.symmetric(
        vertical: compactWidth ? 12 : 16,
        horizontal: compactWidth ? 10 : 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.26)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.bebasNeue(
              fontSize: 11,
              color: Colors.white60,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.bebasNeue(
              fontSize: 22,
              color: accent,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return ArcadeActionButton(
      label: label,
      icon: Icons.restart_alt_rounded,
      color: const Color(0xFFFF4D6D),
      onTap: onPressed,
    );
  }

  Widget _buildResultOverlay() {
    if (_hasWon && !_keepPlayingAfterWin) {
      return ArcadeResultOverlay(
        title: '2048 Reached',
        subtitle:
            'You made the legendary tile. Keep going and build an even bigger score.',
        score: 'Score $_score',
        color: const Color(0xFF39D98A),
        buttonLabel: 'Keep Playing',
        onButtonTap: () {
          setState(() {
            _keepPlayingAfterWin = true;
          });
        },
      );
    }

    if (_isGameOver) {
      return ArcadeResultOverlay(
        title: 'Board Locked',
        subtitle:
            'No more merges are available. Start fresh and protect your corners.',
        score: 'Score $_score',
        color: const Color(0xFFFF4D6D),
        buttonLabel: 'New Game',
        onButtonTap: _resetGame,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildBackButton(BuildContext context) {
    return ArcadeIconButton(
      icon: Icons.arrow_back_rounded,
      color: const Color(0xFFFF4D6D),
      tooltip: 'Back',
      onTap: () {
        AppState().update2048Score(_score);
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          final key = event.logicalKey;
          if (key == LogicalKeyboardKey.arrowLeft || key == LogicalKeyboardKey.keyA) {
            _handleSwipe(-1, 0);
          } else if (key == LogicalKeyboardKey.arrowRight || key == LogicalKeyboardKey.keyD) {
            _handleSwipe(1, 0);
          } else if (key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.keyW) {
            _handleSwipe(0, -1);
          } else if (key == LogicalKeyboardKey.arrowDown || key == LogicalKeyboardKey.keyS) {
            _handleSwipe(0, 1);
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1020),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compactHeight = constraints.maxHeight < 700;
              final compactWidth = constraints.maxWidth < 390;
              final estimatedTopHeight = compactWidth ? 176.0 : 124.0;
              final bottomControlsHeight = compactHeight ? 82.0 : 114.0;
              final boardVerticalRoom = math.max(
                168.0,
                constraints.maxHeight -
                    estimatedTopHeight -
                    bottomControlsHeight -
                    56.0,
              );
              final boardWidth = resolveResponsiveBoardSize(
                maxWidth: constraints.maxWidth,
                maxHeight: constraints.maxHeight,
                horizontalPadding: compactWidth ? 52 : 68,
                verticalPadding: constraints.maxHeight - boardVerticalRoom,
                maxBoardSize: 360,
                minBoardSize: 168,
                heightRatio: 1,
              );
              final exactBoardSize =
                  (boardWidth / boardSize).floorToDouble() * boardSize;
              final gridSpacing = exactBoardSize > 320 ? 14.0 : 10.0;
              final tileSize =
                  (exactBoardSize - (gridSpacing * (boardSize + 1))) / boardSize;

              return Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF0B1020),
                            Color(0xFF15213C),
                            Color(0xFF22152A),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          20,
                          18,
                          20,
                          MediaQuery.of(context).viewInsets.bottom + 20,
                        ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flex(
                            direction: compactWidth
                                ? Axis.vertical
                                : Axis.horizontal,
                            crossAxisAlignment: compactWidth
                                ? CrossAxisAlignment.stretch
                                : CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: _buildBackButton(context),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            for (final item in const [
                                              ('2', Color(0xFFE74C3C)),
                                              ('0', Color(0xFF27AE60)),
                                              ('4', Color(0xFF3498DB)),
                                              ('8', Color(0xFFF1C40F)),
                                            ])
                                              Text(
                                                item.$1,
                                                style: GoogleFonts.bebasNeue(
                                                  fontSize: compactWidth
                                                      ? 44
                                                      : 54,
                                                  fontWeight: FontWeight.w900,
                                                  color: item.$2,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: compactHeight ? 6 : 10),
                                        Text(
                                          'Join the numbers and get to the 2048 tile!',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white60,
                                            fontSize: compactWidth ? 13 : 15,
                                            height: 1.35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: compactWidth ? 0 : 12,
                                height: compactWidth ? 12 : 0,
                              ),
                              compactWidth
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: _buildStatCard(
                                            'SCORE',
                                            '$_score',
                                            const Color(0xFF48C774),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: _buildStatCard(
                                            'BEST',
                                            '${math.max(_score, _highScore)}',
                                            const Color(0xFFEDAE49),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        _buildStatCard(
                                          'SCORE',
                                          '$_score',
                                          const Color(0xFF48C774),
                                        ),
                                        const SizedBox(height: 12),
                                        _buildStatCard(
                                          'BEST',
                                          '${math.max(_score, _highScore)}',
                                          const Color(0xFFEDAE49),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          SizedBox(height: compactHeight ? 16 : 24),

                          Center(
                            child: Container(
                              width: exactBoardSize + (gridSpacing * 2),
                              height: exactBoardSize + (gridSpacing * 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.09),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.14),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF39D98A,
                                    ).withValues(alpha: 0.14),
                                    blurRadius: 28,
                                    offset: const Offset(0, 16),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(gridSpacing),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF11182A),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: GestureDetector(
                                  onPanStart: (details) {
                                    _panStartPos = details.localPosition;
                                  },
                                  onPanUpdate: (details) {
                                    if (_panStartPos == null) return;
                                    final dx =
                                        details.localPosition.dx -
                                        _panStartPos!.dx;
                                    final dy =
                                        details.localPosition.dy -
                                        _panStartPos!.dy;
                                    const double threshold = 40.0;
                                    if (dx.abs() > threshold ||
                                        dy.abs() > threshold) {
                                      if (dx.abs() > dy.abs()) {
                                        _handleSwipe(dx > 0 ? 1 : -1, 0);
                                      } else {
                                        _handleSwipe(0, dy > 0 ? 1 : -1);
                                      }
                                      _panStartPos = null;
                                    }
                                  },
                                  onPanEnd: (details) {
                                    _panStartPos = null;
                                  },
                                  child: GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: boardSize * boardSize,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: boardSize,
                                          crossAxisSpacing: gridSpacing,
                                          mainAxisSpacing: gridSpacing,
                                        ),
                                    itemBuilder: (context, index) {
                                      int row = index ~/ boardSize;
                                      int col = index % boardSize;
                                      int value = _grid[row][col];

                                      return AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),
                                        decoration: BoxDecoration(
                                          color: value == 0
                                              ? Colors.white.withValues(alpha: 0.06)
                                              : _getTileColor(value),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                            color: value == 0
                                                ? Colors.white.withValues(alpha: 0.06)
                                                : Colors.white.withValues(alpha: 0.18),
                                          ),
                                          boxShadow: value > 0
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.black.withValues(alpha: 0.15),
                                                    blurRadius: 6,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ]
                                              : [],
                                        ),
                                        child: Center(
                                          child: Text(
                                            value == 0 ? '' : '$value',
                                            style: GoogleFonts.bebasNeue(
                                              color: _getTileTextColor(value),
                                              fontSize: value >= 1024
                                                  ? tileSize * 0.28
                                                  : value >= 128
                                                  ? tileSize * 0.34
                                                  : tileSize * 0.44,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: compactHeight ? 18 : 28),

                          Row(
                            children: [
                              Expanded(
                                child: _buildActionButton('NEW GAME', _resetGame),
                              ),
                            ],
                          ),
                          SizedBox(height: compactHeight ? 18 : 32),
                        ],
                      ),
                    ),
                  ),
                  if (_hasWon && !_keepPlayingAfterWin || _isGameOver)
                    _buildResultOverlay(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Point {
  final int x;
  final int y;
  Point(this.x, this.y);
}
