import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/accessible_bar_chart.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/features/progress/domain/initial_profile.dart';
import 'package:stopcorn/features/progress/domain/progress_dashboard.dart';
import 'package:stopcorn/features/progress/presentation/progress_metric_cards.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Compares compatible current observations with the onboarding baseline.
final class StartingPointComparison extends StatelessWidget {
  /// Minimum daily observations used before comparing perceived control.
  static const int _minimumControlCheckIns = 5;

  /// Dashboard values for the currently selected period.
  final ProgressDashboard dashboard;

  /// Immutable baseline captured during onboarding.
  final InitialProfile profile;

  /// Creates the two starting-point comparison cards.
  const StartingPointComparison({
    super.key,
    required this.dashboard,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    bool hasControlComparison = dashboard.checkInCount >= _minimumControlCheckIns && dashboard.averageControl != null;
    double? weeklyEvents = dashboard.averageWeeklyRecordedEvents;
    bool hasFrequencyComparison = profile.weeklyFrequency != null && weeklyEvents != null;
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        ProgressChartCard(
          key: const Key('progress_starting_point_control_card'),
          title: context.t.progress.startingPoint.comparison.control,
          interpretation: hasControlComparison
              ? context.t.progress.startingPoint.comparison.controlDetail(
                  count: dashboard.checkInCount,
                )
              : context.t.progress.startingPoint.comparison.controlPending,
          child: AccessibleBarChart(
            showZeroValues: true,
            emptyMessage: context.t.progress.startingPoint.comparison.controlPending,
            maximum: 10,
            data: [
              AccessibleBarDatum(
                label: context.t.progress.startingPoint.comparison.initial,
                value: profile.perceivedControl.toDouble(),
                valueLabel: t.app.score.outOfTen(value: formatCount(profile.perceivedControl)),
              ),
              if (hasControlComparison)
                AccessibleBarDatum(
                  label: context.t.progress.startingPoint.comparison.finalLabel,
                  value: dashboard.averageControl!,
                  valueLabel: t.app.score.outOfTen(value: formatDecimal(dashboard.averageControl!)),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.big),
        ProgressChartCard(
          key: const Key('progress_starting_point_frequency_card'),
          title: context.t.progress.startingPoint.comparison.frequency,
          interpretation: hasFrequencyComparison ? context.t.progress.startingPoint.comparison.frequencyDetail : context.t.progress.startingPoint.comparison.frequencyPending,
          child: AccessibleBarChart(
            showZeroValues: true,
            emptyMessage: context.t.progress.startingPoint.comparison.frequencyPending,
            data: [
              if (profile.weeklyFrequency case int initialFrequency)
                AccessibleBarDatum(
                  label: context.t.progress.startingPoint.comparison.initial,
                  value: initialFrequency.toDouble(),
                  valueLabel: formatCount(initialFrequency),
                ),
              if (hasFrequencyComparison)
                AccessibleBarDatum(
                  label: context.t.progress.startingPoint.comparison.finalLabel,
                  value: weeklyEvents,
                  valueLabel: formatCompactDecimal(weeklyEvents),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.big),
        AppButton(
          key: const Key('open_initial_profile_button'),
          variant: .outline,
          onPress: () => context.push(AppRoutes.initialProfile),
          child: Text(
            context.t.progress.startingPoint.comparison.open,
          ),
        ),
      ],
    );
  }
}
