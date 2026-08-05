import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/features/settings/application/licenses_provider.dart';

/// Runs open-source license grouping tests.
void main() {
  test('groups notices by package and deduplicates their text', () {
    List<LicenseEntry> entries = [
      const LicenseEntryWithLineBreaks(['angle'], 'Licence A'),
      const LicenseEntryWithLineBreaks(['angle'], 'Licence A'),
      const LicenseEntryWithLineBreaks(['angle'], 'Licence B'),
      const LicenseEntryWithLineBreaks(['another'], 'Licence C'),
    ];

    List<OpenSourceLicense> licenses = groupOpenSourceLicenses(entries);

    expect(licenses.map((license) => license.title), ['angle', 'another']);
    OpenSourceLicense angle = licenses.first;
    expect('Licence A'.allMatches(angle.text), hasLength(1));
    expect('Licence B'.allMatches(angle.text), hasLength(1));
  });
}
