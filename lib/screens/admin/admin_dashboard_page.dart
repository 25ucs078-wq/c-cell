import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/admin_service.dart';
import '../../services/admissions_service.dart';
import '../../models/admission_stage_model.dart';
import '../../models/admission_candidate_model.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> with SingleTickerProviderStateMixin {
  final AdminService _adminService = AdminService();
  final AdmissionsService _admissionsService = AdmissionsService();
  
  late TabController _tabController;
  
  bool _isAuthorizedAdmin = false;
  bool _isVerifyingRole = true;
  bool _isLoading = false;
  String? _cycleId;

  // Controllers for configurations
  final TextEditingController _cycleController = TextEditingController();
  final TextEditingController _schemaVersionController = TextEditingController();
  final TextEditingController _minAppVersionController = TextEditingController();
  bool _isAdmissionActive = true;
  bool _maintenanceMode = false;

  // Controllers for CSV import
  final TextEditingController _csvController = TextEditingController();

  // Controllers for Stage Manager
  final TextEditingController _stageIdController = TextEditingController();
  final TextEditingController _stageTitleController = TextEditingController();
  final TextEditingController _stageDeptController = TextEditingController();
  final TextEditingController _stageRoomController = TextEditingController();
  final TextEditingController _stageInstructionsController = TextEditingController();
  final TextEditingController _stageOrderController = TextEditingController();
  final TextEditingController _stageRoleController = TextEditingController();

  // Controllers for Role Editor
  final TextEditingController _roleUidController = TextEditingController();
  final TextEditingController _roleEmailController = TextEditingController();
  String _selectedRole = 'desk_hostel';

  // Email allocation controller
  final TextEditingController _candidateEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _verifyAdminAuthorization();
  }

  Future<void> _verifyAdminAuthorization() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _denyAccess('Authentication required to access Admin Operations.');
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        final role = doc.data()!['role'];
        if (role == 'admin') {
          if (mounted) {
            setState(() {
              _isAuthorizedAdmin = true;
              _isVerifyingRole = false;
            });
            _loadConfig();
          }
          return;
        }
      }
      _denyAccess('Access Denied: You must be an authorized admin (role == admin) to access this portal.');
    } catch (e) {
      _denyAccess('Error verifying authorization: $e');
    }
  }

  void _denyAccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(message),
      ),
    );
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cycleController.dispose();
    _schemaVersionController.dispose();
    _minAppVersionController.dispose();
    _csvController.dispose();
    _stageIdController.dispose();
    _stageTitleController.dispose();
    _stageDeptController.dispose();
    _stageRoomController.dispose();
    _stageInstructionsController.dispose();
    _stageOrderController.dispose();
    _stageRoleController.dispose();
    _roleUidController.dispose();
    _roleEmailController.dispose();
    _candidateEmailController.dispose();
    super.dispose();
  }

  // Load app configuration from Firestore
  Future<void> _loadConfig() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final config = await _admissionsService.getAppConfig();
      if (config != null) {
        _cycleId = config['activeAdmissionCycle'];
        
        _cycleController.text = _cycleId ?? '';
        _schemaVersionController.text = (config['schemaVersion'] ?? 1).toString();
        _minAppVersionController.text = config['minSupportedAppVersion'] ?? '1.0.0';
        _isAdmissionActive = config['isAdmissionActive'] ?? true;
        _maintenanceMode = config['maintenanceMode'] ?? false;
      }
    } catch (e) {
      _showSnackbar('Error loading config: $e', Colors.redAccent);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Save configurations updates
  Future<void> _handleSaveConfig() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = {
        'activeAdmissionCycle': _cycleController.text.trim(),
        'schemaVersion': int.tryParse(_schemaVersionController.text.trim()) ?? 1,
        'minSupportedAppVersion': _minAppVersionController.text.trim(),
        'isAdmissionActive': _isAdmissionActive,
        'maintenanceMode': _maintenanceMode,
      };

      await _adminService.updateAppConfig(data);
      _showSnackbar('App configuration saved successfully!', Colors.green);
      _loadConfig();
    } catch (e) {
      _showSnackbar('Failed to save configuration: $e', Colors.redAccent);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Handle CSV batch import
  Future<void> _handleCsvImport() async {
    final csv = _csvController.text.trim();
    if (csv.isEmpty || _cycleId == null) {
      _showSnackbar('Please paste CSV contents first.', Colors.orangeAccent);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final count = await _adminService.importCandidatesCsv(_cycleId!, csv);
      _showSnackbar('Successfully imported $count candidates!', Colors.green);
      _csvController.clear();
    } catch (e) {
      _showSnackbar('CSV Import failed: $e', Colors.redAccent);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Handle Stage Save CRUD
  Future<void> _handleSaveStage() async {
    final id = _stageIdController.text.trim();
    final title = _stageTitleController.text.trim();
    final dept = _stageDeptController.text.trim();
    final room = _stageRoomController.text.trim();
    final instructions = _stageInstructionsController.text.trim();
    final order = int.tryParse(_stageOrderController.text.trim()) ?? 0;
    final role = _stageRoleController.text.trim();

    if (id.isEmpty || title.isEmpty || dept.isEmpty || role.isEmpty) {
      _showSnackbar('Please fill out all required stage fields.', Colors.orangeAccent);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final stage = AdmissionStage(
        id: id,
        title: title,
        department: dept,
        roomNo: room,
        instructions: instructions,
        stageOrder: order,
        isEnabled: true,
        assignedRole: role,
      );

      await _adminService.saveStage(_cycleId!, stage);
      _showSnackbar('Stage saved successfully!', Colors.green);
      if (!mounted) return;
      Navigator.pop(context);
      _clearStageForm();
    } catch (e) {
      _showSnackbar('Failed to save stage: $e', Colors.redAccent);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Assign staff role
  Future<void> _handleAssignRole() async {
    final uid = _roleUidController.text.trim();
    final email = _roleEmailController.text.trim();

    if (uid.isEmpty || email.isEmpty) {
      _showSnackbar('Please fill UID and Email fields.', Colors.orangeAccent);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _adminService.assignStaffRole(uid, email, _selectedRole);
      _showSnackbar('Role assigned successfully!', Colors.green);
      _roleUidController.clear();
      _roleEmailController.clear();
    } catch (e) {
      _showSnackbar('Failed to assign role: $e', Colors.redAccent);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Allocate official email to candidate
  Future<void> _handleEmailAllocation(String tempId) async {
    final email = _candidateEmailController.text.trim();
    if (email.isEmpty) {
      _showSnackbar('Please enter official email.', Colors.orangeAccent);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _adminService.allocateOfficialEmail(_cycleId!, tempId, email);
      _showSnackbar('Official email allocated!', Colors.green);
      _candidateEmailController.clear();
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      _showSnackbar('Email allocation failed: $e', Colors.redAccent);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Reset candidate session after admin confirmation
  Future<void> _handleResetSession(String tempId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF090A1A),
        title: const Text('Reset Candidate Session', style: TextStyle(color: Colors.white)),
        content: Text('Are you sure you want to disconnect all devices and reset the login session for Application Number $tempId?\n\nThis will allow them to login on a new device while preserving all completed stage logs.', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _adminService.resetCandidateSession(_cycleId!, tempId);
      _showSnackbar('Session reset successfully for $tempId!', Colors.green);
    } catch (e) {
      _showSnackbar('Error resetting session: $e', Colors.redAccent);
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
    if (_isVerifyingRole) {
      return const Scaffold(
        backgroundColor: Color(0xFF050816),
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
        ),
      );
    }

    if (!_isAuthorizedAdmin) {
      return Scaffold(
        backgroundColor: const Color(0xFF050816),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, color: Colors.redAccent, size: 64),
                const SizedBox(height: 16),
                Text(
                  'Access Denied',
                  style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'You must be an authorized C-Cell admin to access this portal.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
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
          'C-CELL Operations Portal',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.campaign, color: Colors.redAccent),
            tooltip: 'Send Campus Announcement',
            onPressed: () {
              Navigator.pushNamed(context, '/admin/send_notification');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.redAccent,
          unselectedLabelColor: Colors.white54,
          indicatorColor: Colors.redAccent,
          tabs: const [
            Tab(icon: Icon(Icons.analytics_outlined), text: 'Dashboard'),
            Tab(icon: Icon(Icons.settings_outlined), text: 'Configs'),
            Tab(icon: Icon(Icons.people_outline), text: 'Candidates'),
            Tab(icon: Icon(Icons.playlist_add_outlined), text: 'Stages'),
            Tab(icon: Icon(Icons.security_outlined), text: 'RBAC Staff'),
            Tab(icon: Icon(Icons.history_outlined), text: 'Audit Logs'),
          ],
        ),
      ),
      body: _isLoading && _cycleId == null
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildMetricsDashboard(),
                _buildConfigsManager(),
                _buildCandidatesList(),
                _buildStagesManager(),
                _buildRbacManager(),
                _buildAuditLogsView(),
              ],
            ),
    );
  }

  // 1. Dashboard Tab: Real-Time Operational Metrics
  Widget _buildMetricsDashboard() {
    if (_cycleId == null) {
      return const Center(child: Text('Active cycle not loaded.', style: TextStyle(color: Colors.white)));
    }

    return StreamBuilder<List<AdmissionCandidate>>(
      stream: _adminService.streamAllCandidates(_cycleId!),
      builder: (context, candidateSnap) {
        if (candidateSnap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final candidates = candidateSnap.data ?? [];
        final total = candidates.length;
        final completed = candidates.where((c) => c.approved).length;
        final pending = total - completed;

        return StreamBuilder<List<AdmissionStage>>(
          stream: _admissionsService.streamStages(_cycleId!),
          builder: (context, stagesSnap) {
            final stages = stagesSnap.data ?? [];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Operational Metrics overview',
                    style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  // Metrics Cards grid
                  GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    childAspectRatio: 1.5,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _metricsCard('Active Cycle', _cycleId ?? 'Offline', Icons.calendar_today, Colors.blueAccent),
                      _metricsCard('Total Candidates', total.toString(), Icons.people, Colors.purpleAccent),
                      _metricsCard('Completed Admissions', completed.toString(), Icons.check_circle_outline, Colors.green),
                      _metricsCard('Pending Admissions', pending.toString(), Icons.pending_outlined, Colors.orangeAccent),
                    ],
                  ),
                  const SizedBox(height: 32),

                  Text(
                    'Stage-wise Completion Statistics',
                    style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  stages.isEmpty
                      ? const Center(child: Text('No stages configured for stats calculation.', style: TextStyle(color: Colors.white54)))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: stages.length,
                          itemBuilder: (context, index) {
                            final stage = stages[index];
                            // Count how many candidates have completed this stage
                            final stageCompletedCount = candidates
                                .where((c) => c.completedStageIds.contains(stage.id))
                                .length;
                            final percent = total > 0 ? (stageCompletedCount / total) : 0.0;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.01),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        stage.title,
                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '$stageCompletedCount / $total completed',
                                        style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: percent,
                                      backgroundColor: Colors.white10,
                                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                                      minHeight: 8,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 2. Configs Tab: Cycle & App configuration updates
  Widget _buildConfigsManager() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Configurations',
            style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _cycleController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Active Admission Cycle ID', 'e.g. 2026'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _schemaVersionController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Schema Version', 'e.g. 1'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _minAppVersionController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Minimum Supported App Version', 'e.g. 1.0.0'),
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: Text('Admissions Portal Open', style: GoogleFonts.poppins(color: Colors.white)),
            subtitle: const Text('Toggles whether freshers can verify and bind profiles.', style: TextStyle(color: Colors.white54)),
            value: _isAdmissionActive,
            activeThumbColor: Colors.redAccent,
            onChanged: (val) {
              setState(() {
                _isAdmissionActive = val;
              });
            },
          ),
          SwitchListTile(
            title: Text('Maintenance Mode Active', style: GoogleFonts.poppins(color: Colors.white)),
            subtitle: const Text('Restricts access to entire app for administrative updates.', style: TextStyle(color: Colors.white54)),
            value: _maintenanceMode,
            activeThumbColor: Colors.redAccent,
            onChanged: (val) {
              setState(() {
                _maintenanceMode = val;
              });
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: _handleSaveConfig,
              child: _isLoading
                  ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : Text('Save Configurations', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Candidates Tab: CSV bulk imports & List allocations
  Widget _buildCandidatesList() {
    if (_cycleId == null) {
      return const Center(child: Text('Active cycle not loaded.', style: TextStyle(color: Colors.white)));
    }

    return StreamBuilder<List<AdmissionCandidate>>(
      stream: _adminService.streamAllCandidates(_cycleId!),
      builder: (context, snapshot) {
        final candidates = snapshot.data ?? [];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Candidate Batch CSV upload section
              Text(
                'Bulk Import Candidates (CSV)',
                style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Paste CSV contents. Header format: tempId, fullName, branch, jeeAppNo, dob (YYYY-MM-DD)',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _csvController,
                maxLines: 5,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: _inputDecoration('CSV Content Data', 'temp1001,John Doe,CSE,2403100021,2006-08-15'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                icon: const Icon(Icons.upload_file, color: Colors.white),
                label: Text('Execute Batch Import', style: GoogleFonts.poppins(color: Colors.white)),
                onPressed: _handleCsvImport,
              ),
              const Divider(color: Colors.white10, height: 48),

              Row(
                children: [
                  Text(
                    'Candidates Registered',
                    style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    '${candidates.length} total',
                    style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              candidates.isEmpty
                  ? const Center(child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text('No candidates imported.', style: TextStyle(color: Colors.white30)),
                    ))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: candidates.length,
                      itemBuilder: (context, index) {
                        final candidate = candidates[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.01),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      candidate.fullName,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'ID: ${candidate.tempId} | Email: ${candidate.officialEmail.isEmpty ? "Unallocated" : candidate.officialEmail}',
                                      style: GoogleFonts.poppins(color: Colors.white30, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: candidate.officialEmail.isEmpty ? Colors.redAccent : Colors.white12,
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    onPressed: () => _showEmailAllocationDialog(candidate.tempId),
                                    child: Text(
                                      candidate.officialEmail.isEmpty ? 'Allocate Email' : 'Re-allocate',
                                      style: GoogleFonts.poppins(fontSize: 11, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (candidate.candidateUid.isNotEmpty)
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orangeAccent,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      ),
                                      onPressed: () => _handleResetSession(candidate.tempId),
                                      child: Text(
                                        'Reset Session',
                                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        );
      },
    );
  }

  // 4. Stages Tab: CRUD Stage Manager
  Widget _buildStagesManager() {
    if (_cycleId == null) {
      return const Center(child: Text('Active cycle not loaded.', style: TextStyle(color: Colors.white)));
    }

    return StreamBuilder<List<AdmissionStage>>(
      stream: _admissionsService.streamStages(_cycleId!),
      builder: (context, snapshot) {
        final stages = snapshot.data ?? [];

        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _clearStageForm();
              _showStageEditorSheet();
            },
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Workflow Stages CRUD',
                  style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 16),

                stages.isEmpty
                    ? const Center(child: Text('No stages configured.', style: TextStyle(color: Colors.white54)))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: stages.length,
                        itemBuilder: (context, index) {
                          final stage = stages[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.01),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
                                  child: Text('${stage.stageOrder}', style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stage.title,
                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Desk Role: ${stage.assignedRole} | Room: ${stage.roomNo}',
                                        style: GoogleFonts.poppins(color: Colors.white30, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.white54),
                                  onPressed: () {
                                    _populateStageForm(stage);
                                    _showStageEditorSheet(isEdit: true);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () => _confirmDeleteStage(stage.id),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 5. RBAC Tab: Assign user roles
  Widget _buildRbacManager() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Staff Roles & Privileges (RBAC)',
            style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _roleUidController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('User Firebase UID', 'e.g. j9uW3vT1N...'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _roleEmailController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('User Staff Email Address', 'e.g. officer@lnmiit.ac.in'),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            initialValue: _selectedRole,
            dropdownColor: const Color(0xFF090A1A),
            style: GoogleFonts.poppins(color: Colors.white),
            decoration: _inputDecoration('Assigned Operations Role', ''),
            items: const [
              DropdownMenuItem(value: 'desk_hostel', child: Text('Hostel Desk Officer (desk_hostel)')),
              DropdownMenuItem(value: 'desk_verification', child: Text('Documents Verification (desk_verification)')),
              DropdownMenuItem(value: 'desk_finance', child: Text('Finance Desk (desk_finance)')),
              DropdownMenuItem(value: 'admin', child: Text('System Administrator (admin)')),
            ],
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedRole = val;
                });
              }
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: _handleAssignRole,
              child: _isLoading
                  ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : Text('Assign Operations Role', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // 6. Audit Logs Tab: Stream admin audits
  Widget _buildAuditLogsView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _adminService.streamAdminLogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final logs = snapshot.data?.docs ?? [];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Operations Audit Trail',
                style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),

              logs.isEmpty
                  ? const Center(child: Text('No audit logs written yet.', style: TextStyle(color: Colors.white30)))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final doc = logs[index];
                        final data = doc.data() as Map<String, dynamic>;
                        final type = data['actionType'] ?? 'ACTION';
                        final user = data['performedBy'] ?? 'unknown';
                        final Timestamp? time = data['performedAt'];
                        final details = data['details'] ?? {};

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.01),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    type,
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.redAccent, fontSize: 13),
                                  ),
                                  const Spacer(),
                                  Text(
                                    time != null ? time.toDate().toLocal().toString().substring(0, 16) : 'syncing...',
                                    style: GoogleFonts.poppins(color: Colors.white38, fontSize: 11),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Operator: $user',
                                style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Details: $details',
                                style: GoogleFonts.poppins(color: Colors.white30, fontSize: 11),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        );
      },
    );
  }

  // Helper widgets & helpers

  Widget _metricsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _showStageEditorSheet({bool isEdit = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF090A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isEdit ? 'Edit Stage' : 'Create Stage',
                  style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Divider(color: Colors.white10, height: 24),
                TextField(
                  controller: _stageIdController,
                  enabled: !isEdit,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Stage Unique ID', 'e.g. hostel_allotment'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _stageTitleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Stage Title', 'e.g. Hostel Allotment'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _stageDeptController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Department', 'e.g. Chief Warden Office'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _stageRoomController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Room No', 'e.g. 102'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _stageRoleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Assigned Staff Role', 'e.g. desk_hostel'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _stageOrderController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Stage Order Index', 'e.g. 1'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _stageInstructionsController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Instructions text', 'Collect keys and sign list...'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.symmetric(vertical: 16)),
                  onPressed: _handleSaveStage,
                  child: Text('Save Stage Config', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEmailAllocationDialog(String tempId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF090A1A),
          title: Text('Allocate Official Email', style: GoogleFonts.outfit(color: Colors.white)),
          content: TextField(
            controller: _candidateEmailController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Official Email (@lnmiit.ac.in)', 'e.g. 26ucse045@lnmiit.ac.in'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () => _handleEmailAllocation(tempId),
              child: const Text('Allocate', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteStage(String stageId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF090A1A),
          title: Text('Delete Stage', style: GoogleFonts.outfit(color: Colors.white)),
          content: Text('Are you sure you want to delete stage "$stageId"? This action cannot be undone.', style: GoogleFonts.poppins(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () async {
                Navigator.pop(context);
                setState(() => _isLoading = true);
                try {
                  await _adminService.deleteStage(_cycleId!, stageId);
                  _showSnackbar('Stage deleted!', Colors.green);
                } catch (e) {
                  _showSnackbar('Delete failed: $e', Colors.redAccent);
                } finally {
                  setState(() => _isLoading = false);
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _populateStageForm(AdmissionStage stage) {
    _stageIdController.text = stage.id;
    _stageTitleController.text = stage.title;
    _stageDeptController.text = stage.department;
    _stageRoomController.text = stage.roomNo;
    _stageInstructionsController.text = stage.instructions;
    _stageOrderController.text = stage.stageOrder.toString();
    _stageRoleController.text = stage.assignedRole;
  }

  void _clearStageForm() {
    _stageIdController.clear();
    _stageTitleController.clear();
    _stageDeptController.clear();
    _stageRoomController.clear();
    _stageInstructionsController.clear();
    _stageOrderController.clear();
    _stageRoleController.clear();
  }

  void _showSnackbar(String msg, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: color, content: Text(msg, style: GoogleFonts.poppins(color: Colors.white))),
    );
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white12, fontSize: 12),
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
