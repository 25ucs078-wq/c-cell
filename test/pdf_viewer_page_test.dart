import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:c_cell_app/screens/pdf_viewer_page.dart';

void main() {
  testWidgets('PdfViewerPage loads Campus Map with dual view options', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PdfViewerPage(
          title: 'Campus Map',
          pdfPath: 'assets/assets/pdfs/acadsmap/AcadsAreamap.pdf',
          imagePath: 'assets/assets/images/campus map.jpg',
        ),
      ),
    );

    // Verify Title rendered
    expect(find.text('Campus Map'), findsOneWidget);

    // Verify Map and PDF toggle buttons exist
    expect(find.text('Map'), findsOneWidget);
    expect(find.text('PDF'), findsOneWidget);

    // Verify initial Map view image hint is present
    expect(find.text('Pinch / Scroll to Zoom (up to 10x)'), findsOneWidget);
  });
}
