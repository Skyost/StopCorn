import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import '../artwork/brand_artwork.dart';
import 'device_catalog.dart';

/// Converts raw application screenshots into localized store artwork.
Future<void> main() async {
  Directory repository = _repositoryRoot();
  Directory rawRoot = Directory('${repository.path}/screenshots/raw');
  Directory outputRoot = Directory('${repository.path}/screenshots/store');
  File captionsFile = File(
    '${repository.path}/tool/screenshots/captions.json',
  );
  File logoFile = File('${repository.path}/assets/branding/logo.svg');
  File emojiFontFile = File(
    '${repository.path}/tool/screenshots/fonts/NotoColorEmoji-Regular.ttf',
  );
  File subtitleFontFile = File(
    '${repository.path}/tool/screenshots/fonts/Lora-Medium.ttf',
  );

  if (!rawRoot.existsSync()) {
    stderr.writeln(
      'No raw screenshots found. Run tool/screenshots/generate.sh first.',
    );
    exitCode = 2;
    return;
  }
  String magick = await _findExecutable('magick');
  _ArtworkCatalog catalog = _readCatalog(captionsFile);
  String subtitleFont = _resolveSubtitleFont(subtitleFontFile);
  Directory temporary = await Directory.systemTemp.createTemp(
    'stopcorn-screenshots-',
  );
  int processed = 0;

  try {
    _PangoRenderer pangoRenderer = await _PangoRenderer.create(
      temporary: temporary,
      font: emojiFontFile,
    );
    List<_RawCapture> discovered = rawRoot.listSync(recursive: true).whereType<File>().map((file) => _RawCapture.tryParse(file, rawRoot)).whereType<_RawCapture>().toList()
      ..sort((left, right) => left.key.compareTo(right.key));

    // A new RGBA capture wins over an older PNG with the same output name.
    Map<String, _RawCapture> captures = {};
    for (_RawCapture capture in discovered) {
      if (capture.isRgba || !captures.containsKey(capture.key)) {
        captures[capture.key] = capture;
      }
    }

    for (_RawCapture capture in captures.values) {
      _Caption? caption = catalog.captions[capture.locale]?[capture.name];
      if (caption == null) {
        stderr.writeln(
          'Missing caption for ${capture.locale}/${capture.name}.',
        );
        exitCode = 2;
        return;
      }
      _ArtworkProfile? profile = catalog.profiles[capture.name];
      if (profile == null) {
        stderr.writeln('Missing artwork profile for ${capture.name}.');
        exitCode = 2;
        return;
      }

      File destination = File(
        '${outputRoot.path}/${capture.locale}/${capture.platform}/'
        '${capture.device}/${capture.name}.png',
      );
      await destination.parent.create(recursive: true);
      Directory working = Directory(
        '${temporary.path}/${capture.locale}_${capture.platform}_'
        '${capture.device}_${capture.name}',
      );
      await working.create(recursive: true);
      File source = await capture.materializePng(magick);
      await _compose(
        magick: magick,
        source: source,
        outputWidth: capture.outputWidth,
        outputHeight: capture.outputHeight,
        destination: destination,
        working: working,
        logo: logoFile,
        caption: caption,
        profile: profile,
        platform: capture.platform,
        subtitleFont: subtitleFont,
        pangoRenderer: pangoRenderer,
      );
      processed++;
      stdout.writeln(
        'Created ${destination.path.substring(repository.path.length + 1)}',
      );
    }
  } finally {
    if (temporary.existsSync()) {
      await temporary.delete(recursive: true);
    }
  }

  if (processed == 0) {
    stderr.writeln('No screenshot was found under ${rawRoot.path}.');
    exitCode = 2;
    return;
  }
  stdout.writeln('Processed $processed localized store screenshots.');
}

/// One lossless Flutter capture, either already encoded or awaiting a fast
/// ImageMagick conversion from raw RGBA pixels.
final class _RawCapture {
  /// Filename pattern carrying raw and destination dimensions.
  static final RegExp _rgbaName = RegExp(
    r'^(.+)@(\d+)x(\d+)-to-(\d+)x(\d+)\.rgba$',
  );

