import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:c_cell_app/services/app_state.dart';
import 'widgets/game_gui_widgets.dart';

class FlappyBirdPage extends StatefulWidget {
  const FlappyBirdPage({super.key});

  @override
  State<FlappyBirdPage> createState() => _FlappyBirdPageState();
}

// class _Pipe {
//   double x;
//   final double gapY;
//   bool scored;

//   _Pipe({required this.x, required this.gapY, this.scored = false});
// }
class _Pipe {
  double x;
  double gapY;
  bool scored = false;

  _Pipe({
    required this.x,
    required this.gapY,
  });
}

class _FlappyBirdPageState extends State<FlappyBirdPage> with SingleTickerProviderStateMixin {
  static const double worldWidth = 360;
  static const double worldHeight = 640;
  static const double groundHeight = 88;
  static const double birdX = 92;
  static const double birdSize = 34;
  static const double pipeWidth = 60;
  static const double pipeGap = 150;
  static const double pipeSpacing = 190;
  static const double gravity = 1120;
  static const double flapVelocity = -390;
  static const double pipeSpeed = 132;
  static const double groundSpeed = 132;
  static const double cloudSpeed = 24;

  late final AnimationController _ticker;
  final FocusNode _focusNode = FocusNode();
  final math.Random _random = math.Random();
  final List<_Pipe> _pipes = [];

  DateTime? _lastTick;
  double _birdY = 248;
  double _velocity = 0;
  double _groundOffset = 0;
  double _cloudOffset = 0;
  double _wingPhase = 0;
  int _score = 0;
  int _highScore = 0;
  bool _started = false;
  bool _gameOver = false;
  bool _isExiting = false;
  bool _scoreSaved = false;

  @override
  void initState() {
    super.initState();
    _highScore = AppState().flappyBirdHS;
    _ticker = AnimationController(vsync: this, duration: const Duration(milliseconds: 16))
      ..addListener(_tick)
      ..repeat();
    _resetGame(startRunning: false);
  }

