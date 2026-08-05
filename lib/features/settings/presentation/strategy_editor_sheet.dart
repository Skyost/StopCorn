import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_selection_checkbox.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/features/onboarding/presentation/onboarding_labels.dart';
import 'package:stopcorn/features/settings/application/settings_controller.dart';
import 'package:stopcorn/features/settings/presentation/settings_selection_sheet.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Opens the backup-plan editor initialized from [selectedStrategyIds].
Future<void> showStrategyEditorSheet(
  BuildContext context, {
  required Set<String> selectedStrategyIds,
}) => showAppSheet<void>(
  context: context,
  builder: (sheetContext) => StrategyEditorSheet(initialValues: selectedStrategyIds),
);

/// Hosts the settings form used to select coping strategies.
final class StrategyEditorSheet extends ConsumerStatefulWidget {
  /// Initially selected strategy identifiers.
  final Set<String> initialValues;

  /// Creates a strategy editor initialized from [initialValues].
  const StrategyEditorSheet({
    super.key,
    required this.initialValues,
  });

  @override
  ConsumerState<StrategyEditorSheet> createState() => _StrategyEditorSheetState();
}

/// Manages coping strategy selection and persistence.
final class _StrategyEditorSheetState extends ConsumerState<StrategyEditorSheet> {
  /// Identifiers of the currently selected strategies.
  late Set<String> _values;

  /// Whether the selection is currently being saved.
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _values = widget.initialValues.toSet();
  }

  @override
  Widget build(BuildContext context) => SettingsSelectionSheet(
    title: context.t.settings.personalPlan.backup.title,
    description: context.t.settings.personalPlan.backup.description,
    saving: _saving,
    selection: FTileGroup(
      children: [
        for (final BuiltInStrategyDefinition strategy in builtInStrategies)
          FTile(
            title: Text(strategyTitle(strategy.id)),
            subtitle: AppTileSubtitle(
              child: Text(strategyDescription(strategy.id)),
            ),
            selected: _values.contains(strategy.id),
            suffix: AppSelectionCheckbox(
              value: _values.contains(strategy.id),
              enabled: !_saving,
            ),
            onPress: _saving
                ? null
                : () => setState(() {
                    _values.contains(strategy.id) ? _values.remove(strategy.id) : _values.add(strategy.id);
                  }),
          ),
      ],
    ),
    onSave: () async {
      setState(() => _saving = true);
      bool success = await ref.read(settingsControllerProvider.notifier).updateStrategies(_values);
      if (mounted) {
        success ? Navigator.of(this.context).pop() : setState(() => _saving = false);
      }
    },
  );
}
