import 'package:stopcorn/i18n/strings.g.dart';

/// Resolves persisted and device locales against StopCorn's supported catalog.
abstract final class AppLocaleResolver {
  /// Registers the plural rules Slang does not ship for a supported language.
  ///
  /// Portuguese has no built-in resolver, so every plural would otherwise log a
  /// warning and silently fall back. The rule below matches the fallback and the
  /// translated forms: an empty count reads as a plural, as it does in French.
  static void registerPluralResolvers() => LocaleSettings.setPluralResolverSync(
    language: 'pt',
    cardinalResolver: (count, {zero, one, two, few, many, other}) => switch (count) {
      0 => zero ?? other!,
      1 => one ?? other!,
      _ => other!,
    },
    ordinalResolver: (count, {zero, one, two, few, many, other}) => other!,
  );

  /// Returns the supported locale matching [languageCode], if any.
  static AppLocale? fromLanguageCode(String? languageCode) {
    for (AppLocale locale in AppLocale.values) {
      if (locale.languageCode == languageCode) {
        return locale;
      }
    }
    return null;
  }

  /// Applies a stored locale or falls back to the device and then English.
  static Future<AppLocale> useStoredOrDevice(String? languageCode) async {
    AppLocale? storedLocale = fromLanguageCode(languageCode);
    return storedLocale == null ? LocaleSettings.useDeviceLocale() : LocaleSettings.setLocale(storedLocale);
  }

  /// Applies the supported device locale, with English as Slang's fallback.
  static Future<AppLocale> useDeviceOrEnglish() => LocaleSettings.useDeviceLocale();
}
