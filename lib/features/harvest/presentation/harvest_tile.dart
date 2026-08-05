import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/app/widgets/flame_icon.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays the optional harvest and opens its plain-language explanation.
final class HarvestTile extends StatelessWidget {
  /// Locally derived harvest values.
  final HarvestSummary summary;

  /// Whether to show the tile group label.
  final bool showLabel;

  /// Whether to include the current-week view and best momentum.
  final bool expanded;

  /// Whether to display the action that opens the harvest explanation.
  final bool showExplanationAction;

  /// Creates a tappable harvest card.
  const HarvestTile({
    super.key,
    required this.summary,
    this.showLabel = false,
    this.expanded = false,
    this.showExplanationAction = true,
  });

  @override
  Widget build(BuildContext context) => FTileGroup(
    label: showLabel ? Text(context.t.harvest.label) : null,
    description: showExplanationAction
        ? Align(
            alignment: .bottomEnd,
            child: AppButton(
              size: .sm,
              mainAxisSize: .min,
              variant: .ghost,
              onPress: () => showHarvestInformation(context),
              child: Text(
                context.t.harvest.explanationAction,
                style: context.theme.typography.body.xs,
              ),
            ),
          )
        : null,
    children: [
      FTile(
        key: const Key('harvest_tile_corn_points'),
        prefix: expanded ? null : const CornKernelIcon(),
        title: Text(context.t.harvest.cornPoints.title),
        subtitle: AppTileSubtitle(
          child: Text(
            summary.cultivatedToday ? context.t.harvest.cornPoints.todayCollected : context.t.harvest.cornPoints.todayAvailable,
          ),
        ),
        suffix: expanded
            ? Row(
                mainAxisSize: .min,
                spacing: AppSpacing.medium,
                children: [
                  Text(summary.grainCount.toString()),
                  const CornKernelIcon(),
                ],
              )
            : Text(summary.grainCount.toString()),
      ),
      FTile(
        prefix: expanded ? null : const FlameIcon(),
        title: Text(context.t.harvest.momentum.title),
        subtitle: AppTileSubtitle(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              if (expanded) Text(context.t.harvest.momentum.currentMomentum(count: summary.currentMomentum)),
              Text(
                context.t.harvest.momentum.bestMomentum(count: summary.bestMomentum),
              ),
              if (expanded) ...[
                const SizedBox(height: AppSpacing.big),
                _RecentHarvest(days: summary.recentDays),
              ],
            ],
          ),
        ),
        suffix: expanded ? null : Text(summary.currentMomentum.toString()),
      ),
    ],
  );
}

/// Displays the current calendar week using the locale's first weekday.
final class _RecentHarvest extends StatelessWidget {
  /// Number of days rendered in one complete calendar week.
  static const int _daysPerWeek = 7;

  /// Seven consecutive local days ending on the current day.
  final List<HarvestDay> days;

  /// Creates a compact, locale-aligned weekly harvest.
  const _RecentHarvest({
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      return const SizedBox.shrink();
    }
    DateTime today = days.last.date;
    List<HarvestDay> week = _localizedWeek(context, today);
    return Row(
      children: [
        for (final HarvestDay day in week)
          Expanded(
            child: Semantics(
              key: Key('harvest_week_day_${day.date.weekday}'),
              label: day.date.isAfter(today)
                  ? context.t.harvest.momentum.dayUpcoming
                  : day.cultivated
                  ? context.t.harvest.momentum.dayCollected
                  : context.t.harvest.momentum.dayNotCollected,
              child: Column(
                children: [
                  CornKernelIcon(
                    collected: day.cultivated,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    DateFormat.E(
                      LocaleSettings.currentLocale.languageCode,
                    ).format(day.date),
                    style: context.theme.typography.body.xs,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the calendar week containing [today] for the active locale.
  List<HarvestDay> _localizedWeek(
    BuildContext context,
    DateTime today,
  ) {
    int materialWeekday = MaterialLocalizations.of(
      context,
    ).firstDayOfWeekIndex;
    int firstWeekday = materialWeekday == 0 ? DateTime.sunday : materialWeekday;
    int elapsedDays = (today.weekday - firstWeekday + _daysPerWeek) % _daysPerWeek;
    DateTime weekStart = addLocalDays(today, -elapsedDays);
    return [
      for (int offset = 0; offset < _daysPerWeek; offset++) _dayFor(addLocalDays(weekStart, offset)),
    ];
  }

  /// Returns the stored harvest day for [date], or an empty placeholder.
  HarvestDay _dayFor(DateTime date) {
    for (HarvestDay day in days) {
      if (_isSameLocalDate(day.date, date)) {
        return day;
      }
    }
    return HarvestDay(date: date, cultivated: false);
  }

  /// Reports whether [first] and [second] share the same local calendar date.
  bool _isSameLocalDate(DateTime first, DateTime second) => first.year == second.year && first.month == second.month && first.day == second.day;
}

/// Opens the scrollable explanation of grains, actions, and momentum.
Future<void> showHarvestInformation(BuildContext context) => showAppSheet<void>(
  context: context,
  builder: (sheetContext) => Column(
    crossAxisAlignment: .stretch,
    children: [
      Text(
        sheetContext.t.harvest.sheet.title,
        style: sheetContext.theme.typography.display.lg.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.big),
      Text(sheetContext.t.harvest.sheet.intro),
      const SizedBox(height: AppSpacing.big),
      _HarvestExplanationPoint(
        icon: FLucideIcons.circleGauge,
        text: sheetContext.t.harvest.sheet.onePerDay,
      ),
      _HarvestExplanationPoint(
        icon: FLucideIcons.heartHandshake,
        text: sheetContext.t.harvest.sheet.urge,
      ),
      _HarvestExplanationPoint(
        icon: FLucideIcons.clipboardCheck,
        text: sheetContext.t.harvest.sheet.checkIn,
      ),
      _HarvestExplanationPoint(
        icon: FLucideIcons.notebookPen,
        text: sheetContext.t.harvest.sheet.observation,
      ),
      _HarvestExplanationPoint(
        icon: FLucideIcons.bookOpenCheck,
        text: sheetContext.t.harvest.sheet.learning,
      ),
      _HarvestExplanationPoint(
        icon: FLucideIcons.target,
        text: sheetContext.t.harvest.sheet.goal,
      ),
      const SizedBox(height: AppSpacing.big),
      Text(
        sheetContext.t.harvest.sheet.momentumTitle,
        style: sheetContext.theme.typography.body.lg.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.small),
      Text(sheetContext.t.harvest.sheet.momentumBody),
      const SizedBox(height: AppSpacing.section),
      AppButton(
        onPress: () => Navigator.of(sheetContext).pop(),
        child: Text(sheetContext.t.app.close),
      ),
    ],
  ),
);

/// Presents one action that may cultivate the current day.
final class _HarvestExplanationPoint extends StatelessWidget {
  /// Icon representing the action.
  final IconData icon;

  /// Plain-language explanation.
  final String text;

  /// Creates one explanation row.
  const _HarvestExplanationPoint({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .symmetric(vertical: AppSpacing.medium),
    child: Row(
      crossAxisAlignment: .start,
      children: [
        Icon(icon),
        const SizedBox(width: AppSpacing.medium),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
