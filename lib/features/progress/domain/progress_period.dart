import 'package:stopcorn/i18n/strings.g.dart';

/// Time windows available for progress aggregation.
enum ProgressPeriod {
  /// Rolling seven-day period.
  sevenDays('7d', 7),

  /// Rolling thirty-day period.
  thirtyDays('30d', 30),

  /// Rolling ninety-day period.
  ninetyDays('90d', 90),

  /// Complete local history.
  all('all', null);

  /// Stable value persisted in preferences.
  final String storageKey;

  /// Number of rolling days, or `null` for the full history.
  final int? dayCount;

  /// Creates a period with its stable [storageKey] and optional [dayCount].
  const ProgressPeriod(this.storageKey, this.dayCount);

  /// Localized user-facing period label.
  String get label => switch (this) {
    .sevenDays => t.period.sevenDays,
    .thirtyDays => t.period.thirtyDays,
    .ninetyDays => t.period.ninetyDays,
    .all => t.period.all,
  };

  /// Parses [value], falling back to the thirty-day period.
  static ProgressPeriod fromStorage(String value) => ProgressPeriod.values.firstWhere(
    (period) => period.storageKey == value,
    orElse: () => .thirtyDays,
  );
}
