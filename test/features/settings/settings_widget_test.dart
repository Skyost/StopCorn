import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart' show Brightness, Theme;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_switch_card.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';
import 'package:stopcorn/features/data_export/application/export_controller.dart';
import 'package:stopcorn/features/data_export/data/data_export_service.dart';
import 'package:stopcorn/features/harvest/data/harvest_repository.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';
import 'package:stopcorn/features/project_support/application/project_support_service.dart';
import 'package:stopcorn/i18n/strings.g.dart';

import '../../helpers/fake_daily_check_in_notification_gateway.dart';
import '../../helpers/test_database.dart';
import '../../helpers/test_preferences.dart';
import '../../helpers/widget_scrolling.dart';

/// Runs settings widget tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  testWidgets('the card collapses, aligns its values, and opens its actions', (
    tester,
  ) async {
    _FakeProjectSupportService projectSupport = _FakeProjectSupportService();
    _WidgetFixture fixture = await _WidgetFixture.create(
      projectSupportService: projectSupport,
    );
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    // Displaying Settings must stay local: nothing is asked of RevenueCat
    // until the person opens the paywall themselves.
    expect(projectSupport.supportStatusCheckCount, 0);
    expect(find.byKey(const Key('project_support_thanks_note')), findsNothing);

    expect(find.text('Un projet libre, pour rester accessible'), findsOneWidget);
    Finder free = find.text('Gratuit');
    Finder openSource = find.text('Open source');
    Finder noAds = find.text('Sans publicité');
    Finder noTracking = find.text('Sans traqueur');
    expect(free, findsOneWidget);
    expect(openSource, findsOneWidget);
    expect(noAds, findsOneWidget);
    expect(noTracking, findsOneWidget);
    expect(tester.getTopLeft(free).dy, closeTo(tester.getTopLeft(openSource).dy, 0.5));
    expect(tester.getTopLeft(noAds).dy, closeTo(tester.getTopLeft(noTracking).dy, 0.5));
    expect(tester.getTopLeft(free).dx, closeTo(tester.getTopLeft(noAds).dx, 0.5));
    expect(tester.getTopLeft(openSource).dx, closeTo(tester.getTopLeft(noTracking).dx, 0.5));

    Finder collapse = find.byKey(
      const Key('project_support_collapse_button'),
    );
    expect(
      tester.widget<FButton>(collapse).semanticsLabel,
      'Réduire la carte du projet',
    );
    await tester.tap(collapse);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('project_support_details')), findsNothing);
    expect(find.byKey(const Key('project_support_paywall_button')), findsNothing);
    expect(find.text('Un projet libre, pour rester accessible'), findsOneWidget);
    expect(
      tester.widget<FButton>(collapse).semanticsLabel,
      'Déployer la carte du projet',
    );
    await tester.tap(collapse);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('project_support_details')), findsOneWidget);

    Finder source = find.byKey(const Key('project_source_link_button'));
    await scrollAppPageUntilVisible(tester, source);
    await tester.tap(source);
    await _pumpFrames(tester);
    expect(projectSupport.sourceOpenCount, 1);

    Finder website = find.byKey(const Key('project_website_link_button'));
    await scrollAppPageUntilVisible(tester, website);
    await tester.tap(website);
    await _pumpFrames(tester);
    expect(projectSupport.websiteOpenCount, 1);

    Finder paywall = find.byKey(const Key('project_support_paywall_button'));
    await scrollAppPageUntilVisible(tester, paywall);
    await tester.tap(paywall);
    await _pumpFrames(tester);
    expect(projectSupport.paywallPresentationCount, 1);
    expect(
      find.text(
        'Merci ! Ton soutien aide StopCorn à rester gratuit et indépendant.',
      ),
      findsNWidgets(2),
    );
    expect(find.byKey(const Key('project_support_thanks_note')), findsOneWidget);

    // Opening the paywall is what allows later checks, so the acknowledgement
    // can be restored on the next launch without asking again.
    expect(projectSupport.supportStatusCheckCount, greaterThan(0));
    expect(
      await fixture.preferences.getProjectSupportChecksEnabled(),
      isTrue,
    );
  });

  testWidgets('privacy explains project support and opens its policy', (
    tester,
  ) async {
    _FakeProjectSupportService projectSupport = _FakeProjectSupportService();
    _WidgetFixture fixture = await _WidgetFixture.create(
      projectSupportService: projectSupport,
    );
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    Finder privacy = find.text('Confidentialité');
    await scrollAppPageUntilVisible(tester, privacy);
    await tester.tap(privacy);
    await _pumpFrames(tester);
    expect(
      find.textContaining('RevenueCat et la boutique de ton appareil'),
      findsOneWidget,
    );

    Finder policy = find.byKey(const Key('privacy_policy_link_button'));
    await tester.ensureVisible(policy);
    await tester.tap(policy);
    await _pumpFrames(tester);
    expect(projectSupport.privacyPolicyOpenCount, 1);
  });

  testWidgets('the theme can switch to dark mode', (tester) async {
    _WidgetFixture fixture = await _WidgetFixture.create();
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);
    Finder dark = find.text('Sombre');
    await scrollAppPageUntilVisible(tester, dark);
    await tester.tap(dark);
    await _waitForPersistence(tester);

    expect(await fixture.preferences.getThemeMode(), AppThemeMode.dark);
    Element context = tester.element(dark);
    expect(Theme.of(context).brightness, Brightness.dark);
  });

  testWidgets('crash reports can be turned off from settings', (tester) async {
    _WidgetFixture fixture = await _WidgetFixture.create();
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    // Reports are opt-out, so the switch starts on and the preference exists
    // only once someone changes it.
    expect(await fixture.preferences.getErrorReportingEnabled(), isTrue);

    Finder reporting = find.byKey(const Key('error_reporting_switch'));
    await scrollAppPageUntilVisible(tester, reporting);
    await tester.tap(reporting);
    await _waitForPersistence(tester);

    expect(await fixture.preferences.getErrorReportingEnabled(), isFalse);
  });

  testWidgets('optional harvest can be hidden', (tester) async {
    _WidgetFixture fixture = await _WidgetFixture.create();
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    Finder harvestSwitch = find.byKey(
      const Key('show_harvest_switch'),
    );
    await scrollAppPageUntilVisible(tester, harvestSwitch);
    await tester.tap(harvestSwitch);
    await _waitForPersistence(tester);

    expect(await fixture.preferences.getShowHarvest(), isFalse);
  });

  testWidgets('the daily reminder can be enabled from settings', (
    tester,
  ) async {
    _WidgetFixture fixture = await _WidgetFixture.create();
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    Finder reminder = find.byKey(
      const Key('daily_check_in_reminder_switch'),
    );
    await scrollAppPageUntilVisible(tester, reminder);
    await tester.tap(reminder);
    await _waitForPersistence(tester);

    expect(await fixture.preferences.getDailyCheckInReminderEnabled(), isTrue);
    expect(fixture.notificationGateway.permissionRequestCount, 1);
    expect(
      fixture.notificationGateway.scheduledRequests.single.firstOccurrence,
      DateTime(2026, 7, 28, 20),
    );
  });

  testWidgets('the support acknowledgement can be previewed in debug mode', (
    tester,
  ) async {
    _WidgetFixture fixture = await _WidgetFixture.create();
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    expect(find.byKey(const Key('project_support_thanks_note')), findsNothing);
    Finder debugSupportThanks = find.byKey(
      const Key('debug_show_support_thanks_switch'),
    );
    await scrollAppPageUntilVisible(tester, debugSupportThanks);
    await tester.tap(debugSupportThanks);
    await _waitForPersistence(tester);

    expect(await fixture.preferences.getDebugShowSupportThanks(), isTrue);
    await scrollAppPageUntilVisible(
      tester,
      find.byKey(const Key('project_support_card')),
      delta: -400,
    );
    expect(find.byKey(const Key('project_support_thanks_note')), findsOneWidget);
  });

  testWidgets('the locale can switch from French to English', (tester) async {
    _WidgetFixture fixture = await _WidgetFixture.create();
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    Finder language = find.byKey(const Key('locale_select_tile'));
    await scrollAppPageUntilVisible(tester, language);
    await tester.tap(language);
    await _pumpFrames(tester);
    Finder english = find.byKey(const Key('locale_en'));
    await tester.tap(english);
    await _waitForPersistence(tester);

    expect(await fixture.preferences.getLocale(), 'en');
    await scrollAppPageUntilVisible(tester, language, delta: -400);
    expect(LocaleSettings.currentLocale, AppLocale.en);
    expect(
      TranslationProvider.of(tester.element(language)).locale,
      AppLocale.en,
    );
    Finder languageHeader = find.text('Language');
    await scrollAppPageUntilVisible(tester, languageHeader, delta: -400);
    expect(languageHeader, findsOneWidget);
    Finder appearance = find.text('Appearance');
    await scrollAppPageUntilVisible(tester, appearance);
    expect(appearance, findsOneWidget);
    expect(find.text('Settings'), findsWidgets);
  });

  testWidgets('the default period uses a menu and can be changed', (
    tester,
  ) async {
    _WidgetFixture fixture = await _WidgetFixture.create();
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    Finder period = find.byKey(const Key('default_period_select_tile'));
    await scrollAppPageUntilVisible(tester, period);
    await tester.tap(period);
    await _pumpFrames(tester);
    await tester.tap(find.byKey(const Key('period_7d')));
    await _waitForPersistence(tester);

    expect(await fixture.preferences.getProgressPeriod(), '7d');
  });

  testWidgets('sample data can be loaded in debug mode', (
    tester,
  ) async {
    _WidgetFixture fixture = await _WidgetFixture.create();
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    Finder loadSamples = find.byKey(
      const Key('load_sample_data_tile'),
    );
    await scrollAppPageUntilVisible(tester, loadSamples);
    await tester.tap(loadSamples);
    await _waitForPersistence(tester);

    expect(
      find.text(
        "Données d'exemple chargées. Tu peux les recharger à tout moment.",
      ),
      findsOneWidget,
    );
    expect(
      await fixture.database.select(fixture.database.consumptionEvents).get(),
      hasLength(15),
    );
    expect(
      await fixture.database.select(fixture.database.urgeSessions).get(),
      hasLength(12),
    );
    expect(
      await fixture.database.select(fixture.database.dailyCheckIns).get(),
      hasLength(12),
    );

    await tester.tap(loadSamples);
    await _waitForPersistence(tester);
    expect(
      await fixture.database.select(fixture.database.consumptionEvents).get(),
      hasLength(15),
    );
  });

  testWidgets(
    'a development Corn point can be added multiple times',
    (tester) async {
      _WidgetFixture fixture = await _WidgetFixture.create();
      addTearDown(fixture.dispose);
      DateTime now = DateTime.utc(2026, 7, 28, 12);
      await fixture.database
          .into(fixture.database.goals)
          .insert(
            GoalsCompanion.insert(
              id: 'goal-today',
              createdAt: now,
              updatedAt: now,
              type: 'observation',
              startedAt: now,
            ),
          );
      await fixture.pump(tester);
      await _openSettings(tester);

      Finder grantPoint = find.byKey(
        const Key('grant_debug_corn_point_tile'),
      );
      await scrollAppPageUntilVisible(tester, grantPoint);
      await tester.tap(grantPoint);
      await _waitForPersistence(tester);

      expect(find.text('Corn point récolté !'), findsOneWidget);
      expect(
        tester
            .widget<Text>(
              find.byKey(const Key('harvest_reward_points_value')),
            )
            .data,
        '2',
      );
      expect(
        find.byKey(const Key('harvest_reward_momentum_value')),
        findsNothing,
      );
      await tester.tap(
        find.byKey(const Key('harvest_reward_close_button')),
      );
      await tester.pumpAndSettle();

      await scrollAppPageUntilVisible(tester, grantPoint);
      await tester.tap(grantPoint);
      await _waitForPersistence(tester);

      expect(
        tester
            .widget<Text>(
              find.byKey(const Key('harvest_reward_points_value')),
            )
            .data,
        '3',
      );
      expect(await fixture.preferences.getDebugHarvestBonusPoints(), 2);
      HarvestSummary summary = await fixture.container.read(harvestRepositoryProvider).loadSummary(now);
      expect(summary.grainCount, 3);
      expect(summary.currentMomentum, 1);
    },
  );

  testWidgets('export requires explicit confirmation', (tester) async {
    File? shared;
    _WidgetFixture fixture = await _WidgetFixture.create(
      onShare: (file) async => shared = file,
    );
    addTearDown(fixture.dispose);
    await fixture.pump(tester);
    await _openSettings(tester);

    Finder export = find.text('Exporter mes données');
    await scrollAppPageUntilVisible(tester, export);
    await tester.tap(export);
    await _pumpFrames(tester);
    expect(find.text('Avant de continuer'), findsOneWidget);

    await tester.tap(find.byKey(const Key('export_confirmation_switch')));
    await _pumpFrames(tester);
    expect(
      fixture.container.read(exportControllerProvider).isConfirmed,
      isTrue,
    );
    Finder create = find.byKey(const Key('create_export_button'));
    await tester.ensureVisible(create);
    VoidCallback? startExport = tester.widget<AppButton>(create).onPress;
    expect(startExport, isNotNull);
    await _runExport(tester, fixture.container, startExport!);

    expect(shared, isNotNull);
    expect(shared!.path, endsWith('stopcorn-widget-export.json'));
    expect(
      fixture.container.read(exportControllerProvider).shareOpened,
      isTrue,
    );
  });

  testWidgets('complete deletion returns to onboarding', (tester) async {
    tester.platformDispatcher.localesTestValue = const [
      Locale('fr'),
    ];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    _WidgetFixture fixture = await _WidgetFixture.create();
    addTearDown(fixture.dispose);
    DateTime now = DateTime.utc(2026, 7, 28, 12);
    await fixture.database
        .into(fixture.database.consumptionEvents)
        .insert(
          ConsumptionEventsCompanion.insert(
            id: 'event-to-delete',
            occurredAt: now,
            createdAt: now,
          ),
        );
    await fixture.preferences.setDebugHarvestBonusPoints(2);
    await fixture.pump(tester);
    await _openSettings(tester);
    int cancellationCount = fixture.notificationGateway.cancellationCount;

    Finder delete = find.byKey(const Key('delete_all_data_tile'));
    await scrollAppPageUntilVisible(tester, delete);
    expect(
      tester.widget<FTile>(delete).variant,
      FItemVariant.destructive,
    );
    await tester.tap(delete);
    await _pumpFrames(tester);
    await tester.tap(find.text('Continuer'));
    await _pumpFrames(tester);

    Finder destructiveSwitch = find.byKey(
      const Key('final_delete_confirmation_switch'),
    );
    Finder switchCard = find.ancestor(
      of: destructiveSwitch,
      matching: find.byType(AppSwitchCard),
    );
    expect(tester.widget<AppSwitchCard>(switchCard).destructive, isTrue);
    Element switchContext = tester.element(destructiveSwitch);
    FSwitch switchWidget = tester.widget(destructiveSwitch);
    FSwitchStyle switchStyle = switchWidget.style(
      switchContext.theme.switchStyle,
    );
    FColors colors = switchContext.theme.colors;
    expect(switchStyle.focusColor, colors.destructive);
    expect(
      switchStyle.trackColor.resolve({FSwitchVariant.selected}),
      colors.destructive,
    );
    expect(
      switchStyle.trackColor.resolve({
        FSwitchVariant.selected,
        FSwitchVariant.disabled,
      }),
      colors.disable(colors.destructive),
    );
    await tester.tap(destructiveSwitch);
    await tester.pump();
    await tester.tap(find.byKey(const Key('final_delete_button')));
    await _waitForPersistence(tester);
    await _pumpFrames(tester);

    expect(find.text('Reprendre le contrôle, sans jugement'), findsOneWidget);
    expect(
      await fixture.database.select(fixture.database.consumptionEvents).get(),
      isEmpty,
    );
    expect(
      await fixture.database.select(fixture.database.copingStrategies).get(),
      hasLength(9),
    );
    expect(await fixture.preferences.getOnboardingCompleted(), isFalse);
    expect(await fixture.preferences.getLocale(), isNull);
    expect(await fixture.preferences.getDailyCheckInReminderEnabled(), isFalse);
    expect(await fixture.preferences.getDebugHarvestBonusPoints(), 0);
    expect(
      fixture.notificationGateway.cancellationCount,
      greaterThan(cancellationCount),
    );
    expect(LocaleSettings.currentLocale, AppLocale.fr);
  });
}

