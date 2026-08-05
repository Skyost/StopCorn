import 'package:flutter/material.dart' show SelectionArea;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/features/journal/application/journal_entry_controller.dart';
import 'package:stopcorn/features/journal/domain/journal_day.dart';
import 'package:stopcorn/features/journal/presentation/journal_entry_actions.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays every persisted field of one consumption event.
final class ConsumptionDetails extends ConsumerWidget {
  /// Consumption entry displayed in the sheet.
  final ConsumptionJournalEntry entry;

  /// Creates complete details for [entry].
  const ConsumptionDetails({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    crossAxisAlignment: .stretch,
    children: [
      AppSectionHeader(
        title: Text(context.t.journal.history.entry.consumption),
        subtitle: Text(
          DateFormat.yMMMMEEEEd(
            LocaleSettings.currentLocale.languageCode,
          ).add_Hm().format(entry.occurredAt),
        ),
      ),
      FTileGroup(
        children: [
          journalDetailTile(
            Text(context.t.consumption.time),
            Text(
              DateFormat.Hm(
                LocaleSettings.currentLocale.languageCode,
              ).format(entry.occurredAt),
            ),
          ),
          if (entry.triggerType case TriggerType value)
            journalDetailTile(
              Text(context.t.consumption.factors.trigger),
              Text(triggerLabel(value)),
            ),
          if (entry.emotionType case EmotionType value)
            journalDetailTile(
              Text(context.t.consumption.factors.emotion),
              Text(emotionLabel(value)),
            ),
          if (entry.perceivedControl case int value)
            journalDetailTile(
              Text(context.t.consumption.control.label),
              Text('$value / 10'),
            ),
          if (entry.contextKeys.isNotEmpty)
            journalDetailTile(
              Text(context.t.consumption.contextualGoal.label),
              Text(
                entry.contextKeys.map((key) => contextualOptions[key] ?? key).join(', '),
              ),
            ),
        ],
      ),
      if (entry.contextLabel case String value when value.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          title: Text(context.t.consumption.context.label),
        ),
        AppCard(child: SelectionArea(child: Text(value))),
      ],
      if (entry.notes case String value when value.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          title: Text(context.t.consumption.note.label),
        ),
        AppCard(child: SelectionArea(child: Text(value))),
      ],
      const SizedBox(height: AppSpacing.section),
      JournalEntryActions(
        editKey: const Key('journal_edit_consumption'),
        deleteKey: const Key('journal_delete_consumption'),
        onEdit: () => AppRoutes.editConsumption(entry.id),
        confirmationBody: context.t.journal.delete.consumption,
        onDelete: () => ref.read(journalEntryControllerProvider.notifier).removeConsumption(entry.id),
      ),
    ],
  );
}

/// Displays every persisted field of one daily check-in.
final class CheckInDetails extends ConsumerWidget {
  /// Daily check-in displayed in the sheet.
  final CheckInJournalEntry entry;

  /// Creates complete details for [entry].
  const CheckInDetails({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    crossAxisAlignment: .stretch,
    children: [
      AppSectionHeader(
        title: Text(context.t.journal.history.entry.checkIn),
        subtitle: Text(
          DateFormat.yMMMMEEEEd(
            LocaleSettings.currentLocale.languageCode,
          ).format(entry.localDate),
        ),
      ),
      FTileGroup(
        children: [
          journalDetailTile(
            Text(context.t.checkIn.mood.label),
            Text('${entry.moodScore} / 10'),
          ),
          journalDetailTile(
            Text(context.t.checkIn.control.label),
            Text('${entry.controlScore} / 10'),
          ),
          if (entry.urgeCountEstimate case int value)
            journalDetailTile(
              Text(context.t.checkIn.urge.count),
              Text.rich(
                context.t.journal.history.details.cornUrges(
                  count: value,
                  countBuilder: (count) => TextSpan(text: '$count'),
                  corn: cornBrandSpan(context),
                ),
              ),
            ),
          if (entry.sleepQuality case int value)
            journalDetailTile(
              Text(context.t.checkIn.sleep.label),
              Text('$value / 10'),
            ),
        ],
      ),
      if (entry.note case String value when value.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          title: Text(context.t.checkIn.note.label),
        ),
        AppCard(child: SelectionArea(child: Text(value))),
      ],
      const SizedBox(height: AppSpacing.section),
      JournalEntryActions(
        editKey: const Key('journal_edit_check_in'),
        deleteKey: const Key('journal_delete_check_in'),
        onEdit: () => AppRoutes.checkInOn(entry.localDateKey),
        confirmationBody: context.t.journal.delete.checkIn,
        onDelete: () => ref.read(journalEntryControllerProvider.notifier).removeCheckIn(entry.localDateKey),
      ),
    ],
  );
}

/// Displays every persisted field of one urge-support session.
///
/// The session is a record of a moment that already passed, so it is not
/// reopened as a form the way a consumption event is. It can still be deleted:
/// a mistyped intensity or outcome would otherwise stay in every statistic
/// with no way back.
final class UrgeDetails extends ConsumerWidget {
  /// Urge session displayed in the sheet.
  final UrgeJournalEntry entry;

  /// Creates complete details for [entry].
  const UrgeDetails({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    crossAxisAlignment: .stretch,
    children: [
      AppSectionHeader(
        title: Text(context.t.journal.history.entry.urge),
        subtitle: Text(
          DateFormat.yMMMMEEEEd(
            LocaleSettings.currentLocale.languageCode,
          ).add_Hm().format(entry.startedAt),
        ),
      ),
      FTileGroup(
        children: [
          journalDetailTile(
            Text(context.t.journal.history.details.initialIntensity),
            Text(
              context.t.app.score.outOfTen(
                value: formatCount(entry.initialIntensity),
              ),
            ),
          ),
          if (entry.finalIntensity case int value)
            journalDetailTile(
              Text(context.t.journal.history.details.finalIntensity),
              Text(
                context.t.app.score.outOfTen(value: formatCount(value)),
              ),
            ),
          journalDetailTile(
            Text(context.t.journal.history.details.outcome),
            Text(urgeOutcomeLabel(entry.outcome)),
          ),
          if (entry.triggerType case TriggerType value)
            journalDetailTile(
              Text(context.t.consumption.factors.trigger),
              Text(triggerLabel(value)),
            ),
          if (entry.emotionType case EmotionType value)
            journalDetailTile(
              Text(context.t.consumption.factors.emotion),
              Text(emotionLabel(value)),
            ),
          if (entry.copingStrategyId case String value)
            journalDetailTile(
              Text(context.t.journal.history.details.strategy),
              Text(strategyTitle(value)),
            ),
          if (entry.pauseDurationSeconds case int value)
            journalDetailTile(
              Text(context.t.journal.history.details.pause),
              Text(
                context.t.journal.history.details.pauseSeconds(count: value),
              ),
            ),
        ],
      ),
      if (entry.notes case String value when value.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          title: Text(context.t.journal.history.details.reflection),
        ),
        AppCard(child: SelectionArea(child: Text(value))),
      ],
      const SizedBox(height: AppSpacing.section),
      JournalEntryActions(
        deleteKey: const Key('journal_delete_urge'),
        confirmationBody: context.t.journal.delete.urge,
        onDelete: () => ref.read(journalEntryControllerProvider.notifier).removeUrgeSession(entry.id),
      ),
    ],
  );
}

/// Builds one unrestricted detail row from [label] and [value].
FTile journalDetailTile(Widget label, Widget value) => FTile(
  title: label,
  subtitle: AppTileSubtitle(child: value),
);
