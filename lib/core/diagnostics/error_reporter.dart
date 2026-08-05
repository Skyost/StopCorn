import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stopcorn/core/diagnostics/sentry_privacy.dart';
import 'package:stopcorn/core/env/env.dart';

part 'error_reporter.g.dart';

/// Boundary through which StopCorn reports a failure it could not handle.
///
/// Reporting is a support tool, never a source of truth about someone's use of
/// the application: an operation is named by a stable key such as
/// `check_in.save`, and no goal, note, journal record, or preference value is
/// ever attached to it.
abstract interface class ErrorReporter {
  /// Whether reports are currently allowed to leave the device.
  bool get isEnabled;

  /// Applies the person's [enabled] choice, taking effect immediately.
  Future<void> setEnabled(bool enabled);

  /// Reports [error] raised by [operation], without user-entered content.
  Future<void> reportError(
    Object error,
    StackTrace stackTrace, {
    required String operation,
  });
}

/// Error reporter used when reporting is impossible or deliberately absent.
///
/// Tests, debug builds, and builds without a DSN all use it, so no code path
/// has to check whether reporting exists before calling it.
final class DisabledErrorReporter implements ErrorReporter {
  /// Creates a reporter that discards everything.
  const DisabledErrorReporter();

  @override
  bool get isEnabled => false;

  @override
  Future<void> setEnabled(bool enabled) => Future<void>.value();

  @override
  Future<void> reportError(
    Object error,
    StackTrace stackTrace, {
    required String operation,
  }) => Future<void>.value();
}

/// Sends unhandled failures to Sentry while the person allows it.
///
/// The consent is read on every send instead of only at startup: turning
/// reporting off in Settings has to stop the next report, not the next launch.
final class SentryErrorReporter implements ErrorReporter {
  /// Sentry DSN this reporter sends to.
  final String dsn;

  /// Environment name attached to every event.
  final String environment;

  /// Whether the person currently allows reports to be sent.
  @override
  bool isEnabled;

  /// Whether Sentry has already been initialized in this process.
  ///
  /// A reporter starts initialized exactly when reporting was allowed at
  /// launch, since that is the only case in which `main` sets Sentry up.
  bool _initialized;

  /// Creates a reporter for the consent recorded at launch.
  SentryErrorReporter({
    required this.dsn,
    required this.environment,
    required this.isEnabled,
  }) : _initialized = isEnabled;

  @override
  Future<void> setEnabled(bool enabled) async {
    isEnabled = enabled;
    if (!enabled || _initialized) {
      return;
    }
    // Someone who declined at launch and changes their mind should not have to
    // restart the application for the choice to apply.
    await SentryFlutter.init(
      (options) => configureSentryOptions(
        options,
        dsn: dsn,
        environment: environment,
        isReportingAllowed: () => isEnabled,
      ),
    );
    _initialized = true;
  }

  @override
  Future<void> reportError(
    Object error,
    StackTrace stackTrace, {
    required String operation,
  }) async {
    if (!isEnabled || !_initialized) {
      return;
    }
    try {
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
        withScope: (scope) {
          scope.level = SentryLevel.error;
          scope.setTag('operation', operation);
        },
      );
    } catch (_) {
      // A failing report must never turn into a second failure for the person
      // already looking at an error message.
    }
  }
}

/// Reports whether this build may send anything to Sentry at all.
///
/// Debug builds and builds without a DSN never do, whatever the preference
/// says, so development runs and forks stay completely offline.
bool canReportErrors({
  String dsn = Env.sentryDsn,
  bool isDebug = kDebugMode,
}) => !isDebug && dsn.trim().isNotEmpty;

/// Exposes the process-wide error-reporting boundary injected by `main`.
@Riverpod(keepAlive: true)
ErrorReporter errorReporter(Ref ref) => const DisabledErrorReporter();

/// Convenience for reporting a failure a controller has already handled.
extension ErrorReportingRef on Ref {
  /// Reports [error] from [operation] without delaying the caller.
  ///
  /// The person already sees a localized message, so the report is a
  /// background detail: it must never add latency to the recovery path.
  void reportFailure(
    Object error,
    StackTrace stackTrace, {
    required String operation,
  }) => read(errorReporterProvider).reportError(
    error,
    stackTrace,
    operation: operation,
  );
}
