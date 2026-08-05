import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_screenshot/golden_screenshot.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/router.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';
import 'package:stopcorn/features/settings/data/debug_data_seeder.dart';
import 'package:stopcorn/features/urge/application/urge_flow_controller.dart';
import 'package:stopcorn/i18n/strings.g.dart';

import '../tool/screenshots/device_catalog.dart';
import 'helpers/fake_daily_check_in_notification_gateway.dart';
import 'helpers/test_database.dart';
import 'helpers/test_preferences.dart';

/// Screenshots are opt-in so the regular test suite does not require goldens.
const bool _generateScreenshots = bool.fromEnvironment(
  'STOPCORN_SCREENSHOTS',
);

/// Stable date anchoring every generated chart and relative label.
final DateTime _screenshotNow = DateTime.utc(2026, 7, 28, 12);

/// Half-resolution rendering keeps software-rasterized widget tests fast. The
/// store canvas only uses roughly three quarters of its width for the app, so
/// final upscaling is deliberately small while captions and mockups remain
/// native-resolution.
/// Generates the localized raw screenshots used by the store-art pipeline.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  if (!_generateScreenshots) {
    test(
      'marketing screenshots are generated explicitly',
      () {},
      skip: 'Use tool/screenshots/generate.sh.',
    );
    return;
  }

  setUpAll(() async {
    configureTestSqlite();
    await loadAppFonts(
      onlyLoadTheseFonts: const {
        'ForuiLucideIcons',
        'Inter',
        'MaterialIcons',
      },
    );
  });

  for (_ScreenshotScenario scenario in _ScreenshotScenario.values) {
    for (AppLocale locale in AppLocale.values) {
      for (_StoreDevice storeDevice in _StoreDevice.values) {
        testWidgets(
          '${scenario.fileName} ${locale.languageCode} ${storeDevice.name}',
          (tester) async {
            LocaleSettings.setLocaleSync(locale);
            _ScreenshotFixture fixture = await _ScreenshotFixture.create(
              locale,
            );
            try {
              await fixture.pump(tester, storeDevice.device);
              await fixture.open(tester, scenario);
              await tester.loadAssets(
                alsoLoadTheseFonts: const [
                  'ForuiLucideIcons',
                  'Inter',
                  'MaterialIcons',
                ],
              );
              await _settle(tester);
              await _jumpToScrollOffset(tester, scenario.scrollOffset);
              expect(find.byType(ErrorWidget), findsNothing);
              await _writeScreenshot(
                tester: tester,
                scenario: scenario,
                locale: locale,
                storeDevice: storeDevice,
              );
            } finally {
              await tester.pumpWidget(const SizedBox.shrink());
              await tester.pump();
              await fixture.dispose(tester);
            }
          },
          timeout: const Timeout(Duration(minutes: 2)),
        );
      }
    }
  }
}

/// One store screenshot and the route it highlights.
enum _ScreenshotScenario {
  home('1_home'),
  urgeSupport('2_urge_support'),
  progress('3_progress', scrollOffset: 1000),
  journal('4_journal'),
  learning('5_learning');

  /// Stable filename shared with the caption catalog.
  final String fileName;

  /// Optional logical scroll offset applied after navigation.
  final double scrollOffset;

  const _ScreenshotScenario(
    this.fileName, {
    this.scrollOffset = 0,
  });
}

/// Store-compatible devices generated for Android and iOS.
enum _StoreDevice {
  /// Android phone based on the Pixel 9 Pro.
  androidPhone(
    ScreenshotDevice(
      platform: TargetPlatform.android,
      resolution: Size(
        StoreScreenshotDeviceCatalog.androidPhoneCaptureWidth,
        StoreScreenshotDeviceCatalog.androidPhoneCaptureHeight,
      ),
      pixelRatio: 3 * StoreScreenshotDeviceCatalog.captureScale,
      goldenSubFolder: 'android/phone/',
      frameBuilder: ScreenshotFrame.androidPhone,
    ),
    StoreScreenshotDeviceCatalog.androidPhone,
  ),

  /// Android tablet with a Play Store-compatible 16:9 ratio.
  androidTablet(
    ScreenshotDevice(
      platform: TargetPlatform.android,
      resolution: Size(
        StoreScreenshotDeviceCatalog.androidTabletCaptureWidth,
        StoreScreenshotDeviceCatalog.androidTabletCaptureHeight,
      ),
      pixelRatio: 1.5 * StoreScreenshotDeviceCatalog.captureScale,
      goldenSubFolder: 'android/tablet/',
      frameBuilder: ScreenshotFrame.androidTablet,
    ),
    StoreScreenshotDeviceCatalog.androidTablet,
  ),

