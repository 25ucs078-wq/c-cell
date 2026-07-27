import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:c_cell_app/services/app_state.dart';
import 'widgets/game_gui_widgets.dart';

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
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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
        while (newRow.length < boardSize) {
          newRow.insert(0, 0);
        }
      } else {
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

    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        if (_grid[r][c] == 0) return;
      }
    }

    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        int val = _grid[r][c];
        if (c + 1 < boardSize && _grid[r][c + 1] == val) return;
        if (r + 1 < boardSize && _grid[r + 1][c] == val) return;
      }
    }

    _isGameOver = true;
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    double maxBoardSize = isMobile ? screenWidth - 48 : 400;
    if (maxBoardSize > 400) maxBoardSize = 400;
    if (maxBoardSize < 240) maxBoardSize = 240;

    final double gridSpacing = 10.0;
    final double tileSize = (maxBoardSize - (gridSpacing * (boardSize + 1))) / boardSize;

    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyDownEvent) {
          final key = event.logicalKey;
          if (key == LogicalKeyboardKey.arrowLeft || key == LogicalKeyboardKey.keyA) {
            _handleSwipe(-1, 0);
            return KeyEventResult.handled;
          } else if (key == LogicalKeyboardKey.arrowRight || key == LogicalKeyboardKey.keyD) {
            _handleSwipe(1, 0);
            return KeyEventResult.handled;
          } else if (key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.keyW) {
            _handleSwipe(0, -1);
            return KeyEventResult.handled;
          } else if (key == LogicalKeyboardKey.arrowDown || key == LogicalKeyboardKey.keyS) {
            _handleSwipe(0, 1);
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF050816),
        appBar: AppBar(
          backgroundColor: const Color(0xFF050816),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              AppState().update2048Score(_score);
              Navigator.pop(context);
            },
          ),
          title: Text(
            "2048",
            style: GoogleFonts.playfairDisplay(
              color: Colors.amberAccent,
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          actions: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  "SCORE: $_score",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amberAccent.withValues(alpha: 0.5)),
                ),
                child: Text(
                  "BEST: ${math.max(_score, _highScore)}",
                  style: GoogleFonts.poppins(
                    color: Colors.amberAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Join the tiles to get to 2048!",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: isMobile ? 14 : 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // 2048 Game Board
                      Container(
                        width: maxBoardSize,
                        height: maxBoardSize,
                        padding: EdgeInsets.all(gridSpacing),
                        decoration: BoxDecoration(
                          color: const Color(0xFF11182A),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.amberAccent.withValues(alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onPanStart: (details) {
                            _panStartPos = details.globalPosition;
                          },
                          onPanUpdate: (details) {
                            if (_panStartPos == null) return;
                            final dx = details.globalPosition.dx - _panStartPos!.dx;
                            final dy = details.globalPosition.dy - _panStartPos!.dy;
                            const double threshold = 30.0;
                            if (dx.abs() > threshold || dy.abs() > threshold) {
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
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: boardSize * boardSize,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: boardSize,
                              crossAxisSpacing: gridSpacing,
                              mainAxisSpacing: gridSpacing,
                            ),
                            itemBuilder: (context, index) {
                              int row = index ~/ boardSize;
                              int col = index % boardSize;
                              int value = _grid[row][col];

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
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
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 180,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amberAccent,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 4,
                          ),
                          onPressed: _resetGame,
                          icon: const Icon(Icons.refresh_rounded, size: 20),
                          label: Text(
                            "NEW GAME",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if ((_hasWon && !_keepPlayingAfterWin) || _isGameOver)
                _buildResultOverlay(),
            ],
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
