import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Admission Application Number Validation Format Tests', () {
    final regExp = RegExp(r'^LNM[A-Z0-9]{5}$');

    final validExamples = [
      'LNMPPNUS',
      'LNM53467',
      'LNMDGH78',
      'LNM5KB7D',
      'LNMGHJ9H',
      'LNM123AB',
      'LNMAB123',
      'LNM1A2B3',
      'LNM99999',
      'LNMAAAAA',
      'LNMSV5KB', // Previous format example remains valid under new rule
    ];

    final invalidExamples = [
      'LNM1234', // 4 chars after LNM
      'LNM123456', // 6 chars after LNM
      'ABC12345', // does not start with LNM
      'LNM12@A5', // contains special character
      'LNM12 A5', // contains space
      '12345678', // purely numeric without LNM
    ];

    for (final example in validExamples) {
      test('Valid format accepts: $example', () {
        final normalized = example.trim().toUpperCase();
        expect(regExp.hasMatch(normalized), isTrue);
      });
    }

    for (final example in invalidExamples) {
      test('Invalid format rejects: $example', () {
        final normalized = example.trim().toUpperCase();
        expect(regExp.hasMatch(normalized), isFalse);
      });
    }

    test('Case-insensitive normalization converts lowercase input', () {
      const rawInput = '  lnm53467  ';
      final normalized = rawInput.trim().toUpperCase();
      expect(normalized, 'LNM53467');
      expect(regExp.hasMatch(normalized), isTrue);
    });
  });
}
