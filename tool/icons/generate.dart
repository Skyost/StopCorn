import 'dart:convert';
import 'dart:io';

import '../artwork/brand_artwork.dart';

/// Android densities and their scale relative to the baseline density.
const Map<String, double> _androidDensities = {
  'mdpi': 1,
  'hdpi': 1.5,
  'xhdpi': 2,
  'xxhdpi': 3,
  'xxxhdpi': 4,
};

/// Baseline edge, in density-independent pixels, of a legacy launcher icon.
const int _legacyBaseSize = 48;

/// Baseline edge, in density-independent pixels, of an adaptive icon layer.
///
/// Android masks an adaptive icon down to the inner 72 of these 108 units, so
/// the logo has to stay well inside that safe zone.
const int _adaptiveBaseSize = 108;

/// Share of a legacy icon's edge covered by the logo.
const int _legacyLogoPercent = 62;

/// Share of an adaptive layer's edge covered by the logo.
const int _adaptiveLogoPercent = 46;

/// Share of an iOS icon's edge covered by the logo.
const int _iosLogoPercent = 62;

/// Exact edge required by the iOS App Store marketing icon.
const int _appStoreSize = 1024;

/// Exact edge required by the Google Play store-listing icon.
const int _googlePlaySize = 512;

/// Maximum Google Play icon size in bytes.
const int _googlePlayMaxBytes = 1024 * 1024;

/// Corner radius of a legacy icon, as a share of its edge.
const int _legacyCornerPercent = 22;

/// Generates store and platform icons from the tracked vector logo.
Future<void> main(List<String> arguments) async {
  bool storeOnly = _parseArguments(arguments);
  Directory repository = _repositoryRoot();
  File logo = File('${repository.path}/assets/branding/logo.svg');
  if (!logo.existsSync()) {
    throw StateError('Missing application logo at ${logo.path}.');
  }

  String magick = await _findExecutable('magick');
  Directory temporary = await Directory.systemTemp.createTemp(
    'stopcorn-icons-',
  );

  try {
    if (!storeOnly) {
      await _generateAndroid(
        magick: magick,
        logo: logo,
        repository: repository,
        working: temporary,
      );
      await _generateIos(
        magick: magick,
        logo: logo,
        repository: repository,
        working: temporary,
      );
    }
    await _generateStoreIcons(
      magick: magick,
      logo: logo,
      repository: repository,
      working: temporary,
    );
  } finally {
    if (temporary.existsSync()) {
      await temporary.delete(recursive: true);
    }
  }
}

/// Returns whether only store assets should be generated.
bool _parseArguments(List<String> arguments) {
  if (arguments.isEmpty) {
    return false;
  }
  if (arguments.length == 1 && arguments.single == '--store-only') {
    return true;
  }
  throw ArgumentError(
    'Usage: dart run tool/icons/generate.dart [--store-only]',
  );
}

/// Writes the legacy and adaptive Android launcher icons.
Future<void> _generateAndroid({
  required String magick,
  required File logo,
  required Directory repository,
  required Directory working,
}) async {
  Directory resources = Directory(
    '${repository.path}/android/app/src/main/res',
  );

  for (MapEntry<String, double> density in _androidDensities.entries) {
    Directory mipmap = Directory('${resources.path}/mipmap-${density.key}');
    await mipmap.create(recursive: true);

    int legacySize = (_legacyBaseSize * density.value).round();
    await _composeIcon(
      magick: magick,
      logo: logo,
      working: working,
      destination: File('${mipmap.path}/ic_launcher.png'),
      size: legacySize,
      logoPercent: _legacyLogoPercent,
      cornerPercent: _legacyCornerPercent,
    );

    int adaptiveSize = (_adaptiveBaseSize * density.value).round();
    await _run(magick, [
      ...brandIconBackgroundArguments(size: adaptiveSize),
      'PNG24:${mipmap.path}/ic_launcher_background.png',
    ]);
    await _composeIcon(
      magick: magick,
      logo: logo,
      working: working,
      destination: File('${mipmap.path}/ic_launcher_foreground.png'),
      size: adaptiveSize,
      logoPercent: _adaptiveLogoPercent,
      transparent: true,
    );
  }

  Directory anydpi = Directory('${resources.path}/mipmap-anydpi-v26');
  await anydpi.create(recursive: true);
  const String adaptiveIcon =
      '<?xml version="1.0" encoding="utf-8"?>\n'
      '<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">\n'
      '    <background android:drawable="@mipmap/ic_launcher_background" />\n'
      '    <foreground android:drawable="@mipmap/ic_launcher_foreground" />\n'
      '</adaptive-icon>\n';
  await File('${anydpi.path}/ic_launcher.xml').writeAsString(adaptiveIcon);

  stdout.writeln('Created the Android launcher icons.');
}

