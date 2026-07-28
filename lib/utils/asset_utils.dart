import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Converts a local asset path or URL into a raw GitHub URL using format:
/// https://raw.githubusercontent.com/25ucs078-wq/c-cell/main/[path_to_file]
String getRawGithubUrl(String path) {
  if (path.isEmpty) return path;
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return path;
  }
  String cleanPath = path.startsWith('/') ? path.substring(1) : path;
  return 'https://raw.githubusercontent.com/25ucs078-wq/c-cell/main/$cleanPath';
}

/// Returns a CachedNetworkImage widget with GitHub raw URL formatting,
/// correctly sized SizedBox placeholder containing CircularProgressIndicator,
/// and Icon(Icons.error) errorWidget.
Widget buildCachedImage(
  String imagePath, {
  double? width,
  double? height,
  BoxFit? fit,
  Alignment alignment = Alignment.center,
  Color? color,
  BlendMode? colorBlendMode,
  Widget Function(BuildContext, String, dynamic)? errorWidget,
  Widget Function(BuildContext, String)? placeholder,
}) {
  final String url = getRawGithubUrl(imagePath);
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    fit: fit,
    alignment: alignment,
    color: color,
    colorBlendMode: colorBlendMode,
    placeholder: placeholder ??
        (context, url) => SizedBox(
              width: width,
              height: height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    errorWidget: errorWidget ?? (context, url, error) => const Icon(Icons.error),
  );
}

/// Helper for CircleAvatar or DecorationImage using CachedNetworkImageProvider
CachedNetworkImageProvider getCachedNetworkImageProvider(String imagePath) {
  return CachedNetworkImageProvider(getRawGithubUrl(imagePath));
}
