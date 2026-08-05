import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// Displays a non-interactive [FCheckbox] as a tile selection indicator.
///
/// The surrounding tile owns interaction and selection semantics. Keeping the
/// checkbox pointer-transparent avoids nested tap targets while retaining
/// ForUI's colorful selected state.
final class AppSelectionCheckbox extends StatelessWidget {
  /// Effectively circular radius used by the radio-like variant.
  static const double _circularRadius = 999;

  /// Whether the represented option or status is selected.
  final bool value;

  /// Whether the surrounding option can currently be changed.
  final bool enabled;

  /// Whether the checkbox should use a radio-like circular outline.
  final bool circular;

  /// Creates a visual ForUI selection indicator.
  const AppSelectionCheckbox({
    super.key,
    required this.value,
    this.enabled = true,
    this.circular = false,
  });

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: IgnorePointer(
      child: FCheckbox(
        value: value,
        enabled: enabled,
        style: circular
            ? .delta(
                trailingLabelStyle: const .delta(
                  childPadding: .value(.zero),
                ),
                focusedOutlineStyle: const .delta(
                  borderRadius: .all(
                    .circular(_circularRadius),
                  ),
                ),
                decoration: .delta(
                  [
                    .all(
                      const .boxDelta(
                        borderRadius: .all(
                          .circular(_circularRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const .context(),
      ),
    ),
  );
}