  /// Encoded PNG or uncompressed RGBA source file.
  final File file;

  /// Locale folder associated with the capture.
  final String locale;

  /// Store platform folder associated with the capture.
  final String platform;

  /// Device form-factor folder associated with the capture.
  final String device;

  /// Stable screenshot scenario name.
  final String name;

  /// Raw RGBA width, or `null` for an encoded PNG.
  final int? width;

  /// Raw RGBA height, or `null` for an encoded PNG.
  final int? height;

  /// Requested final store width, when known.
  final int? outputWidth;

  /// Requested final store height, when known.
  final int? outputHeight;

  /// Creates one parsed capture descriptor.
  const _RawCapture({
    required this.file,
    required this.locale,
    required this.platform,
    required this.device,
    required this.name,
    required this.width,
    required this.height,
    required this.outputWidth,
    required this.outputHeight,
  });

  /// Whether [file] contains an uncompressed RGBA pixel stream.
  bool get isRgba => width != null && height != null;

  /// Unique path-like key used to deduplicate captures.
  String get key => '$locale/$platform/$device/$name';

  /// Parses a clean PNG or a dimensioned RGBA filename written by Flutter.
  static _RawCapture? tryParse(File file, Directory root) {
    List<String> parts = file.path.substring(root.path.length + 1).split(Platform.pathSeparator);
    if (parts.length != 4) {
      return null;
    }

    String filename = parts[3];
    if (filename.toLowerCase().endsWith('.png')) {
      StoreScreenshotDeviceSpec? spec = StoreScreenshotDeviceCatalog.fromFolders(
        parts[1],
        parts[2],
      );
      return _RawCapture(
        file: file,
        locale: parts[0],
        platform: parts[1],
        device: parts[2],
        name: filename.substring(0, filename.length - 4),
        width: null,
        height: null,
        outputWidth: spec?.outputWidth.toInt(),
        outputHeight: spec?.outputHeight.toInt(),
      );
    }

    RegExpMatch? match = _rgbaName.firstMatch(filename);
    if (match == null) {
      return null;
    }
    return _RawCapture(
      file: file,
      locale: parts[0],
      platform: parts[1],
      device: parts[2],
      name: match.group(1)!,
      width: int.parse(match.group(2)!),
      height: int.parse(match.group(3)!),
      outputWidth: int.parse(match.group(4)!),
      outputHeight: int.parse(match.group(5)!),
    );
  }

  /// Converts the temporary uncompressed stream to its durable clean PNG.
  Future<File> materializePng(String magick) async {
    if (!isRgba) {
      return file;
    }
    File png = File('${file.parent.path}/$name.png');
    await _run(
      magick,
      [
        '-size',
        '${width}x$height',
        '-depth',
        '8',
        'rgba:${file.path}',
        '-strip',
        '-define',
        'png:compression-level=3',
        png.path,
      ],
    );
    await file.delete();
    return png;
  }
}

