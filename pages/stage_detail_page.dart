import 'package:flutter/material.dart';
import '../models/admission_models.dart';
import '../services/admission_service.dart';

class StageDetailPage extends StatefulWidget {
  final String tempId;
  final ChecklistStage stage;

  const StageDetailPage({
    super.key,
    required this.tempId,
    required this.stage,
  });

  @override
  State<StageDetailPage> createState() => _StageDetailPageState();
}

class _StageDetailPageState extends State<StageDetailPage> {
  final AdmissionService _service = AdmissionService();
  final TextEditingController _codeController = TextEditingController();
  String message = '';
  bool loading = false;

  Future<void> _submitCode() async {
    final enteredCode = _codeController.text.trim().toUpperCase();

    if (enteredCode.isEmpty) {
      setState(() => message = 'Enter the code');
      return;
    }

    if (enteredCode != widget.stage.adminCode.toUpperCase()) {
      setState(() => message = 'Incorrect code');
      return;
    }

    setState(() {
      loading = true;
      message = '';
    });

    final candidate = await _service.getCandidateByTempId(widget.tempId);
    if (candidate != null) {
      await _service.markStageComplete(
        candidateId: candidate.id,
        stageId: widget.stage.id,
        staffCode: enteredCode,
      );
      if (!mounted) return;
      setState(() => message = 'Stage completed successfully');
      Navigator.pop(context);
      return;
    }

    if (!mounted) return;
    setState(() {
      loading = false;
      message = 'Candidate not found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.stage.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.stage.department, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Room: ${widget.stage.roomNo}'),
            const SizedBox(height: 12),
            Text(widget.stage.instructions),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Enter stage code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loading ? null : _submitCode,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Verify Code'),
            ),
            const SizedBox(height: 12),
            Text(message),
          ],
        ),
      ),
    );
  }
}