  @override
  void dispose() {
    _stopGameLoop();
    _ticker.removeListener(_tick);
    _ticker.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _stopGameLoop() {
    if (_ticker.isAnimating) {
      _ticker.stop(canceled: true);
    }
    _lastTick = null;
  }

  void _saveScoreOnce() {
    if (_scoreSaved) return;
    _scoreSaved = true;
    AppState().updateFlappyBirdScore(_score);
  }

  void _exitGame() {
    if (_isExiting) return;
    _isExiting = true;
    _saveScoreOnce();
    _stopGameLoop();
    _focusNode.unfocus();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _resetGame({bool startRunning = true}) {
    _pipes
      ..clear()
      ..addAll([
        _Pipe(x: worldWidth + 110, gapY: _nextGapY()),
        _Pipe(x: worldWidth + 110 + pipeSpacing, gapY: _nextGapY()),
        _Pipe(x: worldWidth + 110 + pipeSpacing * 2, gapY: _nextGapY()),
      ]);
    setState(() {
      _birdY = 248;
      _velocity = 0;
      _groundOffset = 0;
      _cloudOffset = 0;
      _wingPhase = 0;
      _score = 0;
      _started = startRunning;
      _gameOver = false;
      _scoreSaved = false;
      _lastTick = DateTime.now();
    });
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_focusNode.canRequestFocus) {
          _focusNode.requestFocus();
        }
      });
    }
  }

  double _nextGapY() {
    const topMargin = 132.0;
    const bottomMargin = worldHeight - groundHeight - 112;
    return topMargin + _random.nextDouble() * (bottomMargin - topMargin);
  }

  void _flap() {
    if (_gameOver || _isExiting) return;
    setState(() {
      _started = true;
      _velocity = flapVelocity;
      _wingPhase = 0;
      _lastTick = DateTime.now();
    });
    _focusNode.requestFocus();
  }

  void _tick() {
    final now = DateTime.now();
    final previous = _lastTick ?? now;
    final dt = (now.difference(previous).inMicroseconds / 1000000).clamp(0.0, 0.032);
    _lastTick = now;
    if (!mounted || _isExiting) return;

    setState(() {
      _wingPhase = (_wingPhase + dt * (_started && !_gameOver ? 10 : 3.2)) % 1;
      _groundOffset = (_groundOffset + groundSpeed * dt) % 24;
      _cloudOffset = (_cloudOffset + cloudSpeed * dt) % worldWidth;

      if (!_started || _gameOver) {
        if (!_started) {
          _birdY = 248 + math.sin(_wingPhase * math.pi * 2) * 5;
        }
        return;
      }

      _velocity += gravity * dt;
      _birdY += _velocity * dt;

      for (final pipe in _pipes) {
        pipe.x -= pipeSpeed * dt;
        if (!pipe.scored && pipe.x + pipeWidth < birdX) {
          pipe.scored = true;
          _score++;
          if (_score > _highScore) {
            _highScore = _score;
            AppState().updateFlappyBirdScore(_score);
          }
        }
      }

      if (_pipes.first.x + pipeWidth < -8) {
        final lastX = _pipes.map((pipe) => pipe.x).reduce(math.max);
        _pipes.removeAt(0);
        _pipes.add(_Pipe(x: lastX + pipeSpacing, gapY: _nextGapY()));
      }

      if (_hasCollision()) {
        _gameOver = true;
        _saveScoreOnce();
      }
    });
  }

  bool _hasCollision() {
    final birdRect = Rect.fromLTWH(birdX + 6, _birdY + 6, birdSize - 11, birdSize - 12);
    if (birdRect.top < 0 || birdRect.bottom > worldHeight - groundHeight) return true;

    for (final pipe in _pipes) {
      final topPipe = Rect.fromLTWH(pipe.x + 2, 0, pipeWidth - 4, pipe.gapY - pipeGap / 2);
      final bottomY = pipe.gapY + pipeGap / 2;
      final bottomPipe = Rect.fromLTWH(pipe.x + 2, bottomY, pipeWidth - 4, worldHeight - groundHeight - bottomY);
      if (birdRect.overlaps(topPipe) || birdRect.overlaps(bottomPipe)) return true;
    }
    return false;
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
      _flap();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _exitGame();
        }
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF4EC0CA),
      body: SafeArea(
        child: Focus(
          focusNode: _focusNode,
          autofocus: true,
          onKeyEvent: _handleKey,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _flap,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final scale = math.min(
                  constraints.maxWidth / worldWidth,
                  constraints.maxHeight / worldHeight,
                );

                final gameWidth = worldWidth * scale;
                final gameHeight = worldHeight * scale;

                return Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: gameWidth,
                        height: gameHeight,
                        child: CustomPaint(
                          isComplex: true,
                          willChange: true,
                          painter: _FlappyPainter(
                            birdY: _birdY,
                            velocity: _velocity,
                            pipes: List.unmodifiable(_pipes),
                            groundOffset: _groundOffset,
                            cloudOffset: _cloudOffset,
                            wingPhase: _wingPhase,
                            started: _started,
                            gameOver: _gameOver,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 14,
                      child: ArcadeIconButton(
                        icon: Icons.arrow_back_rounded,
                        color: const Color(0xFFFFD75E),
                        tooltip: 'Back',
                        onTap: _exitGame,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: _ScoreHud(
                        score: _score,
                        highScore: _highScore,
                      ),
                    ),
                    if (!_started && !_gameOver) _buildStartOverlay(),
                    if (_gameOver) _buildGameOverOverlay(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}

  Widget _buildStartOverlay() {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.94, end: 1),
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeOutBack,
        builder: (context, value, child) => Transform.scale(scale: value, child: child),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 28),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 2),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'TAP TO FLAP',
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                color: Colors.white,
                fontSize: 18,
                height: 1.5,
                shadows: const [Shadow(color: Colors.black, offset: Offset(2, 2))],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.58),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.78, end: 1),
              duration: const Duration(milliseconds: 360),
              curve: Curves.easeOutBack,
              builder: (context, value, child) => Transform.scale(scale: value, child: child),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 26),
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2A6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF533826), width: 4),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.28), blurRadius: 18, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('GAME OVER', style: GoogleFonts.pressStart2p(color: const Color(0xFFE35D2F), fontSize: 18)),
                    ),
                    const SizedBox(height: 18),
                    _ScoreRow(label: 'SCORE', value: '$_score'),
                    const SizedBox(height: 10),
                    _ScoreRow(label: 'BEST', value: '$_highScore'),
                    const SizedBox(height: 18),
                    ArcadeActionButton(
                      label: 'Restart',
                      icon: Icons.restart_alt_rounded,
                      color: const Color(0xFFE8612C),
                      onTap: () => _resetGame(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreHud extends StatelessWidget {
  final int score;
  final int highScore;

  const _ScoreHud({required this.score, required this.highScore});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        children: [
          Text(
            '$score',
            style: GoogleFonts.pressStart2p(
              color: Colors.white,
              fontSize: 38,
              shadows: const [Shadow(color: Colors.black, offset: Offset(3, 3))],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'BEST $highScore',
            style: GoogleFonts.pressStart2p(
              color: Colors.white,
              fontSize: 11,
              shadows: const [Shadow(color: Colors.black54, offset: Offset(2, 2))],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  final String label;
  final String value;

  const _ScoreRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 92,
          child: Text(label, style: GoogleFonts.pressStart2p(color: const Color(0xFF705141), fontSize: 10)),
        ),
        Text(value, style: GoogleFonts.pressStart2p(color: const Color(0xFF33221C), fontSize: 14)),
      ],
    );
  }
}

class _FlappyPainter extends CustomPainter {
  final double birdY;
  final double velocity;
  final List<_Pipe> pipes;
  final double groundOffset;
  final double cloudOffset;
  final double wingPhase;
  final bool started;
  final bool gameOver;

  const _FlappyPainter({
    required this.birdY,
    required this.velocity,
    required this.pipes,
    required this.groundOffset,
    required this.cloudOffset,
    required this.wingPhase,
    required this.started,
    required this.gameOver,
  });

  Paint _paint(Color color) => Paint()
    ..color = color
    ..isAntiAlias = false;

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / _FlappyBirdPageState.worldWidth;
    final sy = size.height / _FlappyBirdPageState.worldHeight;
    canvas.save();
    canvas.scale(sx, sy);

    _drawSky(canvas);
    _drawCloudLayer(canvas);
    for (final pipe in pipes) {
      _drawPipe(canvas, pipe);
    }
    _drawGround(canvas);
    _drawBird(canvas);

    canvas.restore();
  }

  void _drawSky(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, _FlappyBirdPageState.worldWidth, _FlappyBirdPageState.worldHeight),
      _paint(const Color(0xFF4EC0CA)),
    );
  }

  void _drawCloudLayer(Canvas canvas) {
    final cloudPositions = [
      (42.0, 88.0, 1.0),
      (220.0, 142.0, 0.82),
      (380.0, 64.0, 0.68),
    ];
    for (final cloud in cloudPositions) {
      var x = cloud.$1 - cloudOffset;
      while (x < -140) {
        x += _FlappyBirdPageState.worldWidth + 140;
      }
      _drawCloud(canvas, x, cloud.$2, cloud.$3);
    }
  }

  void _drawCloud(Canvas canvas, double x, double y, double scale) {
    canvas.save();
    canvas.translate(x, y);
    canvas.scale(scale);
    final white = _paint(Colors.white.withValues(alpha: 0.94));
    final shade = _paint(const Color(0xFFD8F4F6));
    for (final rect in const [
      Rect.fromLTWH(0, 16, 74, 18),
      Rect.fromLTWH(12, 6, 24, 24),
      Rect.fromLTWH(32, 0, 30, 30),
      Rect.fromLTWH(54, 10, 26, 24),
    ]) {
      canvas.drawRect(rect.translate(3, 5), shade);
      canvas.drawRect(rect, white);
    }
    canvas.restore();
  }

  void _drawPipe(Canvas canvas, _Pipe pipe) {
    final topHeight = pipe.gapY - _FlappyBirdPageState.pipeGap / 2;
    final bottomY = pipe.gapY + _FlappyBirdPageState.pipeGap / 2;
    final bottomHeight = _FlappyBirdPageState.worldHeight - _FlappyBirdPageState.groundHeight - bottomY;
    _drawPipeSection(canvas, pipe.x, 0, topHeight, topPipe: true);
    _drawPipeSection(canvas, pipe.x, bottomY, bottomHeight, topPipe: false);
  }

  void _drawPipeSection(Canvas canvas, double x, double y, double h, {required bool topPipe}) {
    if (h <= 0) return;
    final body = Rect.fromLTWH(x + 7, y, _FlappyBirdPageState.pipeWidth - 14, h);
    final lipY = topPipe ? y + h - 24 : y;
    final lip = Rect.fromLTWH(x, lipY, _FlappyBirdPageState.pipeWidth, 24);
    final outline = _paint(const Color(0xFF155A1C));
    final dark = _paint(const Color(0xFF287C2A));
    final green = _paint(const Color(0xFF55C834));
    final light = _paint(const Color(0xFF9CF05A));

    canvas.drawRect(body, outline);
    canvas.drawRect(body.deflate(4), green);
    canvas.drawRect(Rect.fromLTWH(body.left + 8, body.top, 8, body.height), light);
    canvas.drawRect(Rect.fromLTWH(body.right - 9, body.top, 5, body.height), dark);
    canvas.drawRect(lip, outline);
    canvas.drawRect(lip.deflate(4), green);
    canvas.drawRect(Rect.fromLTWH(lip.left + 10, lip.top + 4, 9, lip.height - 8), light);
    canvas.drawRect(Rect.fromLTWH(lip.right - 12, lip.top + 4, 6, lip.height - 8), dark);
  }

  void _drawGround(Canvas canvas) {
    const y = _FlappyBirdPageState.worldHeight - _FlappyBirdPageState.groundHeight;
    canvas.drawRect(
      const Rect.fromLTWH(0, y, _FlappyBirdPageState.worldWidth, _FlappyBirdPageState.groundHeight),
      _paint(const Color(0xFFDDBB61)),
    );
    canvas.drawRect(const Rect.fromLTWH(0, y, _FlappyBirdPageState.worldWidth, 18), _paint(const Color(0xFF70C943)));
    canvas.drawRect(const Rect.fromLTWH(0, y + 18, _FlappyBirdPageState.worldWidth, 5), _paint(const Color(0xFF3D9A35)));

    final soil = _paint(const Color(0xFFB79A4E));
    for (double x = -groundOffset; x < _FlappyBirdPageState.worldWidth + 24; x += 24) {
      canvas.drawRect(Rect.fromLTWH(x, y + 38, 12, 5), soil);
      canvas.drawRect(Rect.fromLTWH(x + 13, y + 62, 8, 4), soil);
    }
  }

  void _drawBird(Canvas canvas) {
    const x = _FlappyBirdPageState.birdX;
    final bob = started || gameOver ? 0.0 : math.sin(wingPhase * math.pi * 2) * 5;
    final y = birdY + bob;
    final rotation = (velocity / 720).clamp(-0.35, 0.55);
    final flapUp = math.sin(wingPhase * math.pi * 2) > 0;

    canvas.save();
    canvas.translate(x + 18, y + 18);
    canvas.rotate(rotation);
    canvas.translate(-x - 18, -y - 18);

    final black = _paint(Colors.black.withValues(alpha: 0.26));
    final body = _paint(const Color(0xFFFFD94A));
    final shade = _paint(const Color(0xFFE89A32));
    final wing = _paint(const Color(0xFFFFF176));
    final white = _paint(Colors.white);
    final pupil = _paint(Colors.black);
    final beak = _paint(const Color(0xFFF27C2E));
    final beakShade = _paint(const Color(0xFFD94A27));

    canvas.drawRect(Rect.fromLTWH(x + 3, y + 9, 30, 22), black);
    canvas.drawRect(Rect.fromLTWH(x + 4, y + 8, 28, 22), body);
    canvas.drawRect(Rect.fromLTWH(x + 8, y + 30, 20, 5), shade);
    canvas.drawRect(Rect.fromLTWH(x + 25, y + 6, 13, 14), body);
    canvas.drawRect(Rect.fromLTWH(x + 34, y + 16, 17, 6), beak);
    canvas.drawRect(Rect.fromLTWH(x + 34, y + 22, 14, 5), beakShade);
    canvas.drawRect(Rect.fromLTWH(x + 27, y + 8, 9, 9), white);
    canvas.drawRect(Rect.fromLTWH(x + 32, y + 11, 3, 3), pupil);
    canvas.drawRect(Rect.fromLTWH(x + 1, y + (flapUp ? 17 : 23), 18, flapUp ? 8 : 11), wing);
    canvas.drawRect(Rect.fromLTWH(x + 4, y + 7, 28, 3), _paint(Colors.white.withValues(alpha: 0.34)));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _FlappyPainter oldDelegate) => true;
}
