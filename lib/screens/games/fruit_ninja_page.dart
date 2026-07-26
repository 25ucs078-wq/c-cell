import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:c_cell_app/services/app_state.dart';
import 'widgets/game_gui_widgets.dart';
import 'widgets/game_layout_utils.dart';

enum FNFruitType { watermelon, apple, orange, bomb }

class FNFruit {
  Offset position;
  Offset velocity;
  final double radius;
  final FNFruitType type;
  bool isSliced = false;

  // Sliced piece physics
  Offset? piece1Pos;
  Offset? piece1Vel;
  Offset? piece2Pos;
  Offset? piece2Vel;
  double spinAngle = 0.0;
  double spinSpeed = 0.0;

  FNFruit({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.type,
  }) {
    spinSpeed = (math.Random().nextDouble() * 2 - 1) * 0.1;
  }

  void update(double gravity) {
    if (!isSliced) {
      velocity = Offset(velocity.dx, velocity.dy + gravity);
      position += velocity;
      spinAngle += spinSpeed;
    } else {
      // Update pieces
      piece1Vel = Offset(piece1Vel!.dx, piece1Vel!.dy + gravity);
      piece1Pos = piece1Pos! + piece1Vel!;

      piece2Vel = Offset(piece2Vel!.dx, piece2Vel!.dy + gravity);
      piece2Pos = piece2Pos! + piece2Vel!;
    }
  }

  void slice(Offset sliceDirection) {
    isSliced = true;
    piece1Pos = position;
    piece2Pos = position;

    // Split perpendicular to slice direction
    double normalX = -sliceDirection.dy;
    double normalY = sliceDirection.dx;
    double len = math.sqrt(normalX * normalX + normalY * normalY);
    if (len > 0) {
      normalX /= len;
      normalY /= len;
    }

    piece1Vel = Offset(velocity.dx + normalX * 4, velocity.dy + normalY * 4);
    piece2Vel = Offset(velocity.dx - normalX * 4, velocity.dy - normalY * 4);
  }
}

class FNParticle {
  Offset position;
  Offset velocity;
  final Color color;
  double life = 1.0;
  final double decay = 0.04;

  FNParticle({
    required this.position,
    required this.velocity,
    required this.color,
  });

  void update() {
    velocity = Offset(velocity.dx, velocity.dy + 0.1);
    position += velocity;
    life -= decay;
  }
}

class FruitNinjaPage extends StatefulWidget {
  const FruitNinjaPage({super.key});

  @override
  State<FruitNinjaPage> createState() => _FruitNinjaPageState();
}

