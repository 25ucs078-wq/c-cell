import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:c_cell_app/services/app_state.dart';
import 'widgets/game_gui_widgets.dart';

class BlockShape {
  final List<Offset> cells;
  final Color color;
  final int id;

  BlockShape({required this.cells, required this.color, required this.id});

  int get width {
    double maxX = 0;
    for (var cell in cells) {
      if (cell.dx > maxX) maxX = cell.dx;
    }
    return maxX.toInt() + 1;
  }

  int get height {
    double maxY = 0;
    for (var cell in cells) {
      if (cell.dy > maxY) maxY = cell.dy;
    }
    return maxY.toInt() + 1;
  }
}

class FloatingText {
  Offset position;
  final String text;
  final Color color;
  double life = 1.0; // 1.0 to 0.0

  FloatingText({
    required this.position,
    required this.text,
    required this.color,
  });
}

class BBParticle {
  Offset position;
  Offset velocity;
  final Color color;
  double radius;
  double life = 1.0;
  double decay;

  BBParticle({
    required this.position,
    required this.velocity,
    required this.color,
    required this.radius,
    required this.decay,
  });
}

class BlockBlastPage extends StatefulWidget {
  const BlockBlastPage({super.key});

  @override
  State<BlockBlastPage> createState() => _BlockBlastPageState();
}

