import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_tile_subtitle.dart';

/// Displays a checkbox as an option inside an [FTileGroup].
final class AppCheckboxTile extends StatelessWidget with FTileMixin {
  /// Key assigned directly to the underlying checkbox control.
  final Key? controlKey;

  /// Primary option label.
  final Widget title;

  /// Optional supporting explanation.
  final Widget? description;

  /// Current checkbox value.
  final bool value;

  /// Persists a changed value, or `null` when the option is disabled.
  final Future<void> Function(bool value)? onChange;

  /// Creates a checkbox tile controlled by its parent.
  const AppCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChange,
    this.controlKey,
    this.description,
  });

  @override
  Widget build(BuildContext context) => FTile(
    title: title,
    subtitle: description == null
        ? null
        : AppTileSubtitle(
            child: description!,
          ),
    suffix: FCheckbox(
      key: controlKey,
      value: value,
      enabled: onChange != null,
      onChange: onChange == null
          ? null
          : (nextValue) async {
              await onChange!(nextValue);
            },
    ),
    onPress: onChange == null
        ? null
        : () async {
            await onChange!(!value);
          },
  );
}