/// Creates one branded canvas at the native store dimensions.
Future<void> _compose({
  required String magick,
  required File source,
  required int? outputWidth,
  required int? outputHeight,
  required File destination,
  required Directory working,
  required File logo,
  required _Caption caption,
  required _ArtworkProfile profile,
  required String platform,
  required String subtitleFont,
  required _PangoRenderer pangoRenderer,
}) async {
  (int, int) dimensions = await _imageSize(magick, source);
  int width = outputWidth ?? dimensions.$1;
  int height = outputHeight ?? dimensions.$2;
  int screenWidth = width * _ArtworkStyle.screenPercent ~/ 100;
  int screenHeight = height * _ArtworkStyle.screenPercent ~/ 100;
  int frameBorder = math.max(
    _ArtworkStyle.minimumFrameBorder,
    width * _ArtworkStyle.frameBorderPercent ~/ 100,
  );
  int frameWidth = screenWidth + frameBorder * 2;
  int frameHeight = screenHeight + frameBorder * 2;
  int screenRadius = width * _ArtworkStyle.screenRadiusPercent ~/ 100;
  int frameRadius = screenRadius + frameBorder;
  int textWidth = width * _ArtworkStyle.textWidthPercent ~/ 100;
  int badgeHeight = height * _ArtworkStyle.badgeHeightPercent ~/ 100;
  int titlePointSize = math.max(
    _ArtworkStyle.minimumTitlePointSize,
    width * _ArtworkStyle.titlePointSizePermille ~/ 1000,
  );
  int subtitlePointSize = math.max(
    _ArtworkStyle.minimumSubtitlePointSize,
    width * _ArtworkStyle.subtitlePointSizePermille ~/ 1000,
  );

  File background = File('${working.path}/background.png');
  File resized = File('${working.path}/screen.png');
  File mask = File('${working.path}/mask.png');
  File rounded = File('${working.path}/rounded.png');
  File frame = File('${working.path}/frame.png');
  File device = File('${working.path}/device.png');
  File shadowed = File('${working.path}/device-shadow.png');
  File badge = File('${working.path}/badge.png');
  File title = File('${working.path}/title.png');
  File subtitle = File('${working.path}/subtitle.png');

  await _run(
    magick,
    [
      ...brandBackgroundArguments(
        width: width,
        height: height,
        mirrorDecorations: profile.mirrorDecorations,
      ),
      background.path,
    ],
  );
  await _run(
    magick,
    [source.path, '-resize', '${screenWidth}x$screenHeight!', resized.path],
  );
  await _run(
    magick,
    [
      '-size',
      '${screenWidth}x$screenHeight',
      'xc:none',
      '-fill',
      'white',
      '-draw',
      'roundrectangle 0,0,${screenWidth - 1},${screenHeight - 1},'
          '$screenRadius,$screenRadius',
      mask.path,
    ],
  );
  await _run(
    magick,
    [
      resized.path,
      mask.path,
      '-alpha',
      'off',
      '-compose',
      'CopyOpacity',
      '-composite',
      rounded.path,
    ],
  );
  await _run(
    magick,
    [
      '-size',
      '${frameWidth}x$frameHeight',
      'xc:none',
      '-fill',
      _ArtworkStyle.deviceFrame,
      '-draw',
      'roundrectangle 0,0,${frameWidth - 1},${frameHeight - 1},'
          '$frameRadius,$frameRadius',
      frame.path,
    ],
  );
  await _run(
    magick,
    [
      frame.path,
      rounded.path,
      '-geometry',
      '+$frameBorder+$frameBorder',
      '-composite',
      if (platform == 'ios') ...[
        '-fill',
        _ArtworkStyle.camera,
        '-draw',
        'roundrectangle ${frameWidth * 40 ~/ 100},$frameBorder,'
            '${frameWidth * 60 ~/ 100},${frameBorder * 2},'
            '$frameBorder,$frameBorder',
      ] else ...[
        '-fill',
        _ArtworkStyle.camera,
        '-draw',
        'circle ${frameWidth ~/ 2},${frameBorder * 3 ~/ 2} '
            '${frameWidth ~/ 2 + frameBorder ~/ 2},${frameBorder * 3 ~/ 2}',
      ],
      device.path,
    ],
  );
  await _run(
    magick,
    [
      device.path,
      '(',
      '+clone',
      '-background',
      _ArtworkStyle.shadow,
      '-shadow',
      '55x18+0+18',
      ')',
      '+swap',
      '-background',
      'none',
      '-layers',
      'merge',
      shadowed.path,
    ],
  );
  if (profile.badge case _LogoBadge()) {
    await _run(
      magick,
      [logo.path, '-resize', 'x$badgeHeight', badge.path],
    );
  } else if (profile.badge case _EmojiBadge(:String value)) {
    await pangoRenderer.renderEmoji(
      magick: magick,
      emoji: value,
      height: badgeHeight,
      output: badge,
      working: working,
    );
  }
  await pangoRenderer.renderTitle(
    magick: magick,
    output: title,
    title: caption.title,
    width: textWidth,
    pointSize: titlePointSize,
  );
  await _renderCaption(
    magick: magick,
    output: subtitle,
    text: caption.subtitle,
    width: textWidth,
    font: subtitleFont,
    pointSize: subtitlePointSize,
    color: BrandArtworkStyle.primary,
    lineSpacing: subtitlePointSize ~/ 8,
  );
  (int, int) deviceDimensions = await _imageSize(magick, shadowed);
  (int, int) badgeDimensions = await _imageSize(magick, badge);
  int titleHeight = await _imageHeight(magick, title);
  int subtitleHeight = await _imageHeight(magick, subtitle);
  int badgeTitleGap = math.max(
    _ArtworkStyle.minimumCaptionGap,
    height * _ArtworkStyle.badgeTitleGapPercent ~/ 100,
  );
  int titleSubtitleGap = math.max(
    _ArtworkStyle.minimumCaptionGap,
    height * _ArtworkStyle.titleSubtitleGapPercent ~/ 100,
  );
  int captionHeight = badgeDimensions.$2 + badgeTitleGap + titleHeight + titleSubtitleGap + subtitleHeight;
  int deviceOverflow = height * profile.deviceOverflowPercent ~/ 100;
  int deviceTop = profile.devicePlacement == .belowCaption ? height + deviceOverflow - deviceDimensions.$2 : -deviceOverflow;
  int centeredDeviceLeft = (width - deviceDimensions.$1) ~/ 2;
  int requestedDeviceLeft = centeredDeviceLeft + width * profile.deviceHorizontalOffsetPercent ~/ 100;
  int deviceLeft = requestedDeviceLeft
      .clamp(
        0,
        math.max(0, width - deviceDimensions.$1),
      )
      .toInt();
  int captionRegionStart = profile.devicePlacement == .belowCaption ? 0 : deviceTop + deviceDimensions.$2;
  int captionRegionEnd = profile.devicePlacement == .belowCaption ? deviceTop : height;
  int captionRegionHeight = captionRegionEnd - captionRegionStart;
  if (captionHeight > captionRegionHeight) {
    throw StateError(
      'Caption does not fit around the ${profile.devicePlacement.name} device '
      'layout (${captionHeight}px > ${captionRegionHeight}px).',
    );
  }
  int captionTop = captionRegionStart + (captionRegionHeight - captionHeight) ~/ 2;
  int badgeLeft = (width - badgeDimensions.$1) ~/ 2;
  int titleLeft = (width - textWidth) ~/ 2;
  int titleTop = captionTop + badgeDimensions.$2 + badgeTitleGap;
  int subtitleTop = titleTop + titleHeight + titleSubtitleGap;

  await _run(
    magick,
    [
      background.path,
      shadowed.path,
      '-gravity',
      'northwest',
      '-geometry',
      _geometryOffset(deviceLeft, deviceTop),
      '-composite',
      badge.path,
      '-gravity',
      'northwest',
      '-geometry',
      '+$badgeLeft+$captionTop',
      '-composite',
      title.path,
      '-gravity',
      'northwest',
      '-geometry',
      '+$titleLeft+$titleTop',
      '-composite',
      subtitle.path,
      '-gravity',
      'northwest',
      '-geometry',
      '+$titleLeft+$subtitleTop',
      '-composite',
      '-strip',
      '-define',
      'png:compression-level=9',
      destination.path,
    ],
  );
}

