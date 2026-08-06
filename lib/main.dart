import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopcorn/app/app.dart';
import 'package:stopcorn/app/app_resources_lifecycle.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/diagnostics/error_reporter.dart';
import 'package:stopcorn/core/diagnostics/sentry_privacy.dart';
import 'package:stopcorn/core/env/env.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/core/utils/app_locale.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';
import 'package:uuid/uuid.dart';

/// Creates the local resources and starts StopCorn.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppDatabase database = AppDatabase();
  AppPreferences preferences = AppPreferences(SharedPreferencesAsync());
  DailyCheckInNotificationGateway notificationGateway = FlutterDailyCheckInNotificationGateway(
    AppConstants.dailyCheckInNotificationId,
  );
  String? storedLocaleCode = await preferences.getLocale();
  AppLocaleResolver.registerPluralResolvers();
  await AppLocaleResolver.useStoredOrDevice(storedLocaleCode);

  bool reportingAllowed = await preferences.getErrorReportingEnabled();
  bool reportingPossible = canReportErrors();
  String environment = kReleaseMode ? 'production' : 'profile';
  ErrorReporter reporter = reportingPossible
      ? SentryErrorReporter(
          dsn: Env.sentryDsn,
          environment: environment,
          isEnabled: reportingAllowed,
        )
      : const DisabledErrorReporter();

  void start() => runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        appPreferencesProvider.overrideWithValue(preferences),
        appClockProvider.overrideWithValue(const SystemAppClock()),
        uuidProvider.overrideWithValue(const Uuid()),
        dailyCheckInNotificationGatewayProvider.overrideWithValue(
          notificationGateway,
        ),
        errorReporterProvider.overrideWithValue(reporter),
      ],
      child: AppResourcesLifecycle(
        database: database,
        preferences: preferences,
        child: const StopCornApp(),
      ),
    ),
  );

  if (!reportingPossible || !reportingAllowed) {
    start();
    return;
  }
  await SentryFlutter.init(
    (options) => configureSentryOptions(
      options,
      dsn: Env.sentryDsn,
      environment: environment,
      isReportingAllowed: () => reporter.isEnabled,
    ),
    appRunner: start,
  );
}
