import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/core/time/current_app_day_provider.dart';

/// Runs date-anchor refresh tests.
void main() {
  test('the current day updates after midnight', () {
    _MutableClock clock = _MutableClock(DateTime(2026, 8, 4, 23, 59));
    ProviderContainer container = ProviderContainer(
      overrides: [
        appClockProvider.overrideWithValue(clock),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(currentAppDayProvider), DateTime(2026, 8, 4));

    clock.value = DateTime(2026, 8, 5, 0, 1);
    container.read(currentAppDayProvider.notifier).refresh();

    expect(container.read(currentAppDayProvider), DateTime(2026, 8, 5));
  });
}

final class _MutableClock implements AppClock {
  DateTime value;

  _MutableClock(this.value);

  @override
  DateTime now() => value;
}
