import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../utils/asset_utils.dart';

class PdfViewerPage extends StatefulWidget {
  final String title;
  final String pdfPath;
  final String? imagePath;

  const PdfViewerPage({
    super.key,
    required this.title,
    required this.pdfPath,
    this.imagePath,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final TransformationController _imageTransformationController = TransformationController();
  late bool _showImageView;
  String? _resolvedImagePath;

  @override
  void initState() {
    super.initState();
    
    // Check if an image path is provided or if this is a campus map document
    final String lowerTitle = widget.title.toLowerCase();
    if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      _resolvedImagePath = widget.imagePath;
    } else if (lowerTitle.contains('campus map') || lowerTitle.contains('map')) {
      _resolvedImagePath = 'assets/assets/images/campus map.jpg';
    } else {
      _resolvedImagePath = null;
    }

    _showImageView = _resolvedImagePath != null;
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    _imageTransformationController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    if (_showImageView) {
      final Matrix4 current = _imageTransformationController.value;
      final double currentScale = current.getMaxScaleOnAxis();
      final double targetScale = (currentScale * 1.35).clamp(1.0, 10.0);
      final double factor = targetScale / currentScale;
      _imageTransformationController.value = current * Matrix4.diagonal3Values(factor, factor, 1.0);
    } else {
      final double currentZoom = _pdfViewerController.zoomLevel;
      final double newZoom = (currentZoom + 0.5).clamp(1.0, 10.0);
      _pdfViewerController.zoomLevel = newZoom;
    }
  }

  void _zoomOut() {
    if (_showImageView) {
      final Matrix4 current = _imageTransformationController.value;
      final double currentScale = current.getMaxScaleOnAxis();
      final double targetScale = (currentScale / 1.35).clamp(1.0, 10.0);
      final double factor = targetScale / currentScale;
      _imageTransformationController.value = current * Matrix4.diagonal3Values(factor, factor, 1.0);
    } else {
      final double currentZoom = _pdfViewerController.zoomLevel;
      final double newZoom = (currentZoom - 0.5).clamp(1.0, 10.0);
      _pdfViewerController.zoomLevel = newZoom;
    }
  }

  void _resetZoom() {
    if (_showImageView) {
      _imageTransformationController.value = Matrix4.identity();
    } else {
      _pdfViewerController.zoomLevel = 1.0;
    }
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
          if (_resolvedImagePath != null) ...[
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => setState(() => _showImageView = true),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _showImageView ? Colors.redAccent : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.map, color: Colors.white, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              "Map",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: _showImageView ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() => _showImageView = false),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: !_showImageView ? Colors.redAccent : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.picture_as_pdf, color: Colors.white, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              "PDF",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: !_showImageView ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          IconButton(
            icon: const Icon(Icons.center_focus_strong_rounded, color: Colors.white70),
            tooltip: "Reset Zoom",
            onPressed: _resetZoom,
          ),
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
      body: _showImageView ? _buildImageView() : _buildPdfView(),
    );
  }

  Widget _buildImageView() {
    return Stack(
      children: [
        InteractiveViewer(
          transformationController: _imageTransformationController,
          minScale: 0.8,
          maxScale: 10.0,
          child: Center(
            child: buildCachedImage(
              _resolvedImagePath!,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.broken_image_rounded,
                        color: Colors.redAccent,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Unable to load map image",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () => setState(() => _showImageView = false),
                        child: const Text("Switch to PDF View", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.pinch, color: Colors.white70, size: 16),
                const SizedBox(width: 6),
                Text(
                  "Pinch / Scroll to Zoom (up to 10x)",
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPdfView() {
    final String pdfUrl = getRawGithubUrl(widget.pdfPath);
    return SfPdfViewer.network(
      pdfUrl,
      controller: _pdfViewerController,
      maxZoomLevel: 10.0,
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
}