/// Writes every opaque iOS icon listed in the application asset catalog.
Future<void> _generateIos({
  required String magick,
  required File logo,
  required Directory repository,
  required Directory working,
}) async {
  Directory appIcon = Directory(
    '${repository.path}/ios/Runner/Assets.xcassets/AppIcon.appiconset',
  );
  File manifest = File('${appIcon.path}/Contents.json');
  if (!manifest.existsSync()) {
    throw StateError('Missing iOS asset catalog at ${manifest.path}.');
  }

  Object? decoded = jsonDecode(await manifest.readAsString());
  if (decoded is! Map<String, Object?> || decoded['images'] is! List<Object?>) {
    throw StateError('Invalid iOS asset catalog at ${manifest.path}.');
  }

  Set<String> written = {};
  for (Object? entry in decoded['images']! as List<Object?>) {
    if (entry is! Map<String, Object?>) {
      throw StateError('Invalid image entry in ${manifest.path}.');
    }
    String? fileName = entry['filename'] as String?;
    if (fileName == null || !written.add(fileName)) {
      continue;
    }
    int size = _iosPixelSize(
      entry['size']! as String,
      entry['scale']! as String,
    );
    await _composeIcon(
      magick: magick,
      logo: logo,
      working: working,
      destination: File('${appIcon.path}/$fileName'),
      size: size,
      logoPercent: _iosLogoPercent,
    );
  }

  stdout.writeln('Created ${written.length} iOS application icons.');
}

/// Writes the exact high-resolution assets expected by both store listings.
Future<void> _generateStoreIcons({
  required String magick,
  required File logo,
  required Directory repository,
  required Directory working,
}) async {
  Directory store = Directory('${repository.path}/tool/icons/outputs');
  await store.create(recursive: true);

  File appStore = File('${store.path}/app-store-icon.png');
  await _composeIcon(
    magick: magick,
    logo: logo,
    working: working,
    destination: appStore,
    size: _appStoreSize,
    logoPercent: _iosLogoPercent,
    stripMetadata: true,
  );
  await _validateStoreIcon(
    magick: magick,
    file: appStore,
    expectsAlpha: false,
  );
  File iosMarketingIcon = File(
    '${repository.path}/ios/Runner/Assets.xcassets/'
    'AppIcon.appiconset/Icon-App-1024x1024@1x.png',
  );
  if (!iosMarketingIcon.existsSync()) {
    throw StateError(
      'Missing iOS marketing icon at ${iosMarketingIcon.path}.',
    );
  }
  await appStore.copy(iosMarketingIcon.path);

  File googlePlay = File('${store.path}/google-play-icon.png');
  await _composeIcon(
    magick: magick,
    logo: logo,
    working: working,
    destination: googlePlay,
    size: _googlePlaySize,
    logoPercent: _iosLogoPercent,
    includeOpaqueAlpha: true,
    stripMetadata: true,
  );
  await _validateStoreIcon(
    magick: magick,
    file: googlePlay,
    expectsAlpha: true,
    maximumBytes: _googlePlayMaxBytes,
  );

  stdout
    ..writeln('Created the store listing icons:')
    ..writeln('  ${_relativePath(repository, appStore)}')
    ..writeln('  ${_relativePath(repository, googlePlay)}')
    ..writeln(
      'Updated ${_relativePath(repository, iosMarketingIcon)}',
    );
}

/// Converts a `20x20` point size and a `2x` scale into an edge in pixels.
int _iosPixelSize(String size, String scale) {
  double points = double.parse(size.split('x').first);
  double factor = double.parse(scale.replaceAll('x', ''));
  return (points * factor).round();
}

