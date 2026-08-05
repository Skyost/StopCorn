import 'dart:io';

import '../artwork/brand_artwork.dart';

/// Generates the social sharing artwork consumed by the Nuxt website.
Future<void> main() async {
  Directory repository = _repositoryRoot();
  File logo = File('${repository.path}/assets/branding/logo.svg');
  Directory output = Directory('${repository.path}/social/generated');

  if (!logo.existsSync()) {
    throw StateError('Missing application logo at ${logo.path}.');
  }

  String magick = await _findExecutable('magick');
  await output.create(recursive: true);
  Directory temporary = await Directory.systemTemp.createTemp(
    'stopcorn-social-',
  );

  try {
    for (_SocialImageSpec spec in _SocialArtwork.images) {
      File destination = File('${output.path}/${spec.fileName}');
      Directory working = Directory('${temporary.path}/${spec.id}');
      await working.create(recursive: true);
      await _compose(
        magick: magick,
        logo: logo,
        destination: destination,
        working: working,
        spec: spec,
      );
      (int, int) dimensions = await _imageSize(magick, destination);
      if (dimensions != (spec.width, spec.height)) {
        throw StateError(
          '${spec.fileName} has unexpected dimensions '
          '${dimensions.$1}x${dimensions.$2}.',
        );
      }
      stdout.writeln(
        'Created ${destination.path.substring(repository.path.length + 1)}',
      );
    }
  } finally {
    if (temporary.existsSync()) {
      await temporary.delete(recursive: true);
    }
  }
}

/// Composes one social format from the shared background, logo and title.
Future<void> _compose({
  required String magick,
  required File logo,
  required File destination,
  required Directory working,
  required _SocialImageSpec spec,
}) async {
  File background = File('${working.path}/background.png');
  File resizedLogo = File('${working.path}/logo.png');
  File shadowedLogo = File('${working.path}/logo-shadow.png');
  File title = File('${working.path}/title.png');

  await _run(
    magick,
    [
      ...brandBackgroundArguments(
        width: spec.width,
        height: spec.height,
        mirrorDecorations: spec.mirrorDecorations,
      ),
      background.path,
    ],
  );

  int logoHeight = spec.height * spec.logoHeightPercent ~/ 100;
  await _run(
    magick,
    [
      '-background',
      'none',
      logo.path,
      '-resize',
      'x$logoHeight',
      resizedLogo.path,
    ],
  );
  await _run(
    magick,
    [
      resizedLogo.path,
      '(',
      '+clone',
      '-background',
      _SocialArtwork.logoShadow,
      '-shadow',
      _SocialArtwork.logoShadowGeometry,
      ')',
      '+swap',
      '-background',
      'none',
      '-layers',
      'merge',
      shadowedLogo.path,
    ],
  );

  (int, int) logoDimensions = await _imageSize(magick, shadowedLogo);
  int contentHeight = logoDimensions.$2;
  int titleGap = 0;
  (int, int)? titleDimensions;
  if (spec.showTitle) {
    int titleWidth = spec.width * _SocialArtwork.titleWidthPercent ~/ 100;
    int titlePointSize = spec.height * _SocialArtwork.titlePointSizePercent ~/ 100;
    await _renderTitle(
      magick: magick,
      output: title,
      width: titleWidth,
      pointSize: titlePointSize,
    );
    titleDimensions = await _imageSize(magick, title);
    titleGap = spec.height * _SocialArtwork.logoTitleGapPercent ~/ 100;
    contentHeight += titleGap + titleDimensions.$2;
  }

  int logoLeft = (spec.width - logoDimensions.$1) ~/ 2;
  int logoTop = (spec.height - contentHeight) ~/ 2;
  List<String> composition = [
    background.path,
    shadowedLogo.path,
    '-gravity',
    'northwest',
    '-geometry',
    '+$logoLeft+$logoTop',
    '-composite',
  ];
  if (titleDimensions != null) {
    int titleLeft = (spec.width - titleDimensions.$1) ~/ 2;
    int titleTop = logoTop + logoDimensions.$2 + titleGap;
    composition.addAll([
      title.path,
      '-gravity',
      'northwest',
      '-geometry',
      '+$titleLeft+$titleTop',
      '-composite',
    ]);
  }
  composition.addAll([
    '-strip',
    '-define',
    'png:compression-level=9',
    destination.path,
  ]);
  await _run(magick, composition);
}

