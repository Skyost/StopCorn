import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/app/widgets/app_selection_checkbox.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/domain/app_enums.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_reward_dialog.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/features/settings/application/settings_controller.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Opens the goal editor initialized from [activeGoal].
Future<void> showGoalEditorSheet(
  BuildContext context, {
  required Goal? activeGoal,
}) => showAppSheet<void>(
  context: context,
  builder: (sheetContext) => GoalEditorSheet(activeGoal: activeGoal),
);

/// Reads the persisted direction of [goal], falling back to observation.
///
/// An unreadable value never blocks the editor: the person can simply pick the
/// direction they want again.
GoalType goalTypeOf(Goal goal) => enumFromStoredValueOrNull(GoalType.values, goal.type) ?? .observation;

/// Hosts the settings form used to create and activate a goal.
final class GoalEditorSheet extends ConsumerStatefulWidget {
  /// Existing goal retained in history when a new one is activated.
  final Goal? activeGoal;

  /// Creates a goal editor initialized from [activeGoal].
  const GoalEditorSheet({
    super.key,
    required this.activeGoal,
  });

  @override
  ConsumerState<GoalEditorSheet> createState() => _GoalEditorSheetState();
}

/// Manages the editable goal values and their persistence state.
final class _GoalEditorSheetState extends ConsumerState<GoalEditorSheet> {
  /// Selected goal type.
  late GoalType _type;

  /// Weekly limit as entered by the user.
  late String _weeklyLimit;

  /// Context identifiers selected for a contextual goal.
  late Set<String> _contexts;

  /// Free-form motivation attached to the goal.
  late String _motivation;

  /// Last validation or persistence error.
  String? _error;

  /// Whether the goal is currently being saved.
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    Goal? active = widget.activeGoal;
    _type = active == null ? .observation : goalTypeOf(active);
    _weeklyLimit = active?.weeklyLimit?.toString() ?? '';
    _contexts = _decodeContexts(active?.contextKeysJson);
    _motivation = active?.motivation ?? '';
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .stretch,
    children: [
      Text(
        context.t.settings.goalEditor.title,
        style: context.theme.typography.display.lg.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.small),
      Text(context.t.settings.goalEditor.history),
      const SizedBox(height: AppSpacing.big),
      FTileGroup(
        children: [
          for (final GoalType type in GoalType.values)
            FTile(
              title: Text(goalTitle(type)),
              subtitle: AppTileSubtitle(
                child: Text(goalDescription(type)),
              ),
              selected: _type == type,
              suffix: AppSelectionCheckbox(
                value: _type == type,
                enabled: !_saving,
                circular: true,
              ),
              onPress: _saving ? null : () => setState(() => _type = type),
            ),
        ],
      ),
      if (_type == .reduction) ...[
        const SizedBox(height: AppSpacing.big),
        FTextField(
          control: FTextFieldControl.managed(
            initial: TextEditingValue(text: _weeklyLimit),
            onChange: (value) => setState(() => _weeklyLimit = value.text),
          ),
          label: Text(context.t.onboarding.goal.weeklyLimit),
          keyboardType: .number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
        ),
      ],
      if (_type == .contextual) ...[
        const SizedBox(height: AppSpacing.big),
        FTileGroup(
          label: Text(context.t.onboarding.goal.contexts),
          children: [
            for (final MapEntry<String, String> option in contextualOptions.entries)
              FTile(
                title: Text(option.value),
                selected: _contexts.contains(option.key),
                suffix: AppSelectionCheckbox(
                  value: _contexts.contains(option.key),
                  enabled: !_saving,
                ),
                onPress: _saving
                    ? null
                    : () => setState(() {
                        _contexts.contains(option.key) ? _contexts.remove(option.key) : _contexts.add(option.key);
                      }),
              ),
          ],
        ),
      ],
      const SizedBox(height: AppSpacing.big),
      FTextField(
        control: FTextFieldControl.managed(
          initial: TextEditingValue(text: _motivation),
          onChange: (value) => setState(() => _motivation = value.text),
        ),
        label: Text(context.t.onboarding.goal.motivation),
        minLines: 2,
        maxLines: 3,
        maxLength: AppConstants.motivationMaxLength,
        textCapitalization: .sentences,
      ),
      if (_error != null) ...[
        const SizedBox(height: AppSpacing.medium),
        Text(_error!),
      ],
      const SizedBox(height: AppSpacing.section),
      AppActionButtons(
        primaryButtonKey: const Key('save_goal_button'),
        onPrimaryPress: _saving ? null : _save,
        primaryLabel: Text(
          _saving ? context.t.app.saving : context.t.settings.goalEditor.activate,
        ),
        onSecondaryPress: _saving ? null : () => Navigator.of(context).pop(),
        secondaryLabel: Text(context.t.app.cancel),
      ),
    ],
  );

  /// Validates and activates the edited goal.
  Future<void> _save() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    bool success = await runWithHarvestReward(
      context,
      ref,
      () => ref
          .read(settingsControllerProvider.notifier)
          .activateGoal(
            type: _type,
            weeklyLimit: int.tryParse(_weeklyLimit),
            contextKeys: _contexts.toList()..sort(),
            motivation: _motivation,
          ),
    );
    if (!mounted) {
      return;
    }
    if (success) {
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      _saving = false;
      _error = ref.read(settingsControllerProvider).value?.errorMessage ?? t.settings.goalEditor.error;
    });
  }

  /// Decodes a persisted JSON context list, tolerating invalid input.
  Set<String> _decodeContexts(String? raw) {
    if (raw == null) {
      return {};
    }
    try {
      Object? decoded = jsonDecode(raw);
      return decoded is List<Object?> ? decoded.whereType<String>().toSet() : {};
    } on FormatException {
      return {};
    }
  }
}
