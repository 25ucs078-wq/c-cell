import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../services/admissions_service.dart';
import '../../models/admission_candidate_model.dart';
import '../../models/admission_stage_model.dart';

class AdmissionsTimelinePage extends StatefulWidget {
  final AdmissionsService? admissionsService;
  const AdmissionsTimelinePage({super.key, this.admissionsService});

  @override
  State<AdmissionsTimelinePage> createState() => _AdmissionsTimelinePageState();
}

class _AdmissionsTimelinePageState extends State<AdmissionsTimelinePage> {
  late final AdmissionsService _admissionsService;
  
  bool _initializing = true;
  bool _isLoading = false;
  String? _cycleId;
  String? _boundTempId;
  String? _errorMessage;

  // Active stages and completed stage sets for client-side passcode matching
  List<AdmissionStage> _activeStages = [];
  Set<String> _completedStageIdsSet = {};

  // Controllers for binding form
  final TextEditingController _tempIdController = TextEditingController();
  final TextEditingController _jeeAppNoController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _admissionsService = widget.admissionsService ?? AdmissionsService();
    _bootstrapAdmissions();
  }

  @override
  void dispose() {
    _tempIdController.dispose();
    _jeeAppNoController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  // Fetch active cycle, ensure authenticated anonymously, and check for existing binding
  Future<void> _bootstrapAdmissions() async {
    setState(() {
      _initializing = true;
      _errorMessage = null;
    });

    try {
      // 1. Retrieve the app configuration document (Publicly readable under firestore.rules)
      final config = await _admissionsService.getAppConfig();
      if (config == null) {
        throw Exception('Admissions system is not yet configured. Please create the app configuration (configs/app_config) document.');
      }

      if (config['activeAdmissionCycle'] == null) {
        throw Exception('Configuration Error: activeAdmissionCycle is missing in configs/app_config.');
      }

      _cycleId = config['activeAdmissionCycle'];

      // 2. Check if current session UID is already bound to a candidate
      // Note: Returns null safely if the user is not logged in yet.
      final boundId = await _admissionsService.getBoundTempId(_cycleId!);
      if (boundId != null) {
        _boundTempId = boundId;
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        setState(() {
          _errorMessage = 'Network Connection Error: Unable to reach Firebase Firestore. Please check your internet connection or emulator settings.';
        });
      } else {
        setState(() {
          _errorMessage = 'Firestore Error [${e.code}]: ${e.message ?? 'Unknown error occurred.'}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _initializing = false;
        });
      }
    }
  }

  // Form submit to bind candidate UID
  Future<void> _handleBind() async {
    final tempId = _tempIdController.text.trim();
    final jeeAppNo = _jeeAppNoController.text.trim();
    final dob = _dobController.text.trim();

    if (tempId.isEmpty || jeeAppNo.isEmpty || dob.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all verification fields.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Ensure the anonymous authenticated session is active before binding
      await _admissionsService.ensureAuthenticated();

      await _admissionsService.bindCandidate(
        cycleId: _cycleId!,
        tempId: tempId,
        jeeAppNo: jeeAppNo,
        dob: dob,
      );
      setState(() {
        _boundTempId = tempId;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Account Linking (Upgrade Anonymous Account to official Google account)
  Future<void> _handleAccountUpgrade() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (kIsWeb) {
        final GoogleAuthProvider provider = GoogleAuthProvider();
        provider.setCustomParameters({'prompt': 'select_account'});
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw Exception('No active session to upgrade.');
        }
        await user.linkWithProvider(provider);
      } else {
        // Initialize Google Sign-In instance (Android / iOS)
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;
        final googleUser = await googleSignIn.authenticate();

        final googleAuth = googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        // Link credentials to the existing anonymous user account (preserves UID!)
        await _admissionsService.linkOfficialAccount(credential);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Account upgraded successfully! You are now fully linked.'),
        ),
      );
      
      // Navigate to premium loading and home page
      Navigator.pushReplacementNamed(context, '/loading');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Upgrade failed: ${e.toString()}'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initializing) {
      return const Scaffold(
        backgroundColor: Color(0xFF050816),
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'LNMIIT Admissions',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          if (_boundTempId != null)
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              onPressed: () {
                // Clear binding in state to return to login form
                setState(() {
                  _boundTempId = null;
                  _tempIdController.clear();
                  _jeeAppNoController.clear();
                  _dobController.clear();
                });
              },
              tooltip: 'Disconnect Profile',
            ),
        ],
      ),
      body: _errorMessage != null && _boundTempId == null
          ? _buildErrorScreen()
          : _boundTempId == null
              ? _buildBindingForm()
              : _buildTimelineStream(),
    );
  }

  // Widget to display configuration/bootstrap errors
  Widget _buildErrorScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              'Bootstrap Error',
              style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: _bootstrapAdmissions,
              child: Text('Retry', style: GoogleFonts.poppins(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  // Login form for JEE & Temp ID Verification
  Widget _buildBindingForm() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          color: Colors.white.withValues(alpha: 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Verify Candidate ID',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter details printed on your registration slip to bind this device.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54),
                ),
                const SizedBox(height: 24),
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.1),
                      border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                TextField(
                  controller: _tempIdController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Temporary ID', 'e.g. LNM10025', Icons.badge_outlined),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _jeeAppNoController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('JEE Application Number', 'e.g. 2403102495', Icons.app_registration),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _dobController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Date of Birth (YYYY-MM-DD)', 'e.g. 2006-08-15', Icons.calendar_month),
                ),
                const SizedBox(height: 28),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                        ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _handleBind,
                        child: Text(
                          'Verify & Proceed',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Stream admissions progress and render stages timeline in real-time
  Widget _buildTimelineStream() {
    return StreamBuilder<AdmissionCandidate?>(
      stream: _admissionsService.streamCandidate(_cycleId!, _boundTempId!),
      builder: (context, candidateSnap) {
        if (candidateSnap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final candidate = candidateSnap.data;
        if (candidate == null) {
          return const Center(child: Text('Candidate profile not found.', style: TextStyle(color: Colors.white)));
        }

        return StreamBuilder<List<AdmissionStage>>(
          stream: _admissionsService.streamStages(_cycleId!),
          builder: (context, stagesSnap) {
            if (stagesSnap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final stages = stagesSnap.data ?? [];
            _activeStages = stages;

            return StreamBuilder<Set<String>>(
              stream: _admissionsService.streamCompletedStages(_cycleId!, _boundTempId!),
              builder: (context, completedSnap) {
                final completedSet = completedSnap.data ?? {};
                _completedStageIdsSet = completedSet;

                return _buildDashboard(candidate, stages, completedSet);
              },
            );
          },
        );
      },
    );
  }

  // Render Candidate Timeline Dashboard
  Widget _buildDashboard(
    AdmissionCandidate candidate,
    List<AdmissionStage> stages,
    Set<String> completedStages,
  ) {
    final bool isAllCompleted = stages.isNotEmpty &&
        stages.every((s) => completedStages.contains(s.id));

    return Column(
      children: [
        // Candidate profile header card
        Container(
          width: double.infinity,
          color: Colors.black.withValues(alpha: 0.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.fullName,
                      style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${candidate.tempId} | Branch: ${candidate.branch}',
                      style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13),
                    ),
                  ],
                ),
              ),
              if (isAllCompleted && candidate.officialEmail.isNotEmpty)
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        icon: const Icon(Icons.cloud_upload_outlined, color: Colors.white),
                        label: Text('Upgrade ID', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                        onPressed: _handleAccountUpgrade,
                      ),
            ],
          ),
        ),

        // Scrollable timeline
        Expanded(
          child: stages.isEmpty
              ? const Center(child: Text('No active admission stages configured.', style: TextStyle(color: Colors.white54)))
              : ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: stages.length,
                  itemBuilder: (context, index) {
                    final stage = stages[index];
                    final isDone = completedStages.contains(stage.id);
                    // The stage is unlocked if it is the first or if the previous stage is completed
                    final isUnlocked = index == 0 || completedStages.contains(stages[index - 1].id);

                    return _buildTimelineItem(stage, index + 1, isDone, isUnlocked, index == stages.length - 1);
                  },
                ),
        ),
      ],
    );
  }

  // Individual Timeline Item
  Widget _buildTimelineItem(
    AdmissionStage stage,
    int index,
    bool isDone,
    bool isUnlocked,
    bool isLast,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Step progress indicator bar
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone
                      ? Colors.green
                      : isUnlocked
                          ? Colors.redAccent.withValues(alpha: 0.15)
                          : Colors.white10,
                  border: Border.all(
                    color: isDone
                        ? Colors.green
                        : isUnlocked
                            ? Colors.redAccent
                            : Colors.white24,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isDone
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : Text(
                          index.toString().padLeft(2, '0'),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isUnlocked ? Colors.redAccent : Colors.white30,
                          ),
                        ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isDone ? Colors.green : Colors.white10,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),

          // Stage Details Card
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: isUnlocked
                      ? () => _showInstructionsSheet(stage, isDone)
                      : null,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isUnlocked
                          ? Colors.white.withValues(alpha: 0.03)
                          : Colors.white.withValues(alpha: 0.01),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDone
                            ? Colors.green.withValues(alpha: 0.2)
                            : isUnlocked
                                ? Colors.redAccent.withValues(alpha: 0.1)
                                : Colors.white.withValues(alpha: 0.02),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stage.title,
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isUnlocked ? Colors.white : Colors.white30,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${stage.department} | Room ${stage.roomNo}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: isUnlocked ? Colors.white54 : Colors.white12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isUnlocked)
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: isDone ? Colors.green : Colors.redAccent,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Instructions Bottom Sheet for Stage details
  void _showInstructionsSheet(AdmissionStage stage, bool isDone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF090A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final TextEditingController passcodeController = TextEditingController();
        bool isVerifying = false;

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 32,
                right: 32,
                top: 32,
                bottom: MediaQuery.of(context).viewInsets.bottom + 32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDone ? Colors.green.withValues(alpha: 0.15) : Colors.redAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isDone ? 'COMPLETED' : 'PENDING',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isDone ? Colors.green : Colors.redAccent,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white54),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    stage.title,
                    style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Department: ${stage.department} | Room: ${stage.roomNo}',
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.white54),
                  ),
                  const Divider(color: Colors.white10, height: 32),
                  Text(
                    'Instructions',
                    style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    stage.instructions,
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70, height: 1.5),
                  ),
                  
                  // If the stage is pending, display the manual verification code entry form
                  if (!isDone) ...[
                    const Divider(color: Colors.white10, height: 32),
                    Text(
                      'Officer Verification',
                      style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: passcodeController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Desk Verification Code', 'Enter desk passcode', Icons.lock_outline),
                    ),
                    const SizedBox(height: 16),
                    isVerifying
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () async {
                              final code = passcodeController.text.trim();
                              if (code.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please enter the verification code.')),
                                );
                                return;
                              }

                              setSheetState(() {
                                isVerifying = true;
                              });

                              try {
                                await _admissionsService.verifyStageViaPasscode(
                                  cycleId: _cycleId!,
                                  tempId: _boundTempId!,
                                  stageId: stage.id,
                                  passcode: code,
                                  currentCompletedStageIds: _completedStageIdsSet.toList(),
                                  allEnabledStageIds: _activeStages.map((s) => s.id).toList(),
                                );

                                if (context.mounted) {
                                  Navigator.pop(context); // Close bottom sheet
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text('${stage.title} verified successfully!'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                setSheetState(() {
                                  isVerifying = false;
                                });
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text(e.toString().replaceAll('Exception: ', '')),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Verify Stage',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      _bootstrapAdmissions(); // Refresh configuration/state on sheet close
    });
  }

  InputDecoration _inputDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(color: Colors.white38),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white12),
      prefixIcon: Icon(icon, color: Colors.redAccent),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.01),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
      ),
    );
  }
}