  /// iPhone 16 Pro Max, App Store Connect 6.9-inch display.
  iphone(
    ScreenshotDevice(
      platform: TargetPlatform.iOS,
      resolution: Size(
        StoreScreenshotDeviceCatalog.iphoneCaptureWidth,
        StoreScreenshotDeviceCatalog.iphoneCaptureHeight,
      ),
      pixelRatio: 3 * StoreScreenshotDeviceCatalog.captureScale,
      goldenSubFolder: 'ios/iphone/',
      frameBuilder: ScreenshotFrame.iphone,
    ),
    StoreScreenshotDeviceCatalog.iphone,
  ),

  /// iPad Pro 13-inch (M4).
  ipad(
    ScreenshotDevice(
      platform: TargetPlatform.iOS,
      resolution: Size(
        StoreScreenshotDeviceCatalog.ipadCaptureWidth,
        StoreScreenshotDeviceCatalog.ipadCaptureHeight,
      ),
      pixelRatio: 2 * StoreScreenshotDeviceCatalog.captureScale,
      goldenSubFolder: 'ios/ipad/',
      frameBuilder: ScreenshotFrame.ipad,
    ),
    StoreScreenshotDeviceCatalog.ipad,
  );

  /// Golden screenshot device configuration.
  final ScreenshotDevice device;

  /// Shared capture and output specification.
  final StoreScreenshotDeviceSpec spec;

  const _StoreDevice(this.device, this.spec);
}

/// Owns one deterministic screenshot database and application shell.
final class _ScreenshotFixture {
  /// In-memory application database.
  final AppDatabase database;

  /// Isolated local preferences.
  final AppPreferences preferences;

  /// Provider container wired to the screenshot dependencies.
  final ProviderContainer container;

  /// Creates a fixture around its owned resources.
  const _ScreenshotFixture({
    required this.database,
    required this.preferences,
    required this.container,
  });

  /// Seeds a coherent history localized for [locale].
  static Future<_ScreenshotFixture> create(AppLocale locale) async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    AppPreferences preferences = AppPreferences(
      createTestPreferences(
        locale: locale.languageCode,
        initialValues: {
          'onboarding_completed': true,
          'progress_period': '30d',
          'selected_strategy_ids': [
            'walk-five-minutes',
            'slow-breathing',
            'message-someone',
          ],
          'show_harvest': true,
        },
      ),
    );
    await DebugDataSeeder(database).seed(_screenshotNow);
    await _insertActiveGoal(database, locale);
    await _localizeRecentJournalEntries(database, locale);
    ProviderContainer container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(FixedAppClock(_screenshotNow)),
        dailyCheckInNotificationGatewayProvider.overrideWithValue(
          FakeDailyCheckInNotificationGateway(),
        ),
      ],
    );
    return _ScreenshotFixture(
      database: database,
      preferences: preferences,
      container: container,
    );
  }

  /// Bootstraps and renders StopCorn inside the simulated [device].
  Future<void> pump(
    WidgetTester tester,
    ScreenshotDevice device,
  ) async {
    await tester.runAsync(
      () => container.read(bootstrapControllerProvider.future),
    );
    await tester.pumpWidget(
      ScreenshotApp(
        device: device,
        frameColors: ScreenshotFrameColors.dark,
        home: UncontrolledProviderScope(
          container: container,
          child: const StopCornApp(),
        ),
      ),
    );
    await _settle(tester);
  }

  /// Navigates to the content represented by [scenario].
  Future<void> open(
    WidgetTester tester,
    _ScreenshotScenario scenario,
  ) async {
    if (scenario == .urgeSupport) {
      UrgeFlowController controller = container.read(
        urgeFlowControllerProvider.notifier,
      );
      controller
        ..setInitialIntensity(8)
        ..setTrigger(.stress)
        ..setEmotion(.anxious);
      bool started = await tester.runAsync(controller.startSession) ?? false;
      if (!started) {
        throw StateError('Unable to prepare the screenshot urge session.');
      }
    }

    String route = switch (scenario) {
      .home => AppRoutes.home,
      .urgeSupport => AppRoutes.urgeOptions,
      .progress => AppRoutes.progress,
      .journal => AppRoutes.journal,
      .learning => AppRoutes.learn,
    };
    container.read(appRouterProvider).go(route);
    await _settle(tester);
  }

  /// Releases every fixture-owned resource.
  Future<void> dispose(WidgetTester tester) async {
    container.dispose();
    await tester.pump(const Duration(milliseconds: 1));
    await preferences.dispose();
    Future<void> closing = database.close();
    await tester.pump(const Duration(milliseconds: 1));
    await tester.runAsync(() => closing);
  }

  /// Adds the active goal displayed on Home and Progress.
  static Future<void> _insertActiveGoal(
    AppDatabase database,
    AppLocale locale,
  ) => database
      .into(database.goals)
      .insert(
        GoalsCompanion.insert(
          id: 'screenshot-active-goal',
          createdAt: _screenshotNow.subtract(const Duration(days: 35)),
          updatedAt: _screenshotNow.subtract(const Duration(days: 35)),
          type: GoalType.reduction.name,
          weeklyLimit: const Value(3),
          motivation: Value(
            locale == .fr ? 'Retrouver du temps et de la sérénité.' : 'Make room for more time and peace of mind.',
          ),
          startedAt: _screenshotNow.subtract(const Duration(days: 35)),
        ),
      );

  /// Replaces debug markers with natural, localized journal examples.
  static Future<void> _localizeRecentJournalEntries(
    AppDatabase database,
    AppLocale locale,
  ) async {
    await (database.update(database.consumptionEvents)..where(
          (row) => row.id.like('debug-sample-event-%'),
        ))
        .write(
          ConsumptionEventsCompanion(
            contextLabel: Value(
              locale == .fr ? 'Un moment de pause à la maison' : 'A quiet moment at home',
            ),
            notes: const Value(null),
          ),
        );
    List<String> checkInNotes = locale == .fr
        ? [
            'J’ai pris le temps de souffler.',
            'Une journée plus calme qu’hier.',
            'J’ai mieux repéré ce qui déclenche l’envie.',
            'Davantage de présence ce soir.',
          ]
        : [
            'I took a moment to breathe.',
            'A calmer day than yesterday.',
            'I noticed what triggered the urge.',
            'I felt more present this evening.',
          ];
    List<DailyCheckIn> sampleCheckIns =
        await (database.select(
                database.dailyCheckIns,
              )
              ..where(
                (row) => row.note.like('[StopCorn debug sample]%'),
              )
              ..orderBy(
                [(row) => OrderingTerm.asc(row.localDate)],
              ))
            .get();
    for (int index = 0; index < sampleCheckIns.length; index++) {
      DailyCheckIn checkIn = sampleCheckIns[index];
      await (database.update(database.dailyCheckIns)..where(
            (row) => row.localDate.equals(checkIn.localDate),
          ))
          .write(
            DailyCheckInsCompanion(
              note: Value(checkInNotes[index % checkInNotes.length]),
            ),
          );
    }
    await (database.update(database.consumptionEvents)..where(
          (row) => row.id.equals('debug-sample-event-14'),
        ))
        .write(
          ConsumptionEventsCompanion(
            contextLabel: Value(
              locale == .fr ? 'Après une journée exigeante' : 'After a demanding day',
            ),
            notes: Value(
              locale == .fr ? 'J’ai remarqué le contexte sans me juger.' : 'I noticed the context without judging myself.',
            ),
          ),
        );
    await (database.update(database.dailyCheckIns)..where(
          (row) => row.localDate.equals('2026-07-28'),
        ))
        .write(
          DailyCheckInsCompanion(
            note: Value(
              locale == .fr ? 'Une journée plus calme, avec davantage de contrôle.' : 'A calmer day, with a stronger sense of control.',
            ),
          ),
        );
  }
}

