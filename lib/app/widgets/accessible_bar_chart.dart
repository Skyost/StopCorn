import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/utils/app_number.dart';

/// One labeled numeric value displayed by [AccessibleBarChart].
final class AccessibleBarDatum {
  /// Category announced by assistive technologies and shown above the bar.
  final String label;

  /// Non-negative magnitude represented by the progress fill.
  final double value;

  /// Optional formatted value, such as a percentage or duration.
  final String? valueLabel;

  /// Creates a chart value with an optional human-readable [valueLabel].
  const AccessibleBarDatum({
    required this.label,
    required this.value,
    this.valueLabel,
  });
}

/// Renders a compact bar chart with an equivalent semantic text summary.
final class AccessibleBarChart extends StatelessWidget {
  /// Values to render in their supplied order.
  final List<AccessibleBarDatum> data;

  /// Message shown when no category is available for display.
  final String emptyMessage;

  /// Whether zero-valued categories remain visible for direct comparisons.
  final bool showZeroValues;

  /// The maximum value in the chart.
  final double? maximum;

  /// Creates a chart that displays [emptyMessage] when no category is visible.
  const AccessibleBarChart({
    super.key,
    required this.data,
    required this.emptyMessage,
    this.showZeroValues = false,
    this.maximum,
  });

  @override
  Widget build(BuildContext context) {
    List<AccessibleBarDatum> visible = showZeroValues ? data : data.where((datum) => datum.value > 0).toList();
    if (visible.isEmpty) {
      return Text(
        emptyMessage,
        style: context.theme.typography.body.sm.copyWith(
          color: context.theme.colors.mutedForeground,
        ),
      );
    }
    double maximum = this.maximum ?? visible.map((datum) => datum.value).reduce((first, second) => first > second ? first : second).clamp(1, double.infinity).toDouble();
    String alternative = visible
        .map(
          (datum) => '${datum.label} : ${datum.valueLabel ?? formatCount(datum.value.round())}',
        )
        .join(', ');

    return Semantics(
      label: alternative,
      child: ExcludeSemantics(
        child: Column(
          children: [
            for (final AccessibleBarDatum datum in visible) ...[
              Row(
                children: [
                  Expanded(child: Text(datum.label)),
                  const SizedBox(width: AppSpacing.medium),
                  Text(
                    datum.valueLabel ?? formatCount(datum.value.round()),
                    style: context.theme.typography.body.sm.copyWith(
                      fontWeight: .w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.small),
              FDeterminateProgress(
                value: (datum.value / maximum).clamp(0, 1).toDouble(),
                style: const .delta(
                  constraints: .tightFor(height: AppSpacing.medium),
                ),
              ),
              const SizedBox(height: AppSpacing.big),
            ],
          ],
        ),
      ),
    );
  }
}
