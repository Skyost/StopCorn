import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';

/// Opens a consistently opaque and scrollable StopCorn bottom sheet.
Future<T?> showAppSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) => showFSheet<T>(
  context: context,
  side: .btt,
  useRootNavigator: true,
  mainAxisMaxRatio: null,
  builder: (sheetContext) => AppSheet(
    child: builder(sheetContext),
  ),
);

/// Provides an opaque, safe, and height-bounded surface for sheet content.
final class AppSheet extends StatelessWidget {
  /// Maximum fraction of the screen height occupied by a sheet.
  static const double _defaultMaxHeightFactor = 0.9;

  /// Radius applied to the exposed top edge.
  static const double _cornerRadius = 28;

  /// Content displayed inside the sheet.
  final Widget child;

  /// Insets around [child].
  final EdgeInsetsGeometry padding;

  /// Maximum fraction of the available screen height.
  final double maxHeightFactor;

  /// Creates a shared modal sheet surface.
  const AppSheet({
    super.key,
    required this.child,
    this.padding = const .all(AppSpacing.page),
    this.maxHeightFactor = _defaultMaxHeightFactor,
  }) : assert(
         0 < maxHeightFactor && maxHeightFactor <= 1,
         'maxHeightFactor must be between zero and one.',
       );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return ClipRRect(
      borderRadius: const .vertical(
        top: .circular(_cornerRadius),
      ),
      child: ColoredBox(
        color: context.theme.colors.background,
        child: SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: .new(
              maxHeight: screenSize.height * maxHeightFactor,
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: .onDrag,
              padding: padding,
              child: SizedBox(width: double.infinity, child: child),
            ),
          ),
        ),
      ),
    );
  }
}
