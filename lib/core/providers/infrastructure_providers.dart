import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:uuid/uuid.dart';

part 'infrastructure_providers.g.dart';

/// Exposes the process-wide database injected by [main].
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  throw StateError('appDatabaseProvider must be overridden during startup.');
}

/// Exposes the process-wide asynchronous preferences facade.
@Riverpod(keepAlive: true)
AppPreferences appPreferences(Ref ref) {
  throw StateError('appPreferencesProvider must be overridden during startup.');
}

/// Exposes the application clock, replaceable with a fixed clock in tests.
@Riverpod(keepAlive: true)
AppClock appClock(Ref ref) => const SystemAppClock();

/// Exposes the UUID generator used for local entity identifiers.
@Riverpod(keepAlive: true)
Uuid uuid(Ref ref) => const Uuid();
