import 'package:flutter_test/flutter_test.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stopcorn/core/diagnostics/sentry_privacy.dart';

/// Runs crash-report scrubbing tests.
void main() {
  test('an event carries no identity, request, or host information', () {
    SentryEvent event = SentryEvent(
      user: SentryUser(id: 'someone', email: 'someone@example.com'),
      request: SentryRequest(url: 'https://example.com/private'),
      serverName: 'a-device',
    );

    SentryEvent scrubbed = scrubSentryEvent(event);

    expect(scrubbed.user, isNull);
    expect(scrubbed.request, isNull);
    expect(scrubbed.serverName, isNull);
  });

  test('a database failure keeps its code but never its statement', () {
    SentryEvent event = SentryEvent(
      exceptions: [
        SentryException(
          type: 'SqliteException',
          value: "SqliteException(787): FOREIGN KEY constraint failed, note: 'a private reflection'",
        ),
      ],
    );

    SentryEvent scrubbed = scrubSentryEvent(event);

    String? value = scrubbed.exceptions?.single.value;
    expect(value, '$redactedValue (787)');
    expect(value, isNot(contains('private')));
  });

  test('a failure without a code is redacted completely', () {
    SentryEvent event = SentryEvent(
      exceptions: [
        SentryException(
          type: 'DriftWrappedException',
          value: "could not write note: 'a private reflection'",
        ),
      ],
    );

    expect(scrubSentryEvent(event).exceptions?.single.value, redactedValue);
  });

  test('an application failure keeps the message it was raised with', () {
    SentryEvent event = SentryEvent(
      exceptions: [
        SentryException(
          type: 'StateError',
          value: 'Urge session was not found.',
        ),
      ],
    );

    expect(
      scrubSentryEvent(event).exceptions?.single.value,
      'Urge session was not found.',
    );
  });

  test('a navigation breadcrumb keeps its path without query parameters', () {
    Breadcrumb? breadcrumb = scrubBreadcrumb(
      Breadcrumb(
        category: 'navigation',
        data: {
          'from': '/journal',
          'to': '/log-consumption?eventId=8f1c-private-identifier',
        },
      ),
    );

    expect(breadcrumb?.data?['from'], '/journal');
    expect(breadcrumb?.data?['to'], '/log-consumption');
  });

  test('a non-string breadcrumb value is replaced instead of guessed', () {
    Breadcrumb? breadcrumb = scrubBreadcrumb(
      Breadcrumb(
        category: 'navigation',
        data: {
          'state': <String, Object?>{'note': 'a private reflection'},
        },
      ),
    );

    expect(breadcrumb?.data?['state'], redactedValue);
  });

  test('breadcrumbs attached to an event are scrubbed with it', () {
    SentryEvent event = SentryEvent(
      breadcrumbs: [
        Breadcrumb(
          category: 'navigation',
          data: {'to': '/check-in?date=2026-08-05'},
        ),
      ],
    );

    expect(
      scrubSentryEvent(event).breadcrumbs?.single.data?['to'],
      '/check-in',
    );
  });

  test('configured options drop every event once consent is withdrawn', () async {
    bool allowed = true;
    SentryFlutterOptions options = SentryFlutterOptions();
    configureSentryOptions(
      options,
      dsn: 'https://public@example.com/1',
      environment: 'test',
      isReportingAllowed: () => allowed,
    );

    expect(options.sendDefaultPii, isFalse);
    expect(options.attachScreenshot, isFalse);
    expect(options.enableAutoSessionTracking, isFalse);
    expect(options.tracesSampleRate, 0);

    SentryEvent event = SentryEvent(serverName: 'a-device');
    expect(await options.beforeSend!(event, Hint()), isNotNull);

    allowed = false;
    expect(await options.beforeSend!(event, Hint()), isNull);
  });
}