/// Advances asynchronous providers and short UI animations.
Future<void> _settle(WidgetTester tester) async {
  for (int frame = 0; frame < 18; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Writes an uncompressed full-resolution capture for fast lossless handoff
/// to ImageMagick. Dimensions are encoded in the temporary filename so the
/// processor does not have to duplicate the device catalog.
Future<void> _writeScreenshot({
  required WidgetTester tester,
  required _ScreenshotScenario scenario,
  required AppLocale locale,
  required _StoreDevice storeDevice,
}) async {
  Element element = find.byType(MaterialApp).first.evaluate().single;
  Future<ui.Image> pendingImage = captureImage(element);
  await tester.runAsync<void>(() async {
    ui.Image image = await pendingImage;
    try {
      ByteData? data = await image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );
      if (data == null) {
        throw StateError('Unable to encode the screenshot as RGBA.');
      }

      Directory directory = Directory(
        'screenshots/raw/${locale.languageCode}/'
        '${storeDevice.spec.platformFolder}/${storeDevice.spec.deviceFolder}',
      );
      await directory.create(recursive: true);
      File output = File(
        '${directory.path}/${scenario.fileName}'
        '@${image.width}x${image.height}'
        '-to-${storeDevice.spec.outputWidth.toInt()}'
        'x${storeDevice.spec.outputHeight.toInt()}.rgba',
      );
      await output.writeAsBytes(
        data.buffer.asUint8List(
          data.offsetInBytes,
          data.lengthInBytes,
        ),
        flush: true,
      );
    } finally {
      image.dispose();
    }
  });
}

/// Jumps the active lazily-built page to [offset], when requested.
Future<void> _jumpToScrollOffset(
  WidgetTester tester,
  double offset,
) async {
  if (offset <= 0) {
    return;
  }
  Finder lists = find.byType(AppPageList);
  if (lists.evaluate().isEmpty) {
    return;
  }
  Finder scrollable = find
      .descendant(
        of: lists.last,
        matching: find.byType(Scrollable),
      )
      .first;
  ScrollableState state = tester.state<ScrollableState>(scrollable);
  state.position.jumpTo(
    math.min(offset, state.position.maxScrollExtent),
  );
  // Widgets entering the lazy viewport start their ForUI animations here.
  // Advance them before capturing so determinate bars show their final fill.
  await _settle(tester);
}
