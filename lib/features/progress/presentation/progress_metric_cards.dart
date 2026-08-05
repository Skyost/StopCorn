import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_equal_height_row.dart';
import 'package:stopcorn/app/widgets/app_metric_card.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';

/// Shared titled card around a chart and its text interpretation.
final class ProgressChartCard extends StatelessWidget {
  /// Chart heading.
  final String title;

  /// Accessible natural-language interpretation.
  final String interpretation;

  /// Visual and semantic chart.
  final Widget child;

  /// Creates a chart card with a textual [interpretation].
  const ProgressChartCard({
    super.key,
    required this.title,
    required this.interpretation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        Text(
          title,
          style: context.theme.typography.body.lg.copyWith(
            fontWeight: .w700,
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        AppSubtitle(text: interpretation),
        const SizedBox(height: AppSpacing.big),
        child,
      ],
    ),
  );
}

/// Presentation-ready value, label, and optional explanation.
final class ProgressMetricData {
  /// Primary metric value.
  final String value;

  /// Metric label.
  final String label;

  /// Optional interpretation.
  final String? detail;

  /// Optional suffix displayed beside [value].
  final String? valueSuffix;

  /// Creates one compact dashboard metric.
  const ProgressMetricData({
    required this.value,
    required this.label,
    this.detail,
    this.valueSuffix,
  });
}

/// Responsive grid of compact progress metrics.
final class ProgressMetricGrid extends StatelessWidget {
  /// Minimum width that keeps two metric cards comfortably readable.
  static const double _twoColumnMinWidth = 470;

  /// Stable prefix used by metric-card test and semantics keys.
  final String keyPrefix;

  /// Metrics rendered in reading order.
  final List<ProgressMetricData> metrics;

  /// Creates a responsive grid for [metrics].
  const ProgressMetricGrid({
    super.key,
    required this.keyPrefix,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      int columns = constraints.maxWidth >= _twoColumnMinWidth ? 2 : 1;
      List<Widget> rows = [];
      for (int start = 0; start < metrics.length; start += columns) {
        List<Widget> cards = [];
        for (int offset = 0; offset < columns; offset++) {
          int metricIndex = start + offset;
          cards.add(
            metricIndex < metrics.length
                ? _metricCard(
                    context,
                    metrics[metricIndex],
                    metricIndex,
                  )
                : const SizedBox.shrink(),
          );
        }
        if (rows.isNotEmpty) {
          rows.add(const SizedBox(height: AppSpacing.medium));
        }
        rows.add(AppEqualHeightRow(children: cards));
      }
      return Column(children: rows);
    },
  );

  /// Builds one metric card identified by its reading-order [index].
  Widget _metricCard(
    BuildContext context,
    ProgressMetricData metric,
    int index,
  ) => AppMetricCard(
    key: Key('progress_${keyPrefix}_metric_$index'),
    value: metric.value,
    valueSuffix: metric.valueSuffix,
    label: Text(metric.label),
    detail: metric.detail,
  );
}
