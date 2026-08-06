import 'dart:io';

/// Mirrors generated media and creates Nuxt's multi-resolution favicon.
Future<void> main() async {
  Directory repository = _repositoryRoot();
  Directory public = Directory('${repository.path}/docs/public');
  Directory output = Directory('${repository.path}/tool/website/outputs');
  List<_AssetDirectory> directories = [
    _AssetDirectory(
      source: Directory(
        '${repository.path}/tool/screenshots/outputs/store',
      ),
      destination: Directory('${public.path}/screenshots'),
    ),
    _AssetDirectory(
      source: Directory('${repository.path}/tool/social/outputs'),
      destination: Directory('${public.path}/social'),
    ),
  ];

  for (_AssetDirectory directory in directories) {
    if (!directory.source.existsSync()) {
      throw StateError(
        'Missing generated assets at ${directory.source.path}.',
      );
    }
    _validateDestination(directory.destination, public);
    int files = await _replaceDirectory(
      directory.source,
      directory.destination,
    );
    stdout.writeln(
      'Synced $files files to '
      '${directory.destination.path.substring(repository.path.length + 1)}',
    );
  }

  File favicon = File('${output.path}/favicon.ico');
  await _generateFavicon(
    logo: File('${repository.path}/assets/branding/logo.svg'),
    destination: favicon,
  );
  await public.create(recursive: true);
  File publicFavicon = await favicon.copy('${public.path}/favicon.ico');
  stdout.writeln(
    'Created ${favicon.path.substring(repository.path.length + 1)}',
  );
  stdout.writeln(
    'Synced ${publicFavicon.path.substring(repository.path.length + 1)}',
  );
}

/// Converts the application SVG into centered, transparent ICO layers.
Future<void> _generateFavicon({
  required File logo,
  required File destination,
}) async {
  if (!logo.existsSync()) {
    throw StateError('Missing application logo at ${logo.path}.');
  }
  String magick = await _findExecutable('magick');
  Directory temporary = await Directory.systemTemp.createTemp(
    'stopcorn-favicon-',
  );

  try {
    File master = File('${temporary.path}/master.png');
    int logoBox = _WebsiteArtwork.faviconMasterSize * _WebsiteArtwork.faviconLogoPercent ~/ 100;
    await _run(
      magick,
      [
        '-background',
        'none',
        logo.path,
        '-resize',
        '${logoBox}x$logoBox',
        '-gravity',
        'center',
        '-extent',
        '${_WebsiteArtwork.faviconMasterSize}x${_WebsiteArtwork.faviconMasterSize}',
        master.path,
      ],
    );

    List<File> layers = [];
    for (int size in _WebsiteArtwork.faviconSizes) {
      File layer = File('${temporary.path}/favicon-$size.png');
      await _run(
        magick,
        [master.path, '-resize', '${size}x$size', layer.path],
      );
      layers.add(layer);
    }
    await destination.parent.create(recursive: true);
    await _run(
      magick,
      [...layers.map((layer) => layer.path), destination.path],
    );
    await _validateFavicon(magick, destination);
  } finally {
    if (temporary.existsSync()) {
      await temporary.delete(recursive: true);
    }
  }
}

/// Ensures the ICO contains every configured square resolution.
Future<void> _validateFavicon(String magick, File favicon) async {
  ProcessResult result = await Process.run(
    magick,
    ['identify', '-format', '%wx%h\n', favicon.path],
  );
  if (result.exitCode != 0) {
    throw ProcessException(
      magick,
      ['identify', favicon.path],
      '${result.stderr}'.trim(),
      result.exitCode,
    );
  }
  List<String> actual = '${result.stdout}'.trim().split('\n');
  List<String> expected = _WebsiteArtwork.faviconSizes.map((size) => '${size}x$size').toList();
  if (actual.length != expected.length || !actual.asMap().entries.every((entry) => entry.value == expected[entry.key])) {
    throw StateError(
      'Unexpected favicon layers: ${actual.join(', ')}.',
    );
  }
}

/// Guards destructive replacement so it remains inside Nuxt's public tree.
void _validateDestination(Directory destination, Directory public) {
  String publicPrefix = '${public.absolute.path}${Platform.pathSeparator}';
  if (!destination.absolute.path.startsWith(publicPrefix)) {
    throw StateError(
      'Refusing to replace a directory outside ${public.absolute.path}.',
    );
  }
}

/// Replaces [destination] with [source] and returns the copied file count.
Future<int> _replaceDirectory(
  Directory source,
  Directory destination,
) async {
  if (destination.existsSync()) {
    await destination.delete(recursive: true);
  }
  await destination.create(recursive: true);
  int files = 0;

  await for (FileSystemEntity entity in source.list(recursive: true)) {
    String relativePath = entity.path.substring(source.path.length + 1);
    String targetPath = '${destination.path}/$relativePath';
    if (entity is Directory) {
      await Directory(targetPath).create(recursive: true);
    } else if (entity is File) {
      File target = File(targetPath);
      await target.parent.create(recursive: true);
      await entity.copy(target.path);
      files++;
    } else {
      throw StateError('Unsupported generated asset at ${entity.path}.');
    }
  }
  return files;
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

/// One generated source directory and its Nuxt public destination.
final class _AssetDirectory {
  /// Directory containing reproducible generated assets.
  final Directory source;

  /// Fully managed directory below `docs/public`.
  final Directory destination;

  /// Creates one source-to-destination synchronization pair.
  const _AssetDirectory({
    required this.source,
    required this.destination,
  });
}

/// Centralized favicon dimensions used by the website media pipeline.
abstract final class _WebsiteArtwork {
  /// Largest square canvas stored in the ICO file.
  static const int faviconMasterSize = 256;

  /// Share of the master canvas occupied by the unmodified application logo.
  static const int faviconLogoPercent = 75;

  /// Square resolutions embedded as individual ICO layers.
  static const List<int> faviconSizes = [16, 32, 48, 64, 128, 256];
}
