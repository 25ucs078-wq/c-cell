import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auth_service.dart';

class GoogleLoginPage extends StatefulWidget {
  final AuthService? authService;
  const GoogleLoginPage({super.key, this.authService});

  @override
  State<GoogleLoginPage> createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> with SingleTickerProviderStateMixin {
  late final AuthService _authService;
  bool _isLoading = false;
  String? _errorMessage;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _authService = widget.authService ?? AuthService();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _mapErrorToMessage(dynamic error) {
    if (error is UnauthorizedDomainException) {
      return error.message;
    }

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-credential':
          return 'Authentication failed. Please verify your Google credentials.';
        case 'network-request-failed':
          return 'Network error. Please check your internet connection and try again.';
        case 'user-disabled':
          return 'Your account has been disabled. Please contact C-CELL support.';
        case 'too-many-requests':
          return 'Too many requests. Please try again in a few minutes.';
        case 'unverified-email':
          return 'Access Denied: Your Google account email is not verified.';
        default:
          return 'Authentication error [${error.code}]: ${error.message ?? 'Please try again.'}';
      }
    }

    if (error is FirebaseException) {
      return 'Firebase Error [${error.code}]: ${error.message ?? 'Database connection failed.'}';
    }

    if (error is PlatformException) {
      switch (error.code) {
        case 'network_error':
          return 'Network connection error during Google Sign-In. Please check your internet.';
        case 'sign_in_failed':
          return 'Google Sign-In failed. Please try choosing your account again.';
        case 'sign_in_canceled':
          return 'Sign-in was cancelled.';
        default:
          return 'Platform error [${error.code}]: ${error.message ?? 'No details available.'}';
      }
    }

    return 'Unexpected error: ${error.toString()}';
  }

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        if (!mounted) return;
        // Successful sign-in, redirect to the premium animated loading page
        Navigator.pushReplacementNamed(context, '/loading');
      } else {
        // Sign-in cancelled by user
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = _mapErrorToMessage(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816), // Dark obsidian theme
      body: Stack(
        children: [
          // Elegant Netflix-style glowing background gradients
          Positioned(
            top: -150,
            right: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: const SizedBox.shrink(),
            ),
          ),

          // Main contents
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 420),
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.03), // Glassmorphism container
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.06),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // C-CELL Logo with glowing border
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.redAccent.withValues(alpha: 0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.redAccent.withValues(alpha: 0.15),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 54,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('assets/images/ccell_logo_c.png'),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Title
                        Text(
                          'C-CELL',
                          style: GoogleFonts.outfit(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subtitle
                        Text(
                          'LNM Institute of Information Technology',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Error Banner (if validation fails)
                        if (_errorMessage != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.redAccent.withValues(alpha: 0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline, color: Colors.redAccent, size: 22),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _errorMessage!,
                                    style: GoogleFonts.poppins(
                                      color: Colors.redAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Sign-In Button or Progress Indicator
                        _isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                              )
                            : SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                    elevation: 5,
                                    shadowColor: Colors.redAccent.withValues(alpha: 0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: _handleSignIn,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
                                        height: 20,
                                        width: 20,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          Icons.account_balance,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Flexible(
                                        child: Text(
                                          'Continue with Google',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        const SizedBox(height: 24),

                        // Info note
                        Text(
                          'Authorized LNMIIT domain login only.',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Divider(color: Colors.white10, height: 40),
                        
                        // Fresher Admission Tracker link
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/admissions');
                          },
                          child: Text(
                            'Freshers Admission Tracker',
                            style: GoogleFonts.poppins(
                              color: Colors.redAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