/// Renders centered, automatically wrapped UTF-8 copy.
Future<void> _renderCaption({
  required String magick,
  required File output,
  required String text,
  required int width,
  required String font,
  required int pointSize,
  required String color,
  required int lineSpacing,
}) => _run(
  magick,
  [
    '-background',
    'none',
    '-fill',
    color,
    '-font',
    font,
    '-pointsize',
    '$pointSize',
    '-interline-spacing',
    '$lineSpacing',
    '-gravity',
    'center',
    '-size',
    '${width}x',
    'caption:$text',
    output.path,
  ],
);

/// Reads source dimensions through ImageMagick.
Future<(int, int)> _imageSize(String magick, File file) async {
  String value = await _capture(
    magick,
    ['identify', '-format', '%w %h', file.path],
  );
  List<String> dimensions = value.trim().split(' ');
  return (int.parse(dimensions[0]), int.parse(dimensions[1]));
}

/// Reads one rendered image height through ImageMagick.
Future<int> _imageHeight(String magick, File file) async => int.parse(
  (await _capture(
    magick,
    ['identify', '-format', '%h', file.path],
  )).trim(),
);

/// Formats an ImageMagick geometry offset, including negative coordinates.
String _geometryOffset(int x, int y) => '${x.isNegative ? x : '+$x'}${y.isNegative ? y : '+$y'}';