/// Opens the settings destination and waits for it to settle.
Future<void> _openSettings(WidgetTester tester) async {
  await tester.tap(find.text('Réglages'));
  await _pumpFrames(tester);
  expect(find.byKey(const Key('project_support_card')), findsOneWidget);
}

/// Waits for local persistence and then settles the widget tree.
Future<void> _waitForPersistence(WidgetTester tester) async {
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 100)),
  );
  await _pumpFrames(tester);
}

/// Starts an export and waits until its provider reports completion.
Future<void> _runExport(
  WidgetTester tester,
  ProviderContainer container,
  VoidCallback startExport,
) async {
  await tester.runAsync(() async {
    startExport();
    for (int attempt = 0; attempt < 100; attempt++) {
      if (!container.read(exportControllerProvider).isExporting) {
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
    throw StateError('The test export did not complete in time.');
  });
  await _pumpFrames(tester);
}

/// Advances enough frames for asynchronous test UI to settle.
Future<void> _pumpFrames(WidgetTester tester) async {
  for (int frame = 0; frame < 14; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Owns the dependencies and application shell used by settings widget tests.
final class _WidgetFixture {
  /// In-memory application database.
  final AppDatabase database;

  /// Isolated preferences store.
  final AppPreferences preferences;

  /// Provider container wired to the test dependencies.
  final ProviderContainer container;

  /// Local-notification boundary used by the rendered application.
  final FakeDailyCheckInNotificationGateway notificationGateway;

  /// Creates a fixture that owns [database], [preferences], and [container].
  const _WidgetFixture({
    required this.database,
    required this.preferences,
    required this.container,
    required this.notificationGateway,
  });

  /// Creates an isolated fixture with an optional export sharing callback.
  static Future<_WidgetFixture> create({
    Future<void> Function(File file)? onShare,
    ProjectSupportService? projectSupportService,
  }) async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        initialValues: {'onboarding_completed': true},
      ),
    );
    FixedAppClock clock = FixedAppClock(DateTime.utc(2026, 7, 28, 12));
    FakeDailyCheckInNotificationGateway notificationGateway = FakeDailyCheckInNotificationGateway();
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(clock),
        dailyCheckInNotificationGatewayProvider.overrideWithValue(
          notificationGateway,
        ),
        if (projectSupportService != null) projectSupportServiceProvider.overrideWithValue(projectSupportService),
        dataExportServiceProvider.overrideWithValue(
          _FakeDataExportService(
            database,
            preferences,
            clock,
            onShare ?? (_) async {},
          ),
        ),
      ],
    );
    return _WidgetFixture(
      database: database,
      preferences: preferences,
      container: container,
      notificationGateway: notificationGateway,
    );
  }

  /// Bootstraps and renders the application under test.
  Future<void> pump(WidgetTester tester) async {
    await tester.runAsync(
      () => container.read(bootstrapControllerProvider.future),
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const StopCornApp(),
      ),
    );
    await _pumpFrames(tester);
  }

  /// Releases every dependency owned by this fixture.
  Future<void> dispose() async {
    container.dispose();
    await preferences.dispose();
    await database.close();
  }
}

