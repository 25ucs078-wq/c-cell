import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// Configurable Vercel/Local backend base URL via --dart-define=BACKEND_URL=...
const String kConfiguredBackendUrl = String.fromEnvironment(
  'BACKEND_URL',
  defaultValue: 'https://c-cell-backend-production.vercel.app',
);

class SendNotificationPage extends StatefulWidget {
  final String? backendUrlOverride;

  const SendNotificationPage({
    super.key,
    this.backendUrlOverride,
  });

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSending = false;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSendNotification() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSending) return; // Prevent duplicate taps

    final title = _titleController.text.trim();
    final message = _messageController.text.trim();

    setState(() {
      _isSending = true;
    });

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('You must be signed in as an admin to send notifications.');
      }

      // Retrieve fresh Firebase ID Token
      final idToken = await currentUser.getIdToken(true);
      if (idToken == null || idToken.isEmpty) {
        throw Exception('Failed to obtain Firebase ID Token.');
      }

      final String baseUrl = widget.backendUrlOverride ?? kConfiguredBackendUrl;
      final Uri endpoint = Uri.parse('$baseUrl/api/send-notification');

      final response = await http.post(
        endpoint,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'message': message,
          'idToken': idToken,
        }),
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        final bool pushSent = responseBody['pushSent'] ?? false;
        final String? warning = responseBody['warning'];

        _titleController.clear();
        _messageController.clear();

        if (pushSent) {
          _showDialog(
            title: 'Announcement Sent',
            message: 'Campus Buzz notification has been posted and delivered to all students.',
            icon: Icons.check_circle_outline,
            iconColor: Colors.greenAccent,
          );
        } else {
          _showDialog(
            title: 'Partial Success Warning',
            message: warning ?? 'Notification stored in database, but FCM push delivery failed.',
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.amberAccent,
          );
        }
      } else {
        final String errorMsg = responseBody['error'] ??
            'Server responded with status ${response.statusCode}';
        _showDialog(
          title: 'Failed to Send Announcement',
          message: errorMsg,
          icon: Icons.error_outline,
          iconColor: Colors.redAccent,
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showDialog(
        title: 'Error',
        message: e.toString().replaceAll('Exception: ', ''),
        icon: Icons.error_outline,
        iconColor: Colors.redAccent,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _showDialog({
    required String title,
    required String message,
    required IconData icon,
    required Color iconColor,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF090A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        title: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Send Campus Announcement',
          style: GoogleFonts.outfit(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.redAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.campaign, color: Colors.redAccent, size: 32),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Campus Buzz Broadcast',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Notifications will be permanently saved and sent as a push notification branded as "LNMIIT C-Cell".',
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Title Field
              Text(
                'Announcement Title',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                enabled: !_isSending,
                maxLength: 100,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'e.g. Orientation Schedule Updated',
                  hintStyle: const TextStyle(color: Colors.white24),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.03),
                  counterStyle: const TextStyle(color: Colors.white38),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.redAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required.';
                  }
                  if (value.trim().length > 100) {
                    return 'Title must be 100 characters or less.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Message Body Field
              Text(
                'Announcement Message',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _messageController,
                enabled: !_isSending,
                maxLines: 6,
                maxLength: 2000,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Type your message details here...',
                  hintStyle: const TextStyle(color: Colors.white24),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.03),
                  counterStyle: const TextStyle(color: Colors.white38),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.redAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Message body is required.';
                  }
                  if (value.trim().length > 2000) {
                    return 'Message must be 2000 characters or less.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Send Button
              _isSending
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ),
                    )
                  : SizedBox(
                      height: 54,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.send_rounded, color: Colors.white),
                        label: Text(
                          'Broadcast Announcement',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: _handleSendNotification,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
