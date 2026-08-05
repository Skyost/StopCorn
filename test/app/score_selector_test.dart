import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/theme/app_theme.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/score_selector.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Runs optional and required score selector tests.
void main() {
  tearDown(() => LocaleSettings.setLocaleSync(.en));

  testWidgets('an unanswered optional score displays no value', (
    tester,
  ) async {
    await _pump(
      tester,
      ScoreSelector(
        label: 'Sommeil',
        value: null,
        onChanged: (_) {},
        onCleared: () {},
      ),
    );

    expect(find.text(t.app.score.unanswered), findsOneWidget);
    expect(find.text(t.app.score.outOfTen(value: '5')), findsNothing);
    // Nothing to clear before the person answers.
    expect(find.byType(AppButton), findsNothing);
  });

  testWidgets('an answered optional score is displayed and can be cleared', (
    tester,
  ) async {
    int? current = 7;
    await _pump(
      tester,
      StatefulBuilder(
        builder: (context, setState) => ScoreSelector(
          label: 'Sommeil',
          value: current,
          onChanged: (value) => setState(() => current = value),
          onCleared: () => setState(() => current = null),
        ),
      ),
    );

    expect(find.text(t.app.score.outOfTen(value: '7')), findsOneWidget);
    expect(find.text(t.app.score.unanswered), findsNothing);

    await tester.tap(find.byType(AppButton));
    await tester.pumpAndSettle();

    expect(current, isNull);
    expect(find.text(t.app.score.unanswered), findsOneWidget);
  });

  testWidgets('a required score does not offer a clear action', (tester) async {
    await _pump(
      tester,
      ScoreSelector(
        label: 'Humeur',
        value: 4,
        onChanged: (_) {},
      ),
    );

    expect(find.text(t.app.score.outOfTen(value: '4')), findsOneWidget);
    expect(find.byType(AppButton), findsNothing);
  });

  testWidgets('the value follows the active locale', (tester) async {
    LocaleSettings.setLocaleSync(.fr);
    await _pump(
      tester,
      ScoreSelector(
        label: 'Sommeil',
        value: null,
        onChanged: (_) {},
        onCleared: () {},
      ),
    );

    // Compared through the key so rewording the copy does not break the test.
    expect(find.text(t.app.score.unanswered), findsOneWidget);
    expect(LocaleSettings.currentLocale, AppLocale.fr);
  });
}

/// Pumps [child] inside the theme and translations the widget expects.
Future<void> _pump(WidgetTester tester, Widget child) => tester.pumpWidget(
  TranslationProvider(
    child: Builder(
      builder: (context) => MaterialApp(
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: FLocalizations.localizationsDelegates,
        home: FTheme(
          data: appTheme.light.touch,
          child: Scaffold(body: child),
        ),
      ),
    ),
  ),
);