class _FruitNinjaPageState extends State<FruitNinjaPage>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  bool _isPlaying = false;
  bool _isGameOver = false;

  double _screenWidth = 360.0;
  double _screenHeight = 600.0;
  final double _gravity = 0.18;

  final List<FNFruit> _fruits = [];
  final List<FNParticle> _particles = [];
  final List<Offset> _swipePoints = [];

  int _score = 0;
  int _highScore = 0;
  int _strikes = 0; // max 3 misses

  int _spawnIntervalTicks = 70;
  int _ticksSinceLastSpawn = 0;

  @override
  void initState() {
    super.initState();
    _highScore = AppState().fruitNinjaHS;
    _ticker = createTicker(_tick);
    _resetGame();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _resetGame() {
    _score = 0;
    _strikes = 0;
    _isGameOver = false;
    _isPlaying = false;
    _fruits.clear();
    _particles.clear();
    _swipePoints.clear();
    _ticksSinceLastSpawn = 0;
  }

  void _startGame() {
    setState(() {
      _isPlaying = true;
      _isGameOver = false;
    });
    _ticker.start();
  }

  void _restartGame() {
    setState(() {
      _resetGame();
    });
    _startGame();
  }

  void _finishGame() {
    _isGameOver = true;
    _ticker.stop();
    AppState().updateFruitNinjaScore(_score);
    _highScore = math.max(_highScore, _score);
  }

  void _spawnWave() {
    final rand = math.Random();
    int count = rand.nextInt(2) + 1; // 1 to 2 items

    for (int i = 0; i < count; i++) {
      double startX = rand.nextDouble() * (_screenWidth - 80) + 40;
      double startY = _screenHeight + 20;

      // arc towards the center
      double targetX = _screenWidth / 2 + (rand.nextDouble() * 100 - 50);
      double hangTime = 60.0; // ticks

      double vx = (targetX - startX) / hangTime;
      // standard kinematics: y = y0 + vt + 0.5gt^2 -> v = (y - y0 - 0.5gt^2)/t
      double targetY =
          _screenHeight * 0.2 + rand.nextDouble() * (_screenHeight * 0.25);
      double vy =
          (targetY - startY - (0.5 * _gravity * hangTime * hangTime)) /
          hangTime;

      // 18% chance of bomb
      FNFruitType type = rand.nextDouble() < 0.18
          ? FNFruitType.bomb
          : FNFruitType.values[rand.nextInt(3)];

      _fruits.add(
        FNFruit(
          position: Offset(startX, startY),
          velocity: Offset(vx, vy),
          radius: type == FNFruitType.bomb ? 24.0 : 28.0,
          type: type,
        ),
      );
    }
  }

  void _checkSwipeCollisions() {
    if (_swipePoints.length < 2) return;

    // Check intersection between the last swipe segment and active fruits
    Offset p1 = _swipePoints[_swipePoints.length - 2];
    Offset p2 = _swipePoints[_swipePoints.length - 1];

    Offset swipeVec = p2 - p1;

    for (var fruit in _fruits) {
      if (fruit.isSliced) continue;

      // Circle-Line segment intersection check
      // Find projection of circle center onto line segment
      Offset circCenter = fruit.position;
      double r = fruit.radius;

      double t =
          ((circCenter.dx - p1.dx) * (p2.dx - p1.dx) +
              (circCenter.dy - p1.dy) * (p2.dy - p1.dy)) /
          (swipeVec.dx * swipeVec.dx + swipeVec.dy * swipeVec.dy);

      t = t.clamp(0.0, 1.0);
      Offset projection = p1 + swipeVec * t;

      double dist = (circCenter - projection).distance;

      if (dist <= r) {
        // Collided! Slice it
        _sliceFruit(fruit, swipeVec);
      }
    }
  }

  void _sliceFruit(FNFruit fruit, Offset swipeVec) {
    setState(() {
      fruit.slice(swipeVec);

      if (fruit.type == FNFruitType.bomb) {
        // Exploded! Game Over
        _finishGame();
        _triggerBombFlash();
      } else {
        _score += 10;

        // spawn particles
        Color splashColor = _getFruitColor(fruit.type);
        final rand = math.Random();
        for (int i = 0; i < 12; i++) {
          double angle = rand.nextDouble() * 2 * math.pi;
          double speed = rand.nextDouble() * 5.0 + 2.0;
          _particles.add(
            FNParticle(
              position: fruit.position,
              velocity: Offset(
                math.cos(angle) * speed,
                math.sin(angle) * speed,
              ),
              color: splashColor,
            ),
          );
        }
      }
    });
  }

  Color _getFruitColor(FNFruitType type) {
    switch (type) {
      case FNFruitType.watermelon:
        return Colors.redAccent;
      case FNFruitType.apple:
        return Colors.greenAccent;
      case FNFruitType.orange:
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }

  void _triggerBombFlash() {
    // Spawn red/yellow explosion particles
    final rand = math.Random();
    for (int i = 0; i < 40; i++) {
      double angle = rand.nextDouble() * 2 * math.pi;
      double speed = rand.nextDouble() * 8.0 + 3.0;
      _particles.add(
        FNParticle(
          position: _fruits
              .firstWhere((f) => f.type == FNFruitType.bomb && f.isSliced)
              .position,
          velocity: Offset(math.cos(angle) * speed, math.sin(angle) * speed),
          color: rand.nextBool() ? Colors.orange : Colors.yellow,
        ),
      );
    }
  }

  void _tick(Duration elapsed) {
    if (!_isPlaying || _isGameOver) return;

    _ticksSinceLastSpawn++;
    if (_ticksSinceLastSpawn >= _spawnIntervalTicks) {
      _spawnWave();
      _ticksSinceLastSpawn = 0;
      // speed up spawns slowly
      _spawnIntervalTicks = math.max(40, _spawnIntervalTicks - 1);
    }

    // Update Fruits
    for (int i = _fruits.length - 1; i >= 0; i--) {
      FNFruit fruit = _fruits[i];
      fruit.update(_gravity);

      // check bottom exit bounds
      if (!fruit.isSliced) {
        if (fruit.position.dy > _screenHeight + 40 && fruit.velocity.dy > 0) {
          // Missed! Apply strike if not a bomb
          if (fruit.type != FNFruitType.bomb) {
            _strikes++;
            if (_strikes >= 3) {
              setState(() {
                _finishGame();
              });
            }
          }
          _fruits.removeAt(i);
        }
      } else {
        // Pieces exit screen check
        if (fruit.piece1Pos!.dy > _screenHeight + 40 &&
            fruit.piece2Pos!.dy > _screenHeight + 40) {
          _fruits.removeAt(i);
        }
      }
    }

    // Update Particles
    for (int i = _particles.length - 1; i >= 0; i--) {
      var p = _particles[i];
      p.update();
      if (p.life <= 0) {
        _particles.removeAt(i);
      }
    }

    // Decay swipe points
    if (_swipePoints.isNotEmpty) {
      _swipePoints.removeAt(0); // remove oldest point to create fade trail
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "FRUIT NINJA",
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            if (_isPlaying) _ticker.stop();
            AppState().updateFruitNinjaScore(_score);
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final scale = resolveResponsiveScale(width: constraints.maxWidth);
          _screenWidth = constraints.maxWidth;
          _screenHeight = constraints.maxHeight;

          return GestureDetector(
            onPanStart: (details) {
              if (!_isPlaying || _isGameOver) return;
              setState(() {
                _swipePoints.clear();
                _swipePoints.add(details.localPosition);
              });
            },
            onPanUpdate: (details) {
              if (!_isPlaying || _isGameOver) return;
              setState(() {
                _swipePoints.add(details.localPosition);
                if (_swipePoints.length > 8) {
                  _swipePoints.removeAt(0);
                }
                _checkSwipeCollisions();
              });
            },
            onPanEnd: (details) {
              setState(() {
                _swipePoints.clear();
              });
            },
            child: Stack(
              children: [
                // Game Canvas painting
                Positioned.fill(
                  child: CustomPaint(
                    painter: FruitNinjaPainter(
                      fruits: _fruits,
                      particles: _particles,
                      swipePoints: _swipePoints,
                    ),
                  ),
                ),

                // HUD Scores & Strikes
                Positioned(
                  top: 14,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F314B),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF0E1C37),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "JUICE SCORE",
                              style: GoogleFonts.bebasNeue(
                                color: Colors.white70,
                                fontSize: 12 * scale,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              "$_score",
                              style: GoogleFonts.bebasNeue(
                                color: Colors.white,
                                fontSize: 24 * scale,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "PERSONAL BEST",
                              style: GoogleFonts.bebasNeue(
                                color: Colors.white70,
                                fontSize: 12 * scale,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              "${math.max(_score, _highScore)}",
                              style: GoogleFonts.bebasNeue(
                                color: Colors.white,
                                fontSize: 18 * scale,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Icon(
                                Icons.cancel,
                                color: index < _strikes
                                    ? Colors.redAccent
                                    : const Color(0xFFCFDCEE),
                                size: 22 * scale,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),

                // Splash Intro Overlay
                if (!_isPlaying && !_isGameOver)
                  Container(
                    color: const Color(0xFF111827).withValues(alpha: 0.92),
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent.withValues(alpha: 0.18),
                              blurRadius: 34,
                              offset: const Offset(0, 18),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 82,
                              height: 82,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF4D6D),
                                    Color(0xFFFFC857),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.withValues(
                                      alpha: 0.26,
                                    ),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.content_cut_rounded,
                                color: Colors.white,
                                size: 38,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              "FRUIT NINJA",
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Swipe through fruit arcs, build your score, and keep the bombs untouched.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                color: Colors.white60,
                                fontSize: 13,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ArcadeActionButton(
                              label: "Swipe To Play",
                              icon: Icons.play_arrow_rounded,
                              color: const Color(0xFFFF4D6D),
                              onTap: _startGame,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                if (_isGameOver)
                  ArcadeResultOverlay(
                    title: "Game Over",
                    subtitle:
                        "Final strike taken. Slice cleaner and stay away from bombs.",
                    score:
                        "Score $_score  •  Best ${math.max(_score, _highScore)}",
                    color: const Color(0xFFFF4D6D),
                    buttonLabel: "Try Again",
                    onButtonTap: _restartGame,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FruitNinjaPainter extends CustomPainter {
  final List<FNFruit> fruits;
  final List<FNParticle> particles;
  final List<Offset> swipePoints;

  FruitNinjaPainter({
    required this.fruits,
    required this.particles,
    required this.swipePoints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawWoodBackground(canvas, size);

    // Draw background particles / ambient glow
    final ambientPaint = Paint()
      ..color = const Color(0xFF151935).withValues(alpha: 0.05);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.4,
      ambientPaint,
    );

    // 1. Draw Splash Particles
    for (var p in particles) {
      final pPaint = Paint()
        ..color = p.color.withValues(alpha: p.life)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(p.position, 3.5 * p.life, pPaint);
    }

    // 2. Draw Fruits
    for (var fruit in fruits) {
      if (!fruit.isSliced) {
        _drawWholeFruit(canvas, fruit);
      } else {
        _drawSlicedFruit(canvas, fruit);
      }
    }

    // 3. Draw Swipe Blade Trail
    if (swipePoints.length >= 2) {
      final trailPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final glowPaint = Paint()
        ..color = Colors.cyanAccent.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

      // Draw tapered line connecting swipe points
      for (int i = 0; i < swipePoints.length - 1; i++) {
        double factor = (i + 1) / swipePoints.length;
        double w = factor * 5.0;

        trailPaint.strokeWidth = w;
        glowPaint.strokeWidth = w + 4.0;

        canvas.drawLine(swipePoints[i], swipePoints[i + 1], glowPaint);
        canvas.drawLine(swipePoints[i], swipePoints[i + 1], trailPaint);
      }
    }
  }

  void _drawWholeFruit(Canvas canvas, FNFruit fruit) {
    final fillPaint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.save();
    canvas.translate(fruit.position.dx, fruit.position.dy);
    canvas.rotate(fruit.spinAngle);

    //ect rect = Rect.fromCircle(center: Offset.zero, radius: fruit.radius);

    switch (fruit.type) {
      case FNFruitType.watermelon:
        // Red inside, Green outer rind
        fillPaint.color = Colors.redAccent;
        strokePaint.color = Colors.green;
        canvas.drawCircle(Offset.zero, fruit.radius, fillPaint);
        canvas.drawCircle(Offset.zero, fruit.radius, strokePaint);

        // Seeds
        final seedPaint = Paint()..color = Colors.black87;
        canvas.drawCircle(const Offset(-6, -4), 1.5, seedPaint);
        canvas.drawCircle(const Offset(6, 4), 1.5, seedPaint);
        canvas.drawCircle(const Offset(2, -8), 1.5, seedPaint);
        break;

      case FNFruitType.apple:
        // Crimson Red
        fillPaint.color = Colors.red;
        strokePaint.color = Colors.redAccent;
        canvas.drawCircle(Offset.zero, fruit.radius, fillPaint);
        canvas.drawCircle(Offset.zero, fruit.radius, strokePaint);

        // stem
        final stemPaint = Paint()
          ..color = Colors.brown
          ..strokeWidth = 2.0;

        canvas.drawLine(
          const Offset(0, -6),
          Offset(0, -fruit.radius),
          stemPaint,
        );
        break;

      case FNFruitType.orange:
        // Juicy Orange
        fillPaint.color = Colors.orange;
        strokePaint.color = Colors.orangeAccent;
        canvas.drawCircle(Offset.zero, fruit.radius, fillPaint);
        canvas.drawCircle(Offset.zero, fruit.radius, strokePaint);

        // inner segments
        final segPaint = Paint()
          ..color = Colors.white54
          ..strokeWidth = 1.0;
        for (int i = 0; i < 8; i++) {
          double angle = i * math.pi / 4;
          canvas.drawLine(
            Offset.zero,
            Offset(
              math.cos(angle) * fruit.radius,
              math.sin(angle) * fruit.radius,
            ),
            segPaint,
          );
        }
        break;

      case FNFruitType.bomb:
        // Metal black sphere with orange spark fuse
        fillPaint.color = const Color(0xFF1A1A1A);
        strokePaint.color = Colors.redAccent;
        canvas.drawCircle(Offset.zero, fruit.radius, fillPaint);
        canvas.drawCircle(Offset.zero, fruit.radius, strokePaint);

        // fuse
        final fusePaint = Paint()
          ..color = Colors.amber
          ..strokeWidth = 2.0;
        canvas.drawLine(Offset.zero, const Offset(12, -18), fusePaint);
        canvas.drawCircle(
          const Offset(12, -18),
          3,
          Paint()..color = Colors.yellowAccent,
        );
        break;
    }

    canvas.restore();
  }

  void _drawSlicedFruit(Canvas canvas, FNFruit fruit) {
    if (fruit.type == FNFruitType.bomb) {
      return; // bomb has explosion particles, no pieces
    }

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw Piece 1 (Half circle)
    canvas.save();
    canvas.translate(fruit.piece1Pos!.dx, fruit.piece1Pos!.dy);
    canvas.rotate(fruit.spinAngle);

    Rect r1 = Rect.fromCircle(center: Offset.zero, radius: fruit.radius);
    _setColorsForType(fruit.type, fillPaint, strokePaint);

    // Draw upper half
    canvas.drawArc(r1, 0, math.pi, true, fillPaint);
    canvas.drawArc(r1, 0, math.pi, true, strokePaint);
    canvas.restore();

    // Draw Piece 2 (Other half circle)
    canvas.save();
    canvas.translate(fruit.piece2Pos!.dx, fruit.piece2Pos!.dy);
    canvas.rotate(fruit.spinAngle + math.pi);

    // Draw lower half
    canvas.drawArc(r1, 0, math.pi, true, fillPaint);
    canvas.drawArc(r1, 0, math.pi, true, strokePaint);
    canvas.restore();
  }

  void _setColorsForType(FNFruitType type, Paint fill, Paint stroke) {
    switch (type) {
      case FNFruitType.watermelon:
        fill.color = Colors.redAccent;
        stroke.color = Colors.green;
        break;
      case FNFruitType.apple:
        fill.color = Colors.red;
        stroke.color = Colors.redAccent;
        break;
      case FNFruitType.orange:
        fill.color = Colors.orange;
        stroke.color = Colors.orangeAccent;
        break;
      default:
        fill.color = Colors.grey;
        stroke.color = Colors.white;
    }
  }

  void _drawWoodBackground(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()..color = const Color(0xFF8B5A2B);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    final Paint plankPaint = Paint()..color = const Color(0xFF9E6736);
    final double plankHeight = 48.0;
    final int plankCount = (size.height / plankHeight).ceil();

    for (int i = 0; i < plankCount; i++) {
      final double y = i * plankHeight;
      canvas.drawRect(
        Rect.fromLTWH(0, y, size.width, plankHeight - 6),
        plankPaint,
      );
      final Paint linePaint = Paint()
        ..color = const Color(0xFF7A4322)
        ..strokeWidth = 2.0;
      canvas.drawLine(
        Offset(0, y + plankHeight - 7),
        Offset(size.width, y + plankHeight - 7),
        linePaint,
      );
      canvas.drawLine(Offset(0, y + 6), Offset(size.width, y + 6), linePaint);
    }

    final Paint grainPaint = Paint()
      ..color = const Color(0xFF7A4322).withValues(alpha: 0.12)
      ..strokeWidth = 1.0;

    for (int i = 0; i < plankCount; i++) {
      final double y = i * plankHeight;
      final double grainOffset = (i % 2 == 0) ? 12.0 : 6.0;
      for (double x = 0; x < size.width; x += 28.0) {
        final double xOffset = x + (x % 56 == 0 ? grainOffset : 0.0);
        canvas.drawLine(
          Offset(xOffset, y + 12),
          Offset(xOffset + 6, y + plankHeight - 18),
          grainPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant FruitNinjaPainter oldDelegate) => true;
}