class _BlockBlastPageState extends State<BlockBlastPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _boardKey = GlobalKey();
  final GlobalKey _pageKey = GlobalKey();
  static const int gridSize = 8;
  late List<List<int>> _grid;
  List<BlockShape?> _dock = [];

  // Dragging States
  int? _draggingIdx;
  Offset? _dragPosition;
  Offset? _dragScreenPosition;

  int _score = 0;
  int _elapsedSeconds = 0;
  int _streakCount = 0;
  bool _isGameOver = false;

  // Blasting Particles and Pop Text
  final List<BBParticle> _particles = [];
  final List<FloatingText> _floatingTexts = [];
  late AnimationController _animController;
  Timer? _gameTimer;

  // Block Colors matching the bevel glossy style
  final List<Color> _blockColors = [
    Colors.transparent, // 0 = empty
    const Color(0xFF39FF14), // 1 = Green
    const Color(0xFFFFCC00), // 2 = Yellow
    const Color(0xFFFF3366), // 3 = Red/Pink
    const Color(0xFFFF6600), // 4 = Orange
    const Color(0xFF00E5FF), // 5 = Cyan/Blue
    const Color(0xFFB026FF), // 6 = Purple
  ];

  late List<List<Offset>> _shapeTemplates;
  double _cellSize = 45;
  double _exactBoardSize = 360;

  @override
  void initState() {
    super.initState();
    _initShapeTemplates();
    _resetGame();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // Approx 60fps tick
    )..addListener(_tick);
  }

  void _startAnimationIfNeeded() {
    if (!_animController.isAnimating) {
      _animController.repeat();
    }
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _initShapeTemplates() {
    _shapeTemplates = [
      [const Offset(0, 0)], // 1x1 Dot
      [const Offset(0, 0), const Offset(1, 0)], // 1x2 Horizontal
      [const Offset(0, 0), const Offset(0, 1)], // 1x2 Vertical
      [
        const Offset(0, 0),
        const Offset(1, 0),
        const Offset(2, 0),
      ], // 1x3 Horizontal
      [
        const Offset(0, 0),
        const Offset(0, 1),
        const Offset(0, 2),
      ], // 1x3 Vertical
      [
        const Offset(0, 0),
        const Offset(1, 0),
        const Offset(0, 1),
        const Offset(1, 1),
      ], // 2x2 Square
      [
        const Offset(0, 0),
        const Offset(0, 1),
        const Offset(1, 1),
      ], // L-shape small
      [
        const Offset(0, 0),
        const Offset(1, 0),
        const Offset(1, 1),
      ], // L-shape small rotated
      [
        const Offset(0, 0),
        const Offset(0, 1),
        const Offset(0, 2),
        const Offset(1, 2),
        const Offset(2, 2),
      ], // Large L
      [
        const Offset(0, 0),
        const Offset(1, 0),
        const Offset(2, 0),
        const Offset(1, 1),
      ], // T-shape
      [
        const Offset(0, 0),
        const Offset(1, 0),
        const Offset(2, 0),
        const Offset(3, 0),
      ], // 1x4 Horiz
      [
        const Offset(0, 0),
        const Offset(0, 1),
        const Offset(0, 2),
        const Offset(0, 3),
      ], // 1x4 Vert
    ];
  }

  void _resetGame() {
    _gameTimer?.cancel();
    _elapsedSeconds = 0;
    _streakCount = 0;
    _grid = List.generate(gridSize, (_) => List.generate(gridSize, (_) => 0));
    _score = 0;
    _isGameOver = false;
    _dock = [];
    _particles.clear();
    _floatingTexts.clear();
    _fillDock();
    _startTimer();
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

  void _fillDock() {
    final rand = math.Random();
    _dock = List.generate(3, (index) {
      int templateIdx = rand.nextInt(_shapeTemplates.length);
      int colorIdx = rand.nextInt(_blockColors.length - 1) + 1;
      return BlockShape(
        cells: _shapeTemplates[templateIdx],
        color: _blockColors[colorIdx],
        id: colorIdx,
      );
    });
    _checkGameOver();
  }

  void _checkGameOver() {
    bool hasValidMove = false;

    for (var shape in _dock) {
      if (shape == null) continue;

      for (int r = 0; r < gridSize; r++) {
        for (int c = 0; c < gridSize; c++) {
          if (_canFitShape(shape, r, c)) {
            hasValidMove = true;
            break;
          }
        }
        if (hasValidMove) break;
      }
      if (hasValidMove) break;
    }

    bool allNull = _dock.every((s) => s == null);
    if (allNull) {
      _fillDock();
      return;
    }

    if (!hasValidMove) {
      setState(() {
        _isGameOver = true;
        AppState().updateBlockBlastScore(_score);
      });
    }
  }

  bool _canFitShape(BlockShape shape, int gridRow, int gridCol) {
    for (var cell in shape.cells) {
      int targetRow = gridRow + cell.dy.toInt();
      int targetCol = gridCol + cell.dx.toInt();

      if (targetRow < 0 ||
          targetRow >= gridSize ||
          targetCol < 0 ||
          targetCol >= gridSize) {
        return false;
      }
      if (_grid[targetRow][targetCol] > 0) {
        return false;
      }
    }
    return true;
  }

  bool _tryPlaceShape(BlockShape shape, int gridRow, int gridCol) {
    if (!_canFitShape(shape, gridRow, gridCol)) return false;

    setState(() {
      for (var cell in shape.cells) {
        int targetRow = gridRow + cell.dy.toInt();
        int targetCol = gridCol + cell.dx.toInt();
        _grid[targetRow][targetCol] = shape.id;
      }

      _score += shape.cells.length * 10;
      _checkLinesAndBlast(gridRow, gridCol);
    });

    return true;
  }

  void _checkLinesAndBlast(int placedRow, int placedCol) {
    List<int> fullRows = [];
    List<int> fullCols = [];

    // Check rows
    for (int r = 0; r < gridSize; r++) {
      bool rowFull = true;
      for (int c = 0; c < gridSize; c++) {
        if (_grid[r][c] == 0) {
          rowFull = false;
          break;
        }
      }
      if (rowFull) fullRows.add(r);
    }

    // Check cols
    for (int c = 0; c < gridSize; c++) {
      bool colFull = true;
      for (int r = 0; r < gridSize; r++) {
        if (_grid[r][c] == 0) {
          colFull = false;
          break;
        }
      }
      if (colFull) fullCols.add(c);
    }

    int linesCleared = fullRows.length + fullCols.length;
    if (linesCleared > 0) {
      _streakCount++;
      // Calculate combo score
      int pointsGained = linesCleared * 100 + (linesCleared - 1) * 200;
      _score += pointsGained;

      // Determine feedback text (e.g. "+360 Great!", "+1080 Amazing!")
      String feedbackText = "+$pointsGained";
      if (linesCleared == 1) {
        feedbackText += " Good!";
      } else if (linesCleared == 2) {
        feedbackText += " Great!";
      } else if (linesCleared == 3) {
        feedbackText += " Amazing!";
      } else {
        feedbackText += " Incredible!";
      }

      // Add floating text particle at center of clears
      _floatingTexts.add(
        FloatingText(
          position: Offset(_exactBoardSize / 2, _exactBoardSize / 2 - 20),
          text: feedbackText,
          color: Colors.white,
        ),
      );

      // Trigger cell particles
      final rand = math.Random();

      for (var r in fullRows) {
        for (int c = 0; c < gridSize; c++) {
          Color cellColor = _blockColors[_grid[r][c]];
          _grid[r][c] = 0; // Clear block

          // Spawn particles
          for (int p = 0; p < 4; p++) {
            _particles.add(
              BBParticle(
                position: Offset((c + 0.5) * _cellSize, (r + 0.5) * _cellSize),
                velocity: Offset(
                  (rand.nextDouble() * 3 - 1.5),
                  (rand.nextDouble() * 3 - 1.5),
                ),
                color: cellColor,
                radius: rand.nextDouble() * 4 + 2,
                decay: 0.04,
              ),
            );
          }
        }
      }

      for (var c in fullCols) {
        for (int r = 0; r < gridSize; r++) {
          if (_grid[r][c] == 0) continue; // Already cleared by row
          Color cellColor = _blockColors[_grid[r][c]];
          _grid[r][c] = 0; // Clear block

          // Spawn particles
          for (int p = 0; p < 4; p++) {
            _particles.add(
              BBParticle(
                position: Offset((c + 0.5) * 45, (r + 0.5) * 45),
                velocity: Offset(
                  (rand.nextDouble() * 3 - 1.5),
                  (rand.nextDouble() * 3 - 1.5),
                ),
                color: cellColor,
                radius: rand.nextDouble() * 4 + 2,
                decay: 0.04,
              ),
            );
          }
        }
      }
      _startAnimationIfNeeded();
    } else {
      _streakCount = 0;
    }
  }

  void _tick() {
    if (!mounted) return;

    if (_particles.isEmpty && _floatingTexts.isEmpty) {
      _animController.stop();
      return;
    }

    setState(() {
      // Update Particles
      for (int i = _particles.length - 1; i >= 0; i--) {
        final p = _particles[i];
        p.position += p.velocity;
        p.life -= p.decay;
        if (p.life <= 0) {
          _particles.removeAt(i);
        }
      }

      // Update Pop texts
      for (int i = _floatingTexts.length - 1; i >= 0; i--) {
        final ft = _floatingTexts[i];
        ft.position = Offset(ft.position.dx, ft.position.dy - 1.0); // Float up
        ft.life -= 0.02; // Fade
        if (ft.life <= 0) {
          _floatingTexts.removeAt(i);
        }
      }
    });
  }

  void _resetDragState() {
    setState(() {
      _draggingIdx = null;
      _dragPosition = null;
      _dragScreenPosition = null;
    });
  }

  Offset? _getPreviewGridOffset(double cellSize, double boardSize) {
    if (_draggingIdx == null || _dragPosition == null) return null;
    final shape = _dock[_draggingIdx!];
    if (shape == null) return null;

    // Anchor the shape from the pointer position so the preview snaps to the
    // nearest board cell, matching the reference game's movement feel.
    final double centerOffsetX = (shape.width * cellSize) / 2.0;
    final double centerOffsetY = (shape.height * cellSize) / 2.0;

    final double topLeftX = _dragPosition!.dx - centerOffsetX;
    final double topLeftY = _dragPosition!.dy - centerOffsetY;

    final int col = (topLeftX / cellSize).round();
    final int row = (topLeftY / cellSize).round();

    if (_canFitShape(shape, row, col)) {
      return Offset(col.toDouble(), row.toDouble());
    }
    return null;
  }

  void _onDragEnd(DragEndDetails details, double cellSize) {
    if (_draggingIdx == null) return;

    final shape = _dock[_draggingIdx!];
    if (shape != null && _dragPosition != null) {
      Offset? gridOffset = _getPreviewGridOffset(cellSize, cellSize * gridSize);
      if (gridOffset != null) {
        bool placed = _tryPlaceShape(
          shape,
          gridOffset.dy.toInt(),
          gridOffset.dx.toInt(),
        );
        if (placed) {
          _dock[_draggingIdx!] = null;
          _checkGameOver();
        }
      }
    }

    _resetDragState();
  }

  Widget _buildSmallInfoCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF16255E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF3A5B9D), width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: const Color(0xFFB9CEFF),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: GoogleFonts.bebasNeue(
                fontSize: 22,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return ArcadeIconButton(
      icon: icon,
      onTap: onTap,
      color: const Color(0xFFFFD700),
      tooltip: tooltip,
    );
  }

  Widget _buildDraggingShape(double cellSize) {
    if (_draggingIdx == null || _dragScreenPosition == null) {
      return const SizedBox.shrink();
    }

    final shape = _dock[_draggingIdx!];
    if (shape == null) {
      return const SizedBox.shrink();
    }

    final size = Size(shape.width * cellSize, shape.height * cellSize);
    return Positioned(
      left: _dragScreenPosition!.dx - (size.width / 2),
      top: _dragScreenPosition!.dy - (size.height / 2),
      child: IgnorePointer(
        child: Opacity(
          opacity: 0.95,
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.16),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: CustomPaint(
              size: size,
              painter: MiniShapePainter(shape: shape, boxSize: cellSize),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDockPanel(double cellSize, double dockSlotHeight) {
    final miniBoxSize = (dockSlotHeight * 0.22).clamp(15.0, 20.0);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(dockSlotHeight < 86 ? 10 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFF12214C).withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFF3A579B), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (idx) {
          final shape = _dock.length > idx ? _dock[idx] : null;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onPanStart: shape == null
                    ? null
                    : (details) {
                        setState(() {
                          _draggingIdx = idx;
                          final RenderBox? boardBox =
                              _boardKey.currentContext?.findRenderObject()
                                  as RenderBox?;
                          if (boardBox != null) {
                            _dragPosition = boardBox.globalToLocal(
                              details.globalPosition,
                            );
                          } else {
                            _dragPosition = details.localPosition;
                          }

                          final RenderBox? pageBox =
                              _pageKey.currentContext?.findRenderObject()
                                  as RenderBox?;
                          if (pageBox != null) {
                            _dragScreenPosition = pageBox.globalToLocal(
                              details.globalPosition,
                            );
                          } else {
                            _dragScreenPosition = details.localPosition;
                          }
                        });
                      },
                onPanUpdate: shape == null
                    ? null
                    : (details) {
                        if (_draggingIdx == null) return;
                        setState(() {
                          final RenderBox? boardBox =
                              _boardKey.currentContext?.findRenderObject()
                                  as RenderBox?;
                          if (boardBox != null) {
                            _dragPosition = boardBox.globalToLocal(
                              details.globalPosition,
                            );
                          }

                          final RenderBox? pageBox =
                              _pageKey.currentContext?.findRenderObject()
                                  as RenderBox?;
                          if (pageBox != null) {
                            _dragScreenPosition = pageBox.globalToLocal(
                              details.globalPosition,
                            );
                          }
                        });
                      },
                onPanEnd: shape == null
                    ? null
                    : (details) {
                        _onDragEnd(details, cellSize);
                      },
                onPanCancel: shape == null ? null : () => _resetDragState(),
                child: Container(
                  height: dockSlotHeight,
                  decoration: BoxDecoration(
                    color: shape == null
                        ? const Color(0xFF174B97)
                        : const Color(0xFF2D63B8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF3A5B9D),
                      width: 1.3,
                    ),
                  ),
                  child: Center(
                    child: shape == null
                        ? Icon(
                            Icons.check,
                            color: const Color(0xFF91A6C3),
                            size: 28,
                          )
                        : CustomPaint(
                            size: Size(
                              shape.width * miniBoxSize,
                              shape.height * miniBoxSize,
                            ),
                            painter: MiniShapePainter(
                              shape: shape,
                              boxSize: miniBoxSize,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildGameOverOverlay() {
    return Positioned.fill(
      child: ArcadeResultOverlay(
        title: 'Game Over',
        subtitle: 'No positions are available. Try a new block route.',
        score: 'Score $_score',
        color: const Color(0xFFFFD700),
        buttonLabel: 'Play Again',
        onButtonTap: () {
          setState(() {
            _resetGame();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final safePadding = MediaQuery.of(context).padding;
    final safeHeight = screenHeight - safePadding.top - safePadding.bottom;
    final compactHeight = safeHeight < 680;
    final dockSlotHeight = compactHeight ? 72.0 : 98.0;
    final dockPanelHeight = dockSlotHeight + (compactHeight ? 20.0 : 32.0);

    return Stack(
      key: _pageKey,
      children: [
        Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0F1A3F), Color(0xFF112251)],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        _buildHeaderButton(
                          icon: Icons.arrow_back_rounded,
                          tooltip: 'Back',
                          onTap: () {
                            AppState().updateBlockBlastScore(_score);
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BLOCK BLAST',
                                style: GoogleFonts.orbitron(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFFFD700),
                                  letterSpacing: 1.1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Puzzle arcade challenge',
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  color: const Color(0xFFB0C1F7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildHeaderButton(
                          icon: Icons.restart_alt_rounded,
                          tooltip: 'Restart',
                          onTap: () {
                            setState(() {
                              _resetGame();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSmallInfoCard('Score', '$_score'),
                        _buildSmallInfoCard(
                          'Time',
                          _formatTime(_elapsedSeconds),
                        ),
                        _buildSmallInfoCard('Streak', '$_streakCount'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  Expanded(
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double availableWidth = constraints.maxWidth;
                          final double availableHeight = constraints.maxHeight;
                          final double spacerHeight = compactHeight ? 10.0 : 16.0;
                          
                          // Height consumed by board decoration (padding: 14 * 2 + border: 2 = 30)
                          // plus spacer, plus dock panel height
                          final double verticalExtra = 28.0 + spacerHeight + dockPanelHeight;
                          final double maxBoardHeight = math.max(120.0, availableHeight - verticalExtra);
                          final double maxBoardWidth = math.max(120.0, availableWidth - 48.0);
                          
                          double boardWidth = math.min(maxBoardWidth, maxBoardHeight);
                          boardWidth = boardWidth.clamp(140.0, 360.0);
                          
                          double exactBoardSize = (boardWidth / gridSize).floorToDouble() * gridSize;
                          if (exactBoardSize <= 0) exactBoardSize = boardWidth;
                          double cellSize = exactBoardSize / gridSize;
                          
                          // Save to private state fields so they can be accessed dynamically
                          _cellSize = cellSize;
                          _exactBoardSize = exactBoardSize;
                          
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: exactBoardSize + 28,
                                height: exactBoardSize + 28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFF122248), Color(0xFF162B65)],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.18),
                                      blurRadius: 28,
                                      offset: const Offset(0, 18),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(14),
                                child: Container(
                                  key: _boardKey,
                                  width: exactBoardSize,
                                  height: exactBoardSize,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF103D9B),
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(
                                      color: const Color(0xFF4B70C4),
                                      width: 1.4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.22),
                                        blurRadius: 20,
                                        offset: const Offset(0, 12),
                                      ),
                                    ],
                                  ),
                                  child: CustomPaint(
                                    size: Size(exactBoardSize, exactBoardSize),
                                    painter: GridPainter(
                                      grid: _grid,
                                      gridColors: _blockColors,
                                      cellSize: cellSize,
                                      previewShape: _draggingIdx != null
                                          ? _dock[_draggingIdx!]
                                          : null,
                                      previewOffset: _getPreviewGridOffset(
                                        cellSize,
                                        exactBoardSize,
                                      ),
                                      particles: _particles,
                                      floatingTexts: _floatingTexts,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: spacerHeight),
                              _buildDockPanel(cellSize, dockSlotHeight),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_draggingIdx != null && _dragScreenPosition != null)
          _buildDraggingShape(_cellSize),
        if (_isGameOver) _buildGameOverOverlay(),
      ],
    );
  }
}

class GridPainter extends CustomPainter {
  final List<List<int>> grid;
  final List<Color> gridColors;
  final double cellSize;
  final BlockShape? previewShape;
  final Offset? previewOffset;
  final List<BBParticle> particles;
  final List<FloatingText> floatingTexts;

  GridPainter({
    required this.grid,
    required this.gridColors,
    required this.cellSize,
    this.previewShape,
    this.previewOffset,
    required this.particles,
    required this.floatingTexts,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Grid slot slots
    final slotPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xFF0B3B97), const Color(0xFF0A2A75)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final slotBorderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        Rect rect = Rect.fromLTWH(
          c * cellSize,
          r * cellSize,
          cellSize,
          cellSize,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect.deflate(2.0), const Radius.circular(5)),
          slotPaint,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect.deflate(2.0), const Radius.circular(5)),
          slotBorderPaint,
        );
      }
    }

    // 2. Draw placed blocks with Glossy 3D-bevel style
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        int val = grid[r][c];
        if (val > 0) {
          Rect rect = Rect.fromLTWH(
            c * cellSize,
            r * cellSize,
            cellSize,
            cellSize,
          );
          _drawGlossyBlock(canvas, rect.deflate(2.0), gridColors[val]);
        }
      }
    }

    // 3. Draw Landing preview blocks
    if (previewShape != null && previewOffset != null) {
      bool fits = true;
      for (var cell in previewShape!.cells) {
        int r = previewOffset!.dy.toInt() + cell.dy.toInt();
        int c = previewOffset!.dx.toInt() + cell.dx.toInt();
        if (r < 0 ||
            r >= grid.length ||
            c < 0 ||
            c >= grid[r].length ||
            grid[r][c] > 0) {
          fits = false;
          break;
        }
      }

      if (fits) {
        final previewBorder = Paint()
          ..color = previewShape!.color.withValues(alpha: 0.8)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

        final previewSlotPaint = Paint()
          ..color = const Color(0xFF1662C2).withValues(alpha: 0.18)
          ..style = PaintingStyle.fill;

        for (var cell in previewShape!.cells) {
          int r = previewOffset!.dy.toInt() + cell.dy.toInt();
          int c = previewOffset!.dx.toInt() + cell.dx.toInt();
          Rect rect = Rect.fromLTWH(
            c * cellSize,
            r * cellSize,
            cellSize,
            cellSize,
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              rect.deflate(2.0),
              const Radius.circular(5),
            ),
            previewSlotPaint,
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              rect.deflate(2.0),
              const Radius.circular(5),
            ),
            previewBorder,
          );
        }
      }
    }

    // 4. Draw explosion particles
    for (var p in particles) {
      final pPaint = Paint()
        ..color = p.color.withValues(alpha: p.life)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(p.position, p.radius * p.life, pPaint);
    }

    // 5. Draw Floating combo score popups
    for (var ft in floatingTexts) {
      final textSpan = TextSpan(
        text: ft.text,
        style: GoogleFonts.bebasNeue(
          color: ft.color.withValues(alpha: ft.life),
          fontSize: 26,
          letterSpacing: 1.5,
          shadows: [
            Shadow(
              color: Colors.purple.withValues(alpha: 0.8 * ft.life),
              blurRadius: 10,
            ),
          ],
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(canvas, ft.position);
    }
  }

  // Draw block with bevel edge highlighting to achieve the screenshot's 3D look
  void _drawGlossyBlock(Canvas canvas, Rect rect, Color baseColor) {
    final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [baseColor, baseColor.withValues(alpha: 0.85)],
      ).createShader(rect)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, fillPaint);

    final glowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.24)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          rect.left + 2,
          rect.top + 2,
          rect.width - 4,
          rect.height * 0.45,
        ),
        const Radius.circular(8),
      ),
      glowPaint,
    );

    final borderPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(rrect, borderPaint);

    // Bevel highlights: Light line at top & left
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final pathLight = Path()
      ..moveTo(rect.left + 2, rect.bottom - 4)
      ..lineTo(rect.left + 2, rect.top + 2)
      ..lineTo(rect.right - 4, rect.top + 2);
    canvas.drawPath(pathLight, highlightPaint);

    // Bevel shadow: Dark line at bottom & right
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.45)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final pathDark = Path()
      ..moveTo(rect.left + 4, rect.bottom - 2)
      ..lineTo(rect.right - 2, rect.bottom - 2)
      ..lineTo(rect.right - 2, rect.top + 4);
    canvas.drawPath(pathDark, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => true;
}

class DraggedShapePainter extends CustomPainter {
  final BlockShape shape;
  final double cellSize;

  DraggedShapePainter({required this.shape, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    for (var cell in shape.cells) {
      Rect rect = Rect.fromLTWH(
        cell.dx * cellSize,
        cell.dy * cellSize,
        cellSize,
        cellSize,
      );
      _drawDraggedBlock(canvas, rect.deflate(2.0), shape.color);
    }
  }

  void _drawDraggedBlock(Canvas canvas, Rect rect, Color baseColor) {
    final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          baseColor.withValues(alpha: 0.95),
          baseColor.withValues(alpha: 0.7),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, fillPaint);

    final borderPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.45)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(rrect, borderPaint);

    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final pathLight = Path()
      ..moveTo(rect.left + 2, rect.bottom - 4)
      ..lineTo(rect.left + 2, rect.top + 2)
      ..lineTo(rect.right - 4, rect.top + 2);
    canvas.drawPath(pathLight, highlightPaint);

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final pathDark = Path()
      ..moveTo(rect.left + 4, rect.bottom - 2)
      ..lineTo(rect.right - 2, rect.bottom - 2)
      ..lineTo(rect.right - 2, rect.top + 4);
    canvas.drawPath(pathDark, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant DraggedShapePainter oldDelegate) => false;
}

class MiniShapePainter extends CustomPainter {
  final BlockShape shape;
  final double boxSize;

  MiniShapePainter({required this.shape, required this.boxSize});

  @override
  void paint(Canvas canvas, Size size) {
    for (var cell in shape.cells) {
      Rect rect = Rect.fromLTWH(
        cell.dx * boxSize,
        cell.dy * boxSize,
        boxSize,
        boxSize,
      );
      _drawMiniBlock(canvas, rect.deflate(1.0), shape.color);
    }
  }

  void _drawMiniBlock(Canvas canvas, Rect rect, Color baseColor) {
    final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(3));

    final fillPaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, fillPaint);

    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final pathLight = Path()
      ..moveTo(rect.left + 1, rect.bottom - 2)
      ..lineTo(rect.left + 1, rect.top + 1)
      ..lineTo(rect.right - 2, rect.top + 1);
    canvas.drawPath(pathLight, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant MiniShapePainter oldDelegate) => false;
}
