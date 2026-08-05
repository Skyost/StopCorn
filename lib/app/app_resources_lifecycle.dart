import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/router.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/time/current_app_day_provider.dart';
import 'package:stopcorn/features/check_in/application/daily_check_in_reminder_service.dart';
import 'package:stopcorn/features/check_in/data/daily_check_in_notification_gateway.dart';
import 'package:stopcorn/features/data_export/data/data_export_service.dart';

/// Owns and releases the application-wide persistent resources.
final class AppResourcesLifecycle extends ConsumerStatefulWidget {
  /// The database closed when this widget leaves the tree.
  final AppDatabase database;

  /// The preferences store closed when this widget leaves the tree.
  final AppPreferences preferences;

  /// The application rendered inside this resource boundary.
  final Widget child;

  /// Creates the lifecycle boundary for [database] and [preferences].
  const AppResourcesLifecycle({
    super.key,
    required this.database,
    required this.preferences,
    required this.child,
  });

  @override
  ConsumerState<AppResourcesLifecycle> createState() => _AppResourcesLifecycleState();
}

/// Releases resources and refreshes date-based views owned by its widget.
final class _AppResourcesLifecycleState extends ConsumerState<AppResourcesLifecycle> with WidgetsBindingObserver {
  Timer? _midnightTimer;

  /// Subscription to reminder taps, cancelled with this widget.
  StreamSubscription<void>? _reminderOpened;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scheduleMidnightRefresh();
    _listenToReminder();
    // An unencrypted export must not survive in the cache, but clearing it is
    // never worth delaying the first screen for.
    ref.read(dataExportServiceProvider).purgeExports();
  }

  /// Opens the check-in when the person acts on the evening reminder.
  ///
  /// The reminder exists to bring someone back to the check-in, so landing on
  /// the home screen instead would make them look for it again.
  void _listenToReminder() {
    DailyCheckInNotificationGateway gateway = ref.read(
      dailyCheckInNotificationGatewayProvider,
    );
    _reminderOpened = gateway.opened.listen((_) => _openCheckIn());
    gateway.launchedFromReminder().then((launched) {
      if (launched) {
        _openCheckIn();
      }
    });
  }

  /// Navigates to the check-in once the router is ready.
  void _openCheckIn() {
    if (!mounted) {
      return;
    }
    ref.read(appRouterProvider).go(AppRoutes.checkIn);
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshCurrentDay();
    }
  }

  /// Refreshes the current day.
  void _refreshCurrentDay() {
    ref.read(currentAppDayProvider.notifier).refresh();
    _scheduleMidnightRefresh();
    ref.read(dailyCheckInReminderServiceProvider).synchronize();
  }

  /// Schedules a midnight refresh.
  void _scheduleMidnightRefresh() {
    _midnightTimer?.cancel();
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);
    _midnightTimer = Timer(nextMidnight.difference(now), _refreshCurrentDay);
  }

  @override
  void dispose() {
    _midnightTimer?.cancel();
    _reminderOpened?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    widget.preferences.dispose();
    widget.database.close();
    super.dispose();
  }
}