/// Renders the StopCorn wordmark with its primary-colored suffix.
Future<void> _renderTitle({
  required String magick,
  required File output,
  required int width,
  required int pointSize,
}) async {
  File source = File('${output.parent.path}/title-source.png');
  String markup =
      '<span font_family="${BrandArtworkStyle.titleFontFamily}" '
      'font_weight="bold" font_size="${pointSize}pt" '
      'foreground="${BrandArtworkStyle.ink}">Stop'
      '<span foreground="${BrandArtworkStyle.primary}" '
      'font_weight="${_SocialArtwork.highlightWeight}">Corn</span>'
      '</span>';
  await _run(
    magick,
    [
      '-background',
      'none',
      '-density',
      '${_SocialArtwork.titleDensity}',
      '-gravity',
      'center',
      '-size',
      '${width}x',
      '-define',
      'pango:markup=true',
      '-define',
      'pango:align=center',
      'pango:$markup',
      source.path,
    ],
  );
  await _run(
    magick,
    [source.path, '-trim', '+repage', output.path],
  );
}

/// Reads the dimensions of one generated image through ImageMagick.
Future<(int, int)> _imageSize(String magick, File file) async {
  ProcessResult result = await Process.run(
    magick,
    ['identify', '-format', '%w %h', file.path],
  );
  if (result.exitCode != 0) {
    throw ProcessException(
      magick,
      ['identify', file.path],
      '${result.stderr}'.trim(),
      result.exitCode,
    );
  }
  List<String> dimensions = '${result.stdout}'.trim().split(' ');
  return (int.parse(dimensions[0]), int.parse(dimensions[1]));
}

/// Verifies that a required executable is available.
Future<String> _findExecutable(String executable) async {
  try {
    ProcessResult result = await Process.run(executable, ['-version']);
    if (result.exitCode == 0) {
      return executable;
    }
  } on ProcessException {
    // Report one concise and actionable message below.
  }
  throw StateError(
    'ImageMagick is required and "$executable" was not found in PATH.',
  );
}

/// Runs ImageMagick and surfaces its diagnostic output on failure.
Future<void> _run(String executable, List<String> arguments) async {
  ProcessResult result = await Process.run(executable, arguments);
  if (result.exitCode != 0) {
    throw ProcessException(
      executable,
      arguments,
      '${result.stderr}'.trim(),
      result.exitCode,
    );
  }
}

/// Returns the repository root from this script's stable location.
Directory _repositoryRoot() => File.fromUri(
  Platform.script,
).parent.parent.parent;

/// Immutable dimensions and layout choices for one social image.
final class _SocialImageSpec {
  /// Stable identifier used for temporary files.
  final String id;

  /// Output filename under `social/generated`.
  final String fileName;

  /// Output width in pixels.
  final int width;

  /// Output height in pixels.
  final int height;

  /// Logo height relative to the complete canvas.
  final int logoHeightPercent;

  /// Whether the StopCorn wordmark is rendered below the logo.
  final bool showTitle;

  /// Whether the shared corner decorations are horizontally mirrored.
  final bool mirrorDecorations;

  /// Creates one immutable social image specification.
  const _SocialImageSpec({
    required this.id,
    required this.fileName,
    required this.width,
    required this.height,
    required this.logoHeightPercent,
    required this.showTitle,
    required this.mirrorDecorations,
  });
}

/// Centralized dimensions and layout constants for both social formats.
abstract final class _SocialArtwork {
  /// Formats generated for website sharing metadata.
  static const List<_SocialImageSpec> images = [
    _SocialImageSpec(
      id: 'open-graph',
      fileName: 'open-graph.png',
      width: 1200,
      height: 630,
      logoHeightPercent: 40,
      showTitle: true,
      mirrorDecorations: false,
    ),
    _SocialImageSpec(
      id: 'twitter',
      fileName: 'twitter.png',
      width: 1024,
      height: 1024,
      logoHeightPercent: 43,
      showTitle: false,
      mirrorDecorations: true,
    ),
  ];

  /// Maximum title width relative to the canvas.
  static const int titleWidthPercent = 70;

  /// Title point size relative to the canvas height.
  static const int titlePointSizePercent = 13;

  /// Vertical gap between the logo and title.
  static const int logoTitleGapPercent = 4;

  /// Pango rendering density in dots per inch.
  static const int titleDensity = 72;

  /// Weight applied to the primary-colored title suffix.
  static const int highlightWeight = 800;

  /// Translucent shadow color used below the logo.
  static const String logoShadow = '#17201948';

  /// ImageMagick shadow geometry used below the logo.
  static const String logoShadowGeometry = '45x16+0+14';
}
