/// Visual tokens shared by store screenshots and website social artwork.
abstract final class BrandArtworkStyle {
  /// The background gradient top color.
  static const String backgroundTop = '#FFFDF6';

  /// The background gradient bottom color.
  static const String backgroundBottom = '#DCEDE2';

  /// The color of yellow decorations.
  static const String yellowDecoration = '#F2CB5538';

  /// The color of green decorations.
  static const String greenDecoration = '#34735124';

  /// The color of the ink.
  static const String ink = '#172019';

  /// The primary color.
  static const String primary = '#24543B';

  /// The font family of the title.
  static const String titleFontFamily = 'Noto Sans';
}

/// Returns the ImageMagick arguments for the plain launcher-icon gradient.
///
/// Launcher icons are small and are masked differently by every platform, so
/// they use the brand gradient without the decorations that would be cropped.
List<String> brandIconBackgroundArguments({required int size}) => [
  '-size',
  '${size}x$size',
  'gradient:${BrandArtworkStyle.backgroundTop}-'
      '${BrandArtworkStyle.backgroundBottom}',
];

/// Returns the ImageMagick arguments for StopCorn's softly decorated gradient.
List<String> brandBackgroundArguments({
  required int width,
  required int height,
  bool mirrorDecorations = false,
}) => [
  '-size',
  '${width}x$height',
  'gradient:${BrandArtworkStyle.backgroundTop}-'
      '${BrandArtworkStyle.backgroundBottom}',
  '-fill',
  BrandArtworkStyle.yellowDecoration,
  '-draw',
  mirrorDecorations
      ? 'circle ${width * 8 ~/ 100},${height * 8 ~/ 100} '
            '${width * -12 ~/ 100},${height * 8 ~/ 100}'
      : 'circle ${width * 92 ~/ 100},${height * 8 ~/ 100} '
            '${width * 112 ~/ 100},${height * 8 ~/ 100}',
  '-fill',
  BrandArtworkStyle.greenDecoration,
  '-draw',
  mirrorDecorations
      ? 'circle ${width * 95 ~/ 100},${height * 90 ~/ 100} '
            '${width * 71 ~/ 100},${height * 90 ~/ 100}'
      : 'circle ${width * 5 ~/ 100},${height * 90 ~/ 100} '
            '${width * 29 ~/ 100},${height * 90 ~/ 100}',
];
