import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:c_cell_app/screens/games/game_2048_page.dart';

void main() {
  testWidgets('Game2048Page renders cleanly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Game2048Page(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Join the tiles to get to 2048!'), findsOneWidget);
  });
}
