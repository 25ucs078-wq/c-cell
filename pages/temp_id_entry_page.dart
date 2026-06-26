import 'package:flutter/material.dart';
import '../services/admission_service.dart';
import 'admission_landing_page.dart';

class TempIdEntryPage extends StatefulWidget {
  const TempIdEntryPage({super.key});

  @override
  State<TempIdEntryPage> createState() => _TempIdEntryPageState();
}

class _TempIdEntryPageState extends State<TempIdEntryPage> {
  final AdmissionService _service = AdmissionService();
  final TextEditingController _controller = TextEditingController();
  bool loading = false;
  String error = '';

  bool _isValidTempId(String value) {
    final regex = RegExp(r'^LNM[a-zA-Z0-9]{5}$');
    return regex.hasMatch(value);
  }

  Future<void> _submit() async {
    final tempId = _controller.text.trim().toUpperCase();

    if (!_isValidTempId(tempId)) {
      setState(() => error = 'Temporary ID must be 8 characters and start with LNM');
      return;
    }

    setState(() {
      loading = true;
      error = '';
    });

    final candidate = await _service.getCandidateByTempId(tempId);

    if (candidate == null) {
      await _service.createCandidateFromTempId(tempId);
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AdmissionLandingPage(tempId: tempId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Temporary ID')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Temporary ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading ? null : _submit,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}