/// Loads localized copy and per-scenario visual profiles.
_ArtworkCatalog _readCatalog(File file) {
  Object? decoded = jsonDecode(file.readAsStringSync());
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('The screenshot artwork catalog is invalid.');
  }
  Object? rawProfiles = decoded['profiles'];
  Object? rawLocales = decoded['locales'];
  if (rawProfiles is! Map<String, dynamic> || rawLocales is! Map<String, dynamic>) {
    throw const FormatException(
      'The artwork catalog must contain profiles and locales.',
    );
  }
  Map<String, _ArtworkProfile> profiles = rawProfiles.map(
    (name, value) => MapEntry(
      name,
      _ArtworkProfile.fromJson(value as Map<String, dynamic>),
    ),
  );
  Map<String, Map<String, _Caption>> captions = rawLocales.map(
    (locale, entries) => MapEntry(
      locale,
      (entries as Map<String, dynamic>).map(
        (name, value) => MapEntry(
          name,
          _Caption.fromJson(value as Map<String, dynamic>),
        ),
      ),
    ),
  );
  return _ArtworkCatalog(profiles: profiles, captions: captions);
}

/// Renders rich text and the repository-local color emoji through Pango.
final class _PangoRenderer {
  /// Isolated Fontconfig environment passed to Pango commands.
  final Map<String, String> _environment;

  /// Creates a renderer backed by an isolated Fontconfig environment.
  const _PangoRenderer(this._environment);

  /// Builds an isolated Fontconfig file that adds [font] without installing it
  /// globally or copying it into the user's font directories.
  static Future<_PangoRenderer> create({
    required Directory temporary,
    required File font,
  }) async {
    if (!font.existsSync()) {
      throw StateError(
        'Missing color emoji font at ${font.path}.',
      );
    }
    String? baseConfig;
    for (String candidate in _fontConfigCandidates()) {
      if (File(candidate).existsSync()) {
        baseConfig = candidate;
        break;
      }
    }
    if (baseConfig == null) {
      throw StateError(
        'A Fontconfig base configuration is required to render color emoji.',
      );
    }
    Directory cache = Directory('${temporary.path}/font-cache');
    await cache.create(recursive: true);
    File config = File('${temporary.path}/fonts.conf');
    HtmlEscape escape = const HtmlEscape(HtmlEscapeMode.element);
    await config.writeAsString(
      '<?xml version="1.0"?>\n'
      '<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">\n'
      '<fontconfig>\n'
      '  <include ignore_missing="yes">${escape.convert(baseConfig)}</include>\n'
      '  <dir>${escape.convert(font.parent.path)}</dir>\n'
      '  <cachedir>${escape.convert(cache.path)}</cachedir>\n'
      '</fontconfig>\n',
    );
    return _PangoRenderer({'FONTCONFIG_FILE': config.path});
  }

