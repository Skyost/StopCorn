import 'package:sentry_flutter/sentry_flutter.dart';

/// Replacement written over any value that could carry personal content.
const String redactedValue = '[redacted]';

/// Exception types whose message may embed the values StopCorn stores.
///
/// A failed statement can name the parameters it tried to write, and those
/// parameters are journal notes, contexts, and reflections. The type and the
/// database error code are enough to investigate a crash, so the message
/// itself never leaves the device.
const Set<String> _databaseExceptionTypes = {
  'SqliteException',
  'DriftWrappedException',
  'CouldNotRollBackException',
};

/// Breadcrumb categories that describe navigation between StopCorn screens.
const Set<String> _navigationCategories = {'navigation'};

/// Applies the privacy rules StopCorn commits to on [options].
///
/// Everything that could carry what someone wrote is turned off rather than
/// filtered afterwards: no screenshots, no personal information, no widget
/// interactions, and no session or performance data. What remains is the crash
/// itself, which is what the report exists for.
///
/// [isReportingAllowed] is consulted on every event instead of only here, so
/// withdrawing consent in Settings stops the next report immediately.
void configureSentryOptions(
  SentryFlutterOptions options, {
  required String dsn,
  required String environment,
  required bool Function() isReportingAllowed,
}) {
  options
    ..dsn = dsn
    ..environment = environment
    ..sendDefaultPii = false
    ..attachScreenshot = false
    ..enableAutoSessionTracking = false
    ..enableUserInteractionBreadcrumbs = false
    ..tracesSampleRate = 0;
  // Assigned outside the cascade: an arrow body would swallow the following
  // cascade sections into the callback itself.
  options.beforeBreadcrumb = (breadcrumb, hint) => scrubBreadcrumb(breadcrumb);
  options.beforeSend = (event, hint) => isReportingAllowed() ? scrubSentryEvent(event) : null;
}

/// Removes identifying and free-text content from [event] before it is sent.
///
/// Returning the event unchanged would be enough for Sentry, so the scrubbing
/// happens here to keep one readable place where the guarantee is expressed.
SentryEvent scrubSentryEvent(SentryEvent event) {
  event
    ..user = null
    ..request = null
    ..serverName = null
    ..breadcrumbs = event.breadcrumbs?.map(scrubBreadcrumb).whereType<Breadcrumb>().toList();
  List<SentryException>? exceptions = event.exceptions;
  if (exceptions != null) {
    for (SentryException exception in exceptions) {
      if (_isDatabaseException(exception.type)) {
        exception.value = _databaseErrorSummary(exception.value);
      }
    }
  }
  return event;
}

/// Keeps a breadcrumb only in a form that cannot carry recorded content.
///
/// Navigation breadcrumbs are useful to know where a crash happened, but a
/// StopCorn location can carry the identifier of an event or the date of a
/// check-in in its query string, so only the path is kept.
Breadcrumb? scrubBreadcrumb(Breadcrumb? breadcrumb) {
  if (breadcrumb == null) {
    return null;
  }
  if (!_navigationCategories.contains(breadcrumb.category)) {
    return breadcrumb;
  }
  Map<String, dynamic>? data = breadcrumb.data;
  if (data == null) {
    return breadcrumb;
  }
  breadcrumb.data = {
    for (final MapEntry<String, dynamic> entry in data.entries) entry.key: entry.value is String ? _pathOnly(entry.value as String) : redactedValue,
  };
  return breadcrumb;
}

/// Reports whether [type] names an exception that can quote stored values.
bool _isDatabaseException(String? type) => type != null && _databaseExceptionTypes.any(type.contains);

/// Keeps the database error code, if any, and drops the rest of the message.
String _databaseErrorSummary(String? value) {
  if (value == null) {
    return redactedValue;
  }
  RegExpMatch? code = RegExp(r'\((\d+)\)').firstMatch(value);
  return code == null ? redactedValue : '$redactedValue (${code.group(1)})';
}

/// Returns the location path of [value], dropping any query parameters.
String _pathOnly(String value) {
  int separator = value.indexOf('?');
  return separator == -1 ? value : value.substring(0, separator);
}
