/// Abstraction over the current time for deterministic persistence and tests.
abstract interface class AppClock {
  /// Returns the current instant.
  DateTime now();
}

/// Clock backed by the device's current time.
final class SystemAppClock implements AppClock {
  /// Creates a system clock.
  const SystemAppClock();

  @override
  DateTime now() => DateTime.now();
}

/// Clock that always returns one immutable [value].
final class FixedAppClock implements AppClock {
  /// Instant returned by [now].
  final DateTime value;

  /// Creates a clock fixed at [value].
  const FixedAppClock(this.value);

  @override
  DateTime now() => value;
}