  /// Produces one tightly-cropped, native-color emoji badge.
  Future<void> renderEmoji({
    required String magick,
    required String emoji,
    required int height,
    required File output,
    required Directory working,
  }) async {
    File source = File('${working.path}/emoji-source.png');
    await _run(
      magick,
      [
        '-background',
        'none',
        '-density',
        '${_ArtworkStyle.emojiDensity}',
        '-define',
        'pango:markup=false',
        '-font',
        _ArtworkStyle.emojiFontFamily,
        '-pointsize',
        '${_ArtworkStyle.emojiPointSize}',
        'pango:$emoji',
        source.path,
      ],
      environment: _environment,
    );
    await _run(
      magick,
      [
        source.path,
        '-trim',
        '+repage',
        '-filter',
        'Lanczos',
        '-resize',
        'x$height',
        output.path,
      ],
    );
  }

  /// Renders one title with an inline primary-colored keyword.
  Future<void> renderTitle({
    required String magick,
    required File output,
    required _Title title,
    required int width,
    required int pointSize,
  }) async {
    File source = File('${output.parent.path}/title-source.png');
    int highlightStart = title.text.indexOf(title.highlight);
    if (highlightStart < 0) {
      throw FormatException(
        'Title highlight "${title.highlight}" is missing from '
        '"${title.text}".',
      );
    }
    int highlightEnd = highlightStart + title.highlight.length;
    HtmlEscape escape = const HtmlEscape(HtmlEscapeMode.element);
    String before = escape.convert(title.text.substring(0, highlightStart));
    String highlight = escape.convert(title.highlight);
    String after = escape.convert(title.text.substring(highlightEnd));
    String markup =
        '<span font_family="${BrandArtworkStyle.titleFontFamily}" '
        'font_weight="bold" font_size="${pointSize}pt" '
        'foreground="${BrandArtworkStyle.ink}">'
        '$before<span foreground="${BrandArtworkStyle.primary}" '
        'font_weight="${_ArtworkStyle.titleHighlightWeight}">'
        '$highlight</span>$after</span>';
    await _run(
      magick,
      [
        '-background',
        'none',
        '-density',
        '${_ArtworkStyle.titleDensity}',
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
      environment: _environment,
    );
    // Pango centers lines inside its logical layout, but at 72 DPI that
    // layout occupies only part of ImageMagick's requested pixel canvas.
    // Trim the unused canvas and re-center the complete block explicitly.
    await _run(
      magick,
      [
        source.path,
        '-trim',
        '+repage',
        '-gravity',
        'center',
        '-background',
        'none',
        '-extent',
        '${width}x',
        output.path,
      ],
    );
  }

  /// Returns platform-specific Fontconfig base configuration candidates.
  static List<String> _fontConfigCandidates() => [
    ?Platform.environment['FONTCONFIG_FILE'],
    '/etc/fonts/fonts.conf',
    '/usr/local/etc/fonts/fonts.conf',
    '/opt/homebrew/etc/fonts/fonts.conf',
  ];
}

/// Resolves the bundled subtitle font, while retaining the development
/// override used to compare alternate typefaces.
String _resolveSubtitleFont(File bundledFont) {
  String? custom = Platform.environment['STOPCORN_SCREENSHOT_FONT'];
  if (custom != null && custom.trim().isNotEmpty) {
    return custom;
  }
  if (!bundledFont.existsSync()) {
    throw StateError(
      'Missing subtitle font at ${bundledFont.path}.',
    );
  }
  return bundledFont.path;
}

/// Returns the repository root from this script's stable location.
Directory _repositoryRoot() => File.fromUri(
  Platform.script,
).parent.parent.parent;

/// Verifies that a required executable is available.
Future<String> _findExecutable(String executable) async {
  try {
    ProcessResult result = await Process.run(executable, ['-version']);
    if (result.exitCode == 0) {
      return executable;
    }
  } on ProcessException {
    // Report a concise actionable error below.
  }
  throw StateError(
    'ImageMagick is required and "$executable" was not found in PATH.',
  );
}

/// Runs ImageMagick and surfaces its diagnostic output on failure.
Future<void> _run(
  String executable,
  List<String> arguments, {
  Map<String, String>? environment,
}) async {
  ProcessResult result = await Process.run(
    executable,
    arguments,
    environment: environment,
    includeParentEnvironment: true,
  );
  if (result.exitCode != 0) {
    throw ProcessException(
      executable,
      arguments,
      '${result.stderr}',
      result.exitCode,
    );
  }
}

/// Runs a command whose stdout is part of the processing protocol.
Future<String> _capture(
  String executable,
  List<String> arguments,
) async {
  ProcessResult result = await Process.run(executable, arguments);
  if (result.exitCode != 0) {
    throw ProcessException(
      executable,
      arguments,
      '${result.stderr}',
      result.exitCode,
    );
  }
  return '${result.stdout}';
}

/// Localized copy and visual decisions for the complete screenshot series.
final class _ArtworkCatalog {
  /// Visual layout profile indexed by screenshot scenario.
  final Map<String, _ArtworkProfile> profiles;

