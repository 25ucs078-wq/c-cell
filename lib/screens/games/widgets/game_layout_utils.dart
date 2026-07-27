import 'dart:math' as math;

double resolveResponsiveBoardSize({
  required double maxWidth,
  required double maxHeight,
  double horizontalPadding = 40,
  double verticalPadding = 0,
  double maxBoardSize = 360,
  double minBoardSize = 220,
  double heightRatio = 0.6,
}) {
  final availableWidth = math.max(0.0, maxWidth - horizontalPadding);
  final availableHeight = math.max(0.0, maxHeight - verticalPadding);
  final widthBased = availableWidth;
  final heightBased = availableHeight * heightRatio;
  final fittedSize = math.min(widthBased, heightBased);
  final responsiveMin = math.min(minBoardSize, math.max(160.0, fittedSize));

  return fittedSize.clamp(responsiveMin, maxBoardSize);
}

double resolveResponsiveScale({
  required double width,
  double baseWidth = 390,
  double minScale = 0.8,
  double maxScale = 1.15,
}) {
  if (width <= 0) {
    return minScale;
  }

  final scale = width / baseWidth;
  return scale.clamp(minScale, maxScale);
}
