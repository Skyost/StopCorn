import 'package:stopcorn/i18n/strings.g.dart';

/// Resolves persisted and device locales against StopCorn's supported catalog.
abstract final class AppLocaleResolver {
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