  /// Localized marketing copy indexed by locale and scenario.
  final Map<String, Map<String, _Caption>> captions;

  /// Creates the fully parsed artwork catalog.
  const _ArtworkCatalog({
    required this.profiles,
    required this.captions,
  });
}

/// Per-scenario badge, device placement and decorative variation.
final class _ArtworkProfile {
  /// Visual badge displayed alongside the marketing copy.
  final _Badge badge;

  /// Position of the device relative to the caption block.
  final _DevicePlacement devicePlacement;

  /// Share of the canvas by which the device may overflow its edge.
  final int deviceOverflowPercent;

  /// Horizontal device offset relative to the centered position.
  final int deviceHorizontalOffsetPercent;

  /// Whether the shared corner decorations are horizontally mirrored.
  final bool mirrorDecorations;

  /// Creates one validated scenario layout profile.
  const _ArtworkProfile({
    required this.badge,
    required this.devicePlacement,
    required this.deviceOverflowPercent,
    required this.deviceHorizontalOffsetPercent,
    required this.mirrorDecorations,
  });

  /// Parses and validates a scenario profile from JSON.
  factory _ArtworkProfile.fromJson(Map<String, dynamic> json) {
    Object? rawBadge = json['badge'];
    if (rawBadge is! Map<String, dynamic>) {
      throw const FormatException('An artwork profile badge is invalid.');
    }
    String placementName = json['devicePlacement'] as String;
    _DevicePlacement placement = _DevicePlacement.values.firstWhere(
      (value) => value.name == placementName,
      orElse: () => throw FormatException(
        'Unknown device placement: $placementName.',
      ),
    );
    int offset = (json['deviceHorizontalOffsetPercent'] as num).toInt();
    if (offset.abs() > _ArtworkStyle.maximumDeviceHorizontalOffsetPercent) {
      throw FormatException(
        'Device horizontal offset is too large: $offset%.',
      );
    }
    int overflow = (json['deviceOverflowPercent'] as num).toInt();
    if (overflow < 0 || overflow > _ArtworkStyle.maximumDeviceOverflowPercent) {
      throw FormatException(
        'Device overflow must be between 0 and '
        '${_ArtworkStyle.maximumDeviceOverflowPercent}%: $overflow%.',
      );
    }
    return _ArtworkProfile(
      badge: _Badge.fromJson(rawBadge),
      devicePlacement: placement,
      deviceOverflowPercent: overflow,
      deviceHorizontalOffsetPercent: offset,
      mirrorDecorations: json['mirrorDecorations'] as bool,
    );
  }
}

/// Whether the screenshot sits before or after its marketing copy.
enum _DevicePlacement {
  /// Device first, followed by the caption near the lower canvas edge.
  aboveCaption,

  /// Caption first, followed by the device near the lower canvas edge.
  belowCaption,
}

/// One visual marker displayed with a localized caption.
sealed class _Badge {
  /// Creates a badge variant.
  const _Badge();