/// Draws the logo centered on the brand background, or on transparency.
Future<void> _composeIcon({
  required String magick,
  required File logo,
  required Directory working,
  required File destination,
  required int size,
  required int logoPercent,
  int? cornerPercent,
  bool transparent = false,
  bool includeOpaqueAlpha = false,
  bool stripMetadata = false,
}) async {
  File background = File('${working.path}/background-$size.png');
  File resizedLogo = File(
    '${working.path}/logo-$size-$logoPercent.png',
  );

  if (transparent) {
    await _run(magick, [
      '-size',
      '${size}x$size',
      'xc:none',
      // `PNG32:` is what actually pins the output to 8-bit RGBA: without it a
      // mostly transparent canvas is written as grayscale and drags the
      // composited logo down with it. `-type` alone is ignored on write.
      'PNG32:${background.path}',
    ]);
  } else {
    await _run(magick, [
      ...brandIconBackgroundArguments(size: size),
      'PNG24:${background.path}',
    ]);
    if (cornerPercent != null) {
      int radius = size * cornerPercent ~/ 100;
      File mask = File('${working.path}/mask-$size.png');
      await _run(magick, [
        '-size',
        '${size}x$size',
        'xc:none',
        '-fill',
        'white',
        '-draw',
        'roundrectangle 0,0 ${size - 1},${size - 1} $radius,$radius',
        'PNG32:${mask.path}',
      ]);
      await _run(magick, [
        background.path,
        mask.path,
        '-alpha',
        'off',
        '-compose',
        'CopyOpacity',
        '-composite',
        'PNG32:${background.path}',
      ]);
    }
  }

  int logoHeight = size * logoPercent ~/ 100;
  await _run(magick, [
    '-background',
    'none',
    logo.path,
    '-resize',
    'x$logoHeight',
    'PNG32:${resizedLogo.path}',
  ]);

  List<String> composition = [
    background.path,
    resizedLogo.path,
    '-gravity',
    'center',
    '-compose',
    'over',
    '-composite',
  ];
  bool keepsAlpha = transparent || cornerPercent != null || includeOpaqueAlpha;
  if (!keepsAlpha) {
    // iOS rejects an icon carrying an alpha channel.
    composition.addAll([
      '-background',
      BrandArtworkStyle.backgroundTop,
      '-alpha',
      'remove',
      '-alpha',
      'off',
    ]);
  }
  composition.addAll(['-colorspace', 'sRGB']);
  if (stripMetadata) {
    composition.add('-strip');
  }
  composition.add('${keepsAlpha ? 'PNG32' : 'PNG24'}:${destination.path}');
  await _run(magick, composition);

  (int, int) dimensions = await _imageSize(magick, destination);
  if (dimensions != (size, size)) {
    throw StateError(
      '${destination.path} has unexpected dimensions '
      '${dimensions.$1}x${dimensions.$2}.',
    );
  }
}

/// Checks store-specific channel, color-space, and file-size requirements.
Future<void> _validateStoreIcon({
  required String magick,
  required File file,
  required bool expectsAlpha,
  int? maximumBytes,
}) async {
  String channels = await _imageProperty(magick, file, '%[channels]');
  String channelType = channels.toLowerCase().split(RegExp(r'\s+')).first;
  bool hasAlpha = channelType.endsWith('a');
  if (hasAlpha != expectsAlpha) {
    throw StateError(
      '${file.path} has channels "$channels"; '
      '${expectsAlpha ? 'an alpha channel is required' : 'alpha is forbidden'}.',
    );
  }

  String colorSpace = await _imageProperty(magick, file, '%[colorspace]');
  if (colorSpace.toLowerCase() != 'srgb') {
    throw StateError(
      '${file.path} uses $colorSpace instead of the sRGB color space.',
    );
  }

  String opaque = await _imageProperty(magick, file, '%[opaque]');
  if (opaque.toLowerCase() != 'true') {
    throw StateError(
      '${file.path} contains transparent pixels; store icons must use the '
      'full square canvas.',
    );
  }

  int bytes = await file.length();
  if (maximumBytes != null && bytes > maximumBytes) {
    throw StateError(
      '${file.path} is $bytes bytes; the maximum is $maximumBytes bytes.',
    );
  }
}

/// Reads the pixel dimensions of [file].
Future<(int, int)> _imageSize(String magick, File file) async {
  String value = await _imageProperty(magick, file, '%w %h');
  List<String> parts = value.split(' ');
  return (int.parse(parts.first), int.parse(parts.last));
}

/// Reads a single ImageMagick property from [file].
Future<String> _imageProperty(
  String magick,
  File file,
  String format,
) async {
  ProcessResult result = await Process.run(magick, [
    'identify',
    '-format',
    format,
    file.path,
  ]);
  if (result.exitCode != 0) {
    throw ProcessException(magick, ['identify'], '${result.stderr}'.trim());
  }
  return '${result.stdout}'.trim();
}

/// Resolves [executable] and fails with an actionable message when absent.
Future<String> _findExecutable(String executable) async {
  try {
    ProcessResult result = await Process.run(executable, ['-version']);
    if (result.exitCode == 0) {
      return executable;
    }
  } on ProcessException {
    // Reported below with the installation hint.
  }
  throw StateError(
    'ImageMagick is required to generate the icons. Install `$executable`.',
  );
}

/// Runs [executable] and turns a non-zero exit code into an exception.
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

/// Locates the repository root from this script's own location.
Directory _repositoryRoot() => File.fromUri(
  Platform.script,
).parent.parent.parent;

/// Returns [file]'s path relative to [repository].
String _relativePath(Directory repository, File file) => file.path.substring(
  repository.path.length + 1,
);
