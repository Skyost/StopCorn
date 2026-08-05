import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/features/journal/domain/journal_day.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays a concise consumption preview without hiding user-written text.
final class ConsumptionPreview extends StatelessWidget {
  /// Consumption entry being summarized.
  final ConsumptionJournalEntry entry;

  /// Creates a preview for [entry].
  const ConsumptionPreview({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    List<String> text = [
      if (entry.contextLabel case String value when value.isNotEmpty) value,
      if (entry.notes case String value when value.isNotEmpty) value,
    ];
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          context.t.journal.history.entry.time(
            time: DateFormat.Hm(
              LocaleSettings.currentLocale.languageCode,
            ).format(entry.occurredAt),
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        Text(
          text.isEmpty ? context.t.journal.history.entry.noText : text.join('\n'),
        ),
      ],
    );
  }
}

/// Displays a concise urge-session preview and its complete reflection.
final class UrgePreview extends StatelessWidget {
  /// Urge session being summarized.
  final UrgeJournalEntry entry;

  /// Creates a preview for [entry].
  const UrgePreview({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    int? finalIntensity = entry.finalIntensity;
    String? notes = entry.notes;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          context.t.journal.history.entry.time(
            time: DateFormat.Hm(
              LocaleSettings.currentLocale.languageCode,
            ).format(entry.startedAt),
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        Text(
          finalIntensity == null
              ? context.t.journal.history.entry.urgeSummaryPartial(
                  initial: formatCount(entry.initialIntensity),
                )
              : context.t.journal.history.entry.urgeSummary(
                  initial: formatCount(entry.initialIntensity),
                  finalValue: formatCount(finalIntensity),
                ),
        ),
        const SizedBox(height: AppSpacing.small),
        Text(
          notes == null || notes.isEmpty ? urgeOutcomeLabel(entry.outcome) : notes,
        ),
      ],
    );
  }
}

/// Displays a concise check-in preview and its complete private note.
final class CheckInPreview extends StatelessWidget {
  /// Check-in entry being summarized.
  final CheckInJournalEntry entry;

  /// Creates a preview for [entry].
  const CheckInPreview({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      Text(
        context.t.journal.history.entry.checkInSummary(
          mood: entry.moodScore,
          control: entry.controlScore,
        ),
      ),
      const SizedBox(height: AppSpacing.small),
      Text(
        entry.note == null || entry.note!.isEmpty ? context.t.journal.history.entry.noText : entry.note!,
      ),
    ],
  );
}

/// Displays every persisted field of one consumption event.
