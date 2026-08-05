import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Offers to correct or delete the journal entry shown in a detail sheet.
///
/// Records are self-reported, so a wrong entry has to be fixable. Correcting
/// is the primary action; deleting is possible but asks for confirmation
/// because the private note goes with it. An entry that cannot be reopened as
/// a form, such as a finished support session, omits [onEdit] and can still be
/// removed.
final class JournalEntryActions extends StatefulWidget {
  /// Key assigned to the correction action, when one exists.
  final Key? editKey;

  /// Key assigned to the deletion action.
  final Key deleteKey;

  /// Builds the location of the form correcting this entry, when it has one.
  final String Function()? onEdit;

  /// Explanation of what deleting this specific entry removes.
  final String confirmationBody;

  /// Deletes the entry and reports whether it succeeded.
  final Future<bool> Function() onDelete;

  /// Creates the deletion action and, when [onEdit] is given, the correction.
  const JournalEntryActions({
    super.key,
    required this.deleteKey,
    required this.confirmationBody,
    required this.onDelete,
    this.editKey,
    this.onEdit,
  });

  @override
  State<JournalEntryActions> createState() => JournalEntryActionsState();
}

/// Tracks the in-flight deletion of one journal entry.
final class JournalEntryActionsState extends State<JournalEntryActions> {
  /// Whether a deletion is currently running.
  bool _isDeleting = false;

  /// Localized failure shown when the entry could not be deleted.
  String? _errorMessage;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .stretch,
    children: [
      if (_errorMessage != null) ...[
        AppCard(
          child: Row(
            crossAxisAlignment: .start,
            children: [
              const Icon(FLucideIcons.circleAlert),
              const SizedBox(width: AppSpacing.medium),
              Expanded(child: Text(_errorMessage!)),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.big),
      ],
      if (widget.onEdit case String Function() onEdit) ...[
        AppButton(
          key: widget.editKey,
          onPress: _isDeleting
              ? null
              : () {
                  Navigator.of(context).pop();
                  context.push(onEdit());
                },
          child: Text(context.t.journal.edit.action),
        ),
        const SizedBox(height: AppSpacing.medium),
      ],
      AppButton(
        key: widget.deleteKey,
        variant: widget.onEdit == null ? .primary : .outline,
        onPress: _isDeleting ? null : _confirmDeletion,
        child: Text(context.t.journal.delete.action),
      ),
      const SizedBox(height: AppSpacing.medium),
      AppButton(
        variant: .ghost,
        onPress: _isDeleting ? null : () => Navigator.of(context).pop(),
        child: Text(context.t.app.close),
      ),
    ],
  );

  /// Asks for an explicit confirmation, then deletes the entry.
  Future<void> _confirmDeletion() async {
    bool? confirmed = await showFDialog<bool>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (dialogContext, style, animation) => FDialog(
        animation: animation,
        semanticsLabel: context.t.journal.delete.title,
        // The explanation names what this specific entry takes with it, and
        // has to stay readable at an enlarged text size inside a dialog whose
        // height the platform bounds.
        builder: (contentContext, style) => SingleChildScrollView(
          padding: const .all(AppSpacing.page),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              Text(
                contentContext.t.journal.delete.title,
                style: contentContext.theme.typography.display.lg.copyWith(
                  fontWeight: .w700,
                ),
              ),
              const SizedBox(height: AppSpacing.big),
              Text(widget.confirmationBody),
              const SizedBox(height: AppSpacing.medium),
              Text(contentContext.t.journal.delete.irreversible),
              const SizedBox(height: AppSpacing.section),
              AppButton(
                key: const Key('journal_confirm_delete'),
                variant: .destructive,
                onPress: () => Navigator.of(contentContext).pop(true),
                child: Text(contentContext.t.journal.delete.confirm),
              ),
              const SizedBox(height: AppSpacing.medium),
              AppButton(
                variant: .outline,
                onPress: () => Navigator.of(contentContext).pop(false),
                child: Text(contentContext.t.app.cancel),
              ),
            ],
          ),
        ),
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }

    setState(() {
      _isDeleting = true;
      _errorMessage = null;
    });
    bool deleted = await widget.onDelete();
    if (!mounted) {
      return;
    }
    if (deleted) {
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      _isDeleting = false;
      _errorMessage = t.journal.error.delete;
    });
  }
}