/// Project-support double that records each explicit user action.
final class _FakeProjectSupportService implements ProjectSupportService {
  /// Number of source-code link openings.
  int sourceOpenCount = 0;

  /// Number of website link openings.
  int websiteOpenCount = 0;

  /// Number of paywall presentations.
  int paywallPresentationCount = 0;

  /// Number of privacy-policy link openings.
  int privacyPolicyOpenCount = 0;

  /// Whether the fake customer has already supported the project.
  bool hasSupportedProject = false;

  /// Number of supporter-status checks, which each reach the network.
  int supportStatusCheckCount = 0;

  @override
  Future<bool> openSourceCode() async {
    sourceOpenCount++;
    return true;
  }

  @override
  Future<bool> openWebsite() async {
    websiteOpenCount++;
    return true;
  }

  @override
  Future<bool> openPrivacyPolicy() async {
    privacyPolicyOpenCount++;
    return true;
  }

  @override
  Future<ProjectSupportPaywallResult> presentPaywall() async {
    paywallPresentationCount++;
    hasSupportedProject = true;
    return .purchased;
  }

  @override
  Future<bool> hasSupported() async {
    supportStatusCheckCount++;
    return hasSupportedProject;
  }
}

/// Export service double that routes sharing through a test callback.
final class _FakeDataExportService extends DataExportService {
  /// Callback invoked with the generated export file.
  final Future<void> Function(File file) _onShare;

  /// Creates an export double backed by the supplied local dependencies.
  _FakeDataExportService(
    AppDatabase database,
    AppPreferences preferences,
    AppClock clock,
    this._onShare,
  ) : super(
        database,
        preferences,
        clock,
        () => throw UnsupportedError('Not used in this test.'),
        (file) => throw UnsupportedError('Not used in this test.'),
      );

  @override
  Future<File> createAndShareExport() async {
    File file = File('/tmp/stopcorn-widget-export.json');
    await _onShare(file);
    return file;
  }

  @override
  Future<void> purgeExports({bool bestEffort = true}) async {}
}