  /// Parses a logo or emoji badge from JSON.
  factory _Badge.fromJson(Map<String, dynamic> json) {
    String kind = json['kind'] as String;
    return switch (kind) {
      'logo' => const _LogoBadge(),
      'emoji' => switch (json['value']) {
        String value when value.trim().isNotEmpty => _EmojiBadge(value),
        _ => throw const FormatException('An emoji badge needs a value.'),
      },
      _ => throw FormatException('Unknown badge kind: $kind.'),
    };
  }
}

/// StopCorn's own brand mark, reserved for selected artwork.
final class _LogoBadge extends _Badge {
  /// Creates the application logo badge.
  const _LogoBadge();
}

/// A scenario-specific Noto Color Emoji marker.
final class _EmojiBadge extends _Badge {
  /// Unicode emoji rendered by the repository-local color font.
  final String value;

  /// Creates a badge for [value].
  const _EmojiBadge(this.value);
}

/// Localized marketing copy for one scenario.
final class _Caption {
  /// Rich title containing one emphasized word.
  final _Title title;

  /// Supporting copy rendered below the title.
  final String subtitle;

  /// Creates localized marketing copy for one scenario.
  const _Caption({required this.title, required this.subtitle});

  /// Parses localized marketing copy from JSON.
  factory _Caption.fromJson(Map<String, dynamic> json) => _Caption(
    title: _Title.fromJson(json['title'] as Map<String, dynamic>),
    subtitle: json['subtitle'] as String,
  );
}

/// A title containing one inline word emphasized with the primary color.
final class _Title {
  /// Complete title text.
  final String text;

  /// Exact substring emphasized with the primary color.
  final String highlight;

  /// Creates a title and its inline highlight.
  const _Title({required this.text, required this.highlight});

  /// Parses and validates a rich title from JSON.
  factory _Title.fromJson(Map<String, dynamic> json) {
    String text = json['text'] as String;
    String highlight = json['highlight'] as String;
    if (text.trim().isEmpty || highlight.trim().isEmpty) {
      throw const FormatException(
        'Screenshot title text and highlight must not be empty.',
      );
    }
    return _Title(text: text, highlight: highlight);
  }
}

/// Centralized visual constants for every generated store image.
abstract final class _ArtworkStyle {
  /// Screenshot width relative to the store canvas.
  static const int screenPercent = 74;

  /// Device-frame border relative to the canvas width.
  static const int frameBorderPercent = 1;

  /// Minimum device-frame border in pixels.
  static const int minimumFrameBorder = 12;

  /// Screenshot corner radius relative to the canvas width.
  static const int screenRadiusPercent = 3;

  /// Marketing copy width relative to the canvas width.
  static const int textWidthPercent = 70;

  /// Badge height relative to the canvas height.
  static const int badgeHeightPercent = 4;

  /// Gap between badge and title relative to the canvas height.
  static const int badgeTitleGapPercent = 1;

  /// Gap between title and subtitle relative to the canvas height.
  static const int titleSubtitleGapPercent = 1;

  /// Minimum vertical caption gap in pixels.
  static const int minimumCaptionGap = 12;

  /// Title point size in thousandths of the canvas width.
  static const int titlePointSizePermille = 55;

  /// Minimum title point size.
  static const int minimumTitlePointSize = 58;

  /// Pango title density in dots per inch.
  static const int titleDensity = 72;

  /// Weight applied to the primary-colored title word.
  static const int titleHighlightWeight = 800;

  /// Subtitle point size in thousandths of the canvas width.
  static const int subtitlePointSizePermille = 23;

  /// Minimum subtitle point size.
  static const int minimumSubtitlePointSize = 38;

  /// Largest accepted device overflow percentage.
  static const int maximumDeviceOverflowPercent = 20;

  /// Largest accepted absolute horizontal offset percentage.
  static const int maximumDeviceHorizontalOffsetPercent = 10;

  /// Emoji rendering density in dots per inch.
  static const int emojiDensity = 144;

  /// Emoji rendering point size before final resizing.
  static const int emojiPointSize = 128;

  /// Font family supplied by the repository-local color emoji file.
  static const String emojiFontFamily = 'Noto Color Emoji';

  /// Near-black device-frame color.
  static const String deviceFrame = '#101713';

  /// Camera cutout color.
  static const String camera = '#050806';

  /// Translucent device shadow color.
  static const String shadow = '#17201970';
}
