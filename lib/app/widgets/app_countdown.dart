import 'dart:async';

import 'package:flutter/widgets.dart';

/// Builds countdown content from the latest immutable [value].
typedef AppCountdownBuilder =
    Widget Function(
      BuildContext context,
      AppCountdownValue value,
    );

/// Returns the current instant used to synchronize a countdown.
typedef AppCountdownNow = DateTime Function();

/// Immutable elapsed and remaining values for an [AppCountdown].
final class AppCountdownValue {
  /// Number of completed seconds, clamped to the configured duration.
  final int elapsedSeconds;

  /// Number of seconds remaining before the indicative duration ends.
  final int remainingSeconds;

  /// Progress from zero to one.
  final double progress;

  /// Creates one synchronized countdown snapshot.
  const AppCountdownValue({
    required this.elapsedSeconds,
    required this.remainingSeconds,
    required this.progress,
  });

  /// Whether the configured duration has elapsed.
  bool get isComplete => remainingSeconds == 0;
}

/// Rebuilds [builder] once per second from a stable start timestamp.
final class AppCountdown extends StatefulWidget {
  /// Instant from which elapsed time is calculated.
  final DateTime startedAt;

  /// Positive duration of the countdown in seconds.
  final int totalSeconds;

  /// Testable source of the current instant.
  final AppCountdownNow now;

  /// Content rebuilt with each synchronized countdown value.
  final AppCountdownBuilder builder;

  /// Creates a countdown synchronized with [startedAt].
  const AppCountdown({
    super.key,
    required this.startedAt,
    required this.totalSeconds,
    required this.now,
    required this.builder,
  }) : assert(totalSeconds > 0);

  @override
  State<AppCountdown> createState() => _AppCountdownState();
}

/// Owns the periodic refresh used by [AppCountdown].
final class _AppCountdownState extends State<AppCountdown> {
  /// Periodic timer refreshing the visible countdown.
  Timer? _timer;

  /// Most recent value supplied to the widget builder.
  late AppCountdownValue _value;

  @override
  void initState() {
    super.initState();
    _value = _calculateValue();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant AppCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.startedAt == widget.startedAt && oldWidget.totalSeconds == widget.totalSeconds) {
      return;
    }
    _timer?.cancel();
    _value = _calculateValue();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _value);

  /// Starts periodic synchronization until the countdown completes.
  void _startTimer() {
    if (_value.isComplete) {
      return;
    }
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _update(),
    );
  }

  /// Refreshes the countdown from the current clock value.
  void _update() {
    AppCountdownValue next = _calculateValue();
    if (next.elapsedSeconds != _value.elapsedSeconds) {
      setState(() => _value = next);
    }
    if (next.isComplete) {
      _timer?.cancel();
    }
  }

  /// Calculates a value resilient to clock drift and application suspension.
  AppCountdownValue _calculateValue() {
    int elapsedSeconds = widget.now().difference(widget.startedAt).inSeconds.clamp(0, widget.totalSeconds);
    int remainingSeconds = widget.totalSeconds - elapsedSeconds;
    return AppCountdownValue(
      elapsedSeconds: elapsedSeconds,
      remainingSeconds: remainingSeconds,
      progress: elapsedSeconds / widget.totalSeconds,
    );
  }
}
