import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'licenses_provider.g.dart';

/// All distinct license notices registered for one package.
final class OpenSourceLicense {
  /// Package covered by [text], or an empty string when unnamed.
  final String package;

  /// Full license text exposed by Flutter's license registry.
  final String text;

  /// Creates an immutable open-source license entry.
  const OpenSourceLicense({
    required this.package,
    required this.text,
  });

  /// Localized or package-derived title shown in the license list.
  String get title => package.isEmpty ? t.licenses.otherComponent : package;
}

/// Collects and sorts licenses registered by Flutter dependencies.
@riverpod
Future<List<OpenSourceLicense>> openSourceLicenses(Ref ref) async {
  List<LicenseEntry> entries = [];
  await for (LicenseEntry entry in LicenseRegistry.licenses) {
    entries.add(entry);
  }
  return groupOpenSourceLicenses(entries);
}

/// Groups [entries] into one sorted row per package and removes duplicate text.
List<OpenSourceLicense> groupOpenSourceLicenses(
  Iterable<LicenseEntry> entries,
) {
  Map<String, Set<String>> textsByPackage = {};
  for (LicenseEntry entry in entries) {
    String text = entry.paragraphs
        .map((paragraph) => paragraph.text)
        .join(
          '\n\n',
        );
    Iterable<String> packages = entry.packages.isEmpty ? const [''] : entry.packages;
    for (String package in packages) {
      (textsByPackage[package] ??= {}).add(text);
    }
  }
  List<OpenSourceLicense> licenses = [
    for (MapEntry<String, Set<String>> item in textsByPackage.entries)
      OpenSourceLicense(
        package: item.key,
        text: item.value.join('\n\n––––––––––––––––––––\n\n'),
      ),
  ];
  licenses.sort((first, second) => first.title.compareTo(second.title));
  return List<OpenSourceLicense>.unmodifiable(licenses);
}
