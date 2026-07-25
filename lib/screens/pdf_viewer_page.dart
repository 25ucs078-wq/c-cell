import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  final String title;
  final String pdfPath;

  const PdfViewerPage({
    super.key,
    required this.title,
    required this.pdfPath,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  late Future<Uint8List> _pdfBytesFuture;

  @override
  void initState() {
    super.initState();
    _pdfBytesFuture = _loadPdfBytes();
  }

  Future<Uint8List> _loadPdfBytes() async {
    final List<String> candidatePaths = [
      widget.pdfPath,
      if (widget.pdfPath.startsWith('assets/')) widget.pdfPath.substring(7),
      if (!widget.pdfPath.startsWith('assets/')) 'assets/${widget.pdfPath}',
      if (!widget.pdfPath.startsWith('assets/assets/')) 'assets/${widget.pdfPath}',
    ];

    // 1. Try loading via rootBundle (Flutter asset bundle)
    for (final path in candidatePaths) {
      try {
        final ByteData data = await rootBundle.load(path);
        return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      } catch (e) {
        debugPrint("rootBundle.load failed for $path: $e");
      }
    }

    // 2. Fallback for Desktop/Mobile native platforms: read directly from file system
    if (!kIsWeb) {
      for (final path in candidatePaths) {
        try {
          final file = File(path);
          if (await file.exists()) {
            return await file.readAsBytes();
          }
        } catch (e) {
          debugPrint("File read failed for $path: $e");
        }
      }
    }

    throw Exception("PDF file not found at ${widget.pdfPath}");
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    final double currentZoom = _pdfViewerController.zoomLevel;
    final double newZoom = (currentZoom + 0.25).clamp(1.0, 3.0);
    _pdfViewerController.zoomLevel = newZoom;
  }

  void _zoomOut() {
    final double currentZoom = _pdfViewerController.zoomLevel;
    final double newZoom = (currentZoom - 0.25).clamp(1.0, 3.0);
    _pdfViewerController.zoomLevel = newZoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1123),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_out_rounded, color: Colors.white70),
            tooltip: "Zoom Out",
            onPressed: _zoomOut,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in_rounded, color: Colors.white70),
            tooltip: "Zoom In",
            onPressed: _zoomIn,
          ),
          const SizedBox(width: 8),
        ],
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFF1E2243),
            width: 1,
          ),
        ),
      ),
      body: FutureBuilder<Uint8List>(
        future: _pdfBytesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.redAccent),
                  SizedBox(height: 16),
                  Text(
                    "Loading PDF Document...",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: Colors.redAccent,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Unable to Load PDF",
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Asset path: ${widget.pdfPath}\n\nError: ${snapshot.error}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      onPressed: () {
                        setState(() {
                          _pdfBytesFuture = _loadPdfBytes();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return SfPdfViewer.memory(
              snapshot.data!,
              controller: _pdfViewerController,
              canShowScrollHead: true,
              canShowScrollStatus: true,
              enableDoubleTapZooming: true,
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Failed to render PDF: ${details.description}"),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
