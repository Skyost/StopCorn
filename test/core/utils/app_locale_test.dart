import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/utils/app_locale.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Runs locale resolution utility tests.
void main() {
  tearDown(() => LocaleSettings.setLocaleSync(.en));

  test('resolves only supported language codes', () {
    expect(AppLocaleResolver.fromLanguageCode('en'), AppLocale.en);
    expect(AppLocaleResolver.fromLanguageCode('fr'), AppLocale.fr);
    expect(AppLocaleResolver.fromLanguageCode('de'), isNull);
    expect(AppLocaleResolver.fromLanguageCode(null), isNull);
  });

  test('applies a valid language preference', () async {
    AppLocale locale = await AppLocaleResolver.useStoredOrDevice('fr');

    expect(locale, AppLocale.fr);
    expect(LocaleSettings.currentLocale, AppLocale.fr);
  });

  testWidgets(
    'follows a supported device language and falls back to English',
    (tester) async {
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);

      tester.platformDispatcher.localesTestValue = const [
        Locale('fr'),
      ];
      AppLocale supportedLocale = await AppLocaleResolver.useDeviceOrEnglish();
      expect(supportedLocale, AppLocale.fr);

      tester.platformDispatcher.localesTestValue = const [
        Locale('de'),
      ];
      AppLocale fallbackLocale = await AppLocaleResolver.useDeviceOrEnglish();
      expect(fallbackLocale, AppLocale.en);
    },
  );
}
