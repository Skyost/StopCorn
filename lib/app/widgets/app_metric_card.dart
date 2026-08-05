import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';

/// Displays a prominent metric value with shared label and detail styling.
final class AppMetricCard extends StatelessWidget {
  /// Primary metric value.
  final String value;

  /// Description of [value].
  final Widget label;

  /// Optional short suffix displayed beside [value], such as `/ 10`.
  final String? valueSuffix;

  /// Optional contextual detail displayed below [label].
  final String? detail;

  /// Whether the complete metric content is centered.
  final bool centered;

  /// Creates a reusable metric card.
  const AppMetricCard({
    super.key,
    required this.value,
    required this.label,
    this.valueSuffix,
    this.detail,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      mainAxisAlignment: centered ? .center : .start,
      crossAxisAlignment: .stretch,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: value,
                style: context.theme.typography.display.xl.copyWith(
                  fontWeight: .w700,
                ),
              ),
              if (valueSuffix != null)
                TextSpan(
                  text: ' $valueSuffix',
                  style: context.theme.typography.body.sm.copyWith(
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
            ],
          ),
          textAlign: centered ? .center : .start,
        ),
        const SizedBox(height: AppSpacing.small),
        DefaultTextStyle.merge(
          textAlign: centered ? .center : .start,
          child: label,
        ),
        if (detail != null) ...[
          const SizedBox(height: AppSpacing.small),
          Text(
            detail!,
            textAlign: centered ? .center : .start,
            style: context.theme.typography.body.xs.copyWith(
              color: context.theme.colors.mutedForeground,
            ),
          ),
        ],
      ],
    ),
  );
}
