import 'package:flutter/material.dart';
import '../services/admission_service.dart';
import '../models/admission_models.dart';
import 'stage_detail_page.dart';

class AdmissionLandingPage extends StatefulWidget {
  final String tempId;

  const AdmissionLandingPage({super.key, required this.tempId});

  @override
  State<AdmissionLandingPage> createState() => _AdmissionLandingPageState();
}

class _AdmissionLandingPageState extends State<AdmissionLandingPage> {
  final AdmissionService _service = AdmissionService();
  AdmissionCandidate? candidate;
  List<ChecklistStage> stages = [];
  List<String> completedStageIds = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final cand = await _service.getCandidateByTempId(widget.tempId);
    final st = await _service.getStages();
    final completed = cand == null ? [] : await _service.getCompletedStageIds(cand.id);

    setState(() {
      candidate = cand;
      stages = st;
      completedStageIds = completed;
      loading = false;
    });
  }

  bool _allStagesDone() {
    return stages.isNotEmpty && completedStageIds.length == stages.length;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Admission Checklist')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: candidate == null
            ? const Center(child: Text('No candidate found'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temporary ID: ${widget.tempId}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    candidate!.fullName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: stages.length,
                      itemBuilder: (context, index) {
                        final stage = stages[index];
                        final completed = completedStageIds.contains(stage.id);

                        return Card(
                          child: ListTile(
                            leading: Icon(
                              completed ? Icons.check_circle : Icons.pending,
                              color: completed ? Colors.green : Colors.orange,
                            ),
                            title: Text(stage.title),
                            subtitle: Text('${stage.department} • Room ${stage.roomNo}'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => StageDetailPage(
                                    tempId: widget.tempId,
                                    stage: stage,
                                  ),
                                ),
                              ).then((_) => _loadData());
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_allStagesDone())
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text('Proceed to Login'),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}