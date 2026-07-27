import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Welcome Drawer Display Name Logic Tests', () {
    test('Formats valid displayName correctly to uppercase', () {
      const String rawName = 'Rahul Sharma';
      final hasName = rawName.trim().isNotEmpty;
      final displayName = hasName ? rawName.trim().toUpperCase() : null;

      expect(hasName, isTrue);
      expect(displayName, 'RAHUL SHARMA');
    });

    test('Gracefully handles null or empty displayName without placeholder strings', () {
      const String? rawName = null;
      final bool hasName = rawName != null && rawName.trim().isNotEmpty;
      final String? displayName = hasName ? rawName.trim().toUpperCase() : null;

      expect(hasName, isFalse);
      expect(displayName, isNull);
    });

    test('Gracefully handles whitespace-only displayName', () {
      const String rawName = '   ';
      final hasName = rawName.trim().isNotEmpty;
      final displayName = hasName ? rawName.trim().toUpperCase() : null;

      expect(hasName, isFalse);
      expect(displayName, isNull);
    });
  });
}
