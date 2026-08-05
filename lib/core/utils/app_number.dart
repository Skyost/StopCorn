import 'package:intl/intl.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Formats [value] as a whole number in the active locale.
String formatCount(num value) => NumberFormat.decimalPattern(
  LocaleSettings.currentLocale.languageCode,
).format(value);

/// Formats [value] with one decimal in the active locale.
///
/// French writes `3,5` where English writes `3.5`, so scores and averages must
/// never be rendered with [num.toStringAsFixed].
String formatDecimal(num value) =>
    (NumberFormat.decimalPattern(
            LocaleSettings.currentLocale.languageCode,
          )
          ..minimumFractionDigits = 1
          ..maximumFractionDigits = 1)
        .format(value);

/// Formats [value] with one decimal, dropping a redundant trailing zero.
String formatCompactDecimal(num value) => value == value.roundToDouble() ? formatCount(value.round()) : formatDecimal(value);

/// Formats [value] with an explicit sign, used for perceived-effect scores.
///
/// A negative sign already comes from the locale, so only a gain needs one.
String formatSignedDecimal(num value) {
  String formatted = formatDecimal(value);
  return value > 0 ? '+$formatted' : formatted;
}

/// Formats [value] with an explicit sign and no decimal.
String formatSignedCount(num value) {
  String formatted = formatCount(value);
  return value > 0 ? '+$formatted' : formatted;
}
