import 'package:flutter/widgets.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';

/// Applies the shared safe area, readable width, insets, and scrolling to a page.
final class AppPageViewport extends StatelessWidget {
  /// Width below which an animating route has no meaningful content area.
  static const double _transitionWidthGuard = 40;

  /// Page content.
  final Widget child;

  /// Whether [child] should scroll with the shared page behavior.
  final bool scrollable;

  /// Whether to keep content above the operating system's bottom intrusion.
  final bool safeAreaBottom;

  /// Creates a consistently inset page viewport.
  const AppPageViewport({
    super.key,
    required this.child,
    this.scrollable = true,
    this.safeAreaBottom = true,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    bottom: safeAreaBottom,
    child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _transitionWidthGuard || constraints.maxHeight == 0) {
          return const SizedBox.shrink();
        }

        Widget content;
        if (scrollable) {
          Widget scrollContent = constraints.hasBoundedHeight
              ? ConstrainedBox(
                  constraints: .new(minHeight: constraints.maxHeight),
                  child: child,
                )
              : child;
          content = SingleChildScrollView(
            padding: const .all(AppSpacing.page),
            keyboardDismissBehavior: .onDrag,
            child: scrollContent,
          );
        } else {
          content = child;
        }
        return Align(
          alignment: .topCenter,
          child: SizedBox(
            height: constraints.hasBoundedHeight ? constraints.maxHeight : null,
            child: content,
          ),
        );
      },
    ),
  );
}

/// Scrolls page sections lazily inside an [AppPageViewport].
///
/// Use this instead of a `SingleChildScrollView` and `Column` when a page has
/// enough independent sections for lazy layout to be useful.
final class AppPageList extends StatelessWidget {
  /// Page sections displayed in order.
  final List<Widget> children;

  /// Creates a lazily laid-out list of page sections.
  const AppPageList({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) => ListView(
    padding: const .all(AppSpacing.page),
    keyboardDismissBehavior: .onDrag,
    children: children,
  );
}
