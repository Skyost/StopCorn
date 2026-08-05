import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_card.dart';

/// Displays a ForUI switch on a readable card surface.
final class AppSwitchCard extends StatelessWidget {
  /// Key assigned directly to the underlying switch control.
  final Key? controlKey;

  /// Primary switch label.
  final Widget label;

  /// Optional supporting explanation.
  final Widget? description;

  /// Current switch value.
  final bool value;

  /// Called when the switch value changes, or `null` when disabled.
  final ValueChanged<bool>? onChange;

  /// Whether selected and focused colors communicate a destructive action.
  final bool destructive;

  /// Creates a switch contained in a shared StopCorn card.
  const AppSwitchCard({
    super.key,
    required this.label,
    required this.value,
    required this.onChange,
    this.controlKey,
    this.description,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) => AppCard(
    child: FSwitch(
      key: controlKey,
      style: destructive ? _destructiveStyle(context) : const .context(),
      label: label,
      description: description,
      value: value,
      enabled: onChange != null,
      onChange: onChange,
    ),
  );

  /// Builds a switch style whose active state uses the destructive palette.
  FSwitchStyleDelta _destructiveStyle(BuildContext context) => .delta(
    focusColor: context.theme.colors.destructive,
    trackColor: .delta(
      [
        .exact(
          {.selected},
          context.theme.colors.destructive,
        ),
        .exact(
          {
            .selected.and(.disabled),
          },
          context.theme.colors.disable(
            context.theme.colors.destructive,
          ),
        ),
      ],
    ),
  );
}
