import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/utils/local_date.dart';
import 'package:stopcorn/features/journal/data/journal_repository.dart';
import 'package:stopcorn/features/journal/domain/journal_day.dart';
import 'package:stopcorn/features/journal/presentation/journal_entry_details.dart';
import 'package:stopcorn/features/journal/presentation/journal_entry_previews.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays consumption events and daily check-ins in one dated journal.
final class JournalScreen extends ConsumerWidget {
  /// Creates the combined journal screen.
  const JournalScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<JournalDay>> days = ref.watch(journalDaysProvider);
    return AppPage(
      title: Text(context.t.journal.history.title),
      showBackButton: true,
      backFallbackLocation: AppRoutes.home,
      scrollable: false,
      child: days.when(
        loading: () => const AppPageList(
          children: [AsyncStatePanel(child: LoadingState())],
        ),
        error: (error, _) => AppPageList(
          children: [
            AsyncStatePanel(
              child: ErrorState(
                message: context.t.journal.history.error,
                error: error,
                onRetry: () => ref.invalidate(journalDaysProvider),
              ),
            ),
          ],
        ),
        data: (value) => value.isEmpty
            ? const _EmptyJournal()
            : _JournalDays(
                days: value,
                today: ref.watch(appClockProvider).now(),
              ),
      ),
    );
  }
}

/// Displays the journal empty state and both recording actions.
final class _EmptyJournal extends StatelessWidget {
  /// Creates an empty combined journal.
  const _EmptyJournal();

  @override
  Widget build(BuildContext context) => AppPageList(
    children: [
      AppSubtitle(text: context.t.journal.history.intro),
      const SizedBox(height: AppSpacing.section),
      AppCard(
        child: Column(
          children: [
            const Icon(
              FLucideIcons.notebookTabs,
              size: AppIconSize.display,
            ),
            const SizedBox(height: AppSpacing.big),
            Text(
              context.t.journal.history.empty.title,
              textAlign: .center,
              style: context.theme.typography.display.lg.copyWith(
                fontWeight: .w700,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Text(
              context.t.journal.history.empty.body,
              textAlign: .center,
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.section),
      AppActionButtons(
        onPrimaryPress: () => context.push(AppRoutes.logConsumption),
        primaryLabel: Text(context.t.home.actions.logConsumption),
        onSecondaryPress: () => context.push(AppRoutes.checkIn),
        secondaryLabel: Text(context.t.home.checkIn.action.pending),
      ),
    ],
  );
}

/// Displays journal entries grouped by local date.
final class _JournalDays extends StatelessWidget {
  /// Journal groups ordered from newest to oldest.
  final List<JournalDay> days;

  /// Current instant used for relative date labels.
  final DateTime today;

  /// Creates a grouped journal for [days].
  const _JournalDays({
    required this.days,
    required this.today,
  });

  @override
  Widget build(BuildContext context) => AppPageList(
    children: [
      AppSubtitle(text: context.t.journal.history.intro),
      const SizedBox(height: AppSpacing.section),
      for (final (int index, JournalDay day) in days.indexed) ...[
        if (index > 0) const SizedBox(height: AppSpacing.section),
        AppSectionHeader(
          title: Text(_dateLabel(context, day.date)),
        ),
        FTileGroup(
          label: Text(context.t.journal.history.entry.entries(count: day.entries.length)),
          children: [
            for (JournalEntry entry in day.entries) _entryTile(context, entry),
          ],
        ),
      ],
    ],
  );

  /// Builds the tile corresponding to [entry].
  FTile _entryTile(BuildContext context, JournalEntry entry) => switch (entry) {
    ConsumptionJournalEntry consumption => FTile(
      key: Key('journal_consumption_${consumption.id}'),
      prefix: const Icon(FLucideIcons.notebookPen),
      title: Text(context.t.journal.history.entry.consumption),
      subtitle: AppTileSubtitle(
        child: ConsumptionPreview(entry: consumption),
      ),
      suffix: const Icon(FLucideIcons.chevronRight),
      onPress: () async {
        await _showConsumptionDetails(context, consumption);
      },
    ),
    CheckInJournalEntry checkIn => FTile(
      key: Key('journal_check_in_${checkIn.localDateKey}'),
      prefix: const Icon(FLucideIcons.clipboardCheck),
      title: Text(context.t.journal.history.entry.checkIn),
      subtitle: AppTileSubtitle(
        child: CheckInPreview(entry: checkIn),
      ),
      suffix: const Icon(FLucideIcons.chevronRight),
      onPress: () async {
        await _showCheckInDetails(context, checkIn);
      },
    ),
    UrgeJournalEntry urge => FTile(
      key: Key('journal_urge_${urge.id}'),
      prefix: const Icon(FLucideIcons.wind),
      title: Text(context.t.journal.history.entry.urge),
      subtitle: AppTileSubtitle(
        child: UrgePreview(entry: urge),
      ),
      suffix: const Icon(FLucideIcons.chevronRight),
      onPress: () async {
        await _showUrgeDetails(context, urge);
      },
    ),
  };

  /// Returns a localized relative or absolute label for [date].
  String _dateLabel(BuildContext context, DateTime date) {
    DateTime currentDate = _dateOnly(today.toLocal());
    if (date == currentDate) {
      return context.t.journal.history.date.today;
    }
    if (date == addLocalDays(currentDate, -1)) {
      return context.t.journal.history.date.yesterday;
    }
    String label = DateFormat.yMMMMEEEEd(
      LocaleSettings.currentLocale.languageCode,
    ).format(date);
    return '${label[0].toUpperCase()}${label.substring(1)}';
  }

  /// Returns local midnight for [value].
  DateTime _dateOnly(DateTime value) => DateTime(
    value.year,
    value.month,
    value.day,
  );

  /// Opens the complete consumption details for [entry].
  Future<void> _showConsumptionDetails(
    BuildContext context,
    ConsumptionJournalEntry entry,
  ) => showAppSheet<void>(
    context: context,
    builder: (sheetContext) => ConsumptionDetails(entry: entry),
  );

  /// Opens the complete daily check-in details for [entry].
  Future<void> _showCheckInDetails(
    BuildContext context,
    CheckInJournalEntry entry,
  ) => showAppSheet<void>(
    context: context,
    builder: (sheetContext) => CheckInDetails(entry: entry),
  );

  /// Opens the complete urge-support session details for [entry].
  Future<void> _showUrgeDetails(
    BuildContext context,
    UrgeJournalEntry entry,
  ) => showAppSheet<void>(
    context: context,
    builder: (sheetContext) => UrgeDetails(entry: entry),
  );
}
