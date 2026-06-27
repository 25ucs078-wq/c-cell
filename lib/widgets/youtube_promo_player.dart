import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePromoPlayer extends StatefulWidget {
  final String videoId;
  final String fallbackImageUrl;
  final double height;

  const YoutubePromoPlayer({
    super.key,
    required this.videoId,
    required this.fallbackImageUrl,
    required this.height,
  });

  @override
  State<YoutubePromoPlayer> createState() => _YoutubePromoPlayerState();
}

class _YoutubePromoPlayerState extends State<YoutubePromoPlayer> {
  late YoutubePlayerController _controller;
  StreamSubscription<YoutubePlayerValue>? _subscription;
  bool _isReady = false;
  bool _isMuted = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: false,
        showFullscreenButton: false,
        mute: true,
        loop: true,
        enableKeyboard: false,
        showVideoAnnotations: false,
      ),
    );

    // Listen to stream for state updates
    _subscription = _controller.stream.listen((value) {
      if (!mounted) return;

      // Handle looping manually as fallback
      if (value.playerState == PlayerState.ended) {
        _controller.seekTo(seconds: 0.0);
        _controller.playVideo();
      }

      // Mark as ready once the video starts playing
      if (value.playerState == PlayerState.playing && !_isReady) {
        setState(() {
          _isReady = true;
        });
      }

      // Handle errors
      if (value.hasError && !_hasError) {
        setState(() {
          _hasError = true;
        });
      }
    }, onError: (_) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller.close();
    super.dispose();
  }

  void _toggleMute() async {
    try {
      if (_isMuted) {
        await _controller.unMute();
      } else {
        await _controller.mute();
      }
      if (mounted) {
        setState(() {
          _isMuted = !_isMuted;
        });
      }
    } catch (_) {
      // Ignore mute/unmute action failures if the iframe isn't fully ready
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Fallback static image
          Image.asset(
            widget.fallbackImageUrl,
            width: double.infinity,
            height: widget.height,
            fit: BoxFit.cover,
          ),

          // YouTube Player with cross fade transition
          if (!_hasError)
            AnimatedOpacity(
              opacity: _isReady ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                width: double.infinity,
                height: widget.height,
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: 1600,
                    height: 900,
                    child: YoutubePlayer(
                      controller: _controller,
                      aspectRatio: 16 / 9,
                      enableFullScreenOnVerticalDrag: false,
                    ),
                  ),
                ),
              ),
            ),

          // Loading indicator overlay (subtle)
          if (!_isReady && !_hasError)
            Positioned(
              bottom: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Loading Video...",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Custom glassmorphic mute/unmute button
          if (_isReady && !_hasError)
            Positioned(
              bottom: 12,
              right: 12,
              child: Tooltip(
                message: _isMuted ? "Unmute Video" : "Mute Video",
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _toggleMute,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isMuted ? Colors.white24 : Colors.redAccent.withValues(alpha: 0.6),
                          width: 1.5,
                        ),
                        boxShadow: [
                          if (!_isMuted)
                            BoxShadow(
                              color: Colors.redAccent.withValues(alpha: 0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                        ],
                      ),
                      child: Icon(
                        _isMuted ? Icons.volume_off : Icons.volume_up,
                        color: _isMuted ? Colors.white : Colors.redAccent,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
