import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app_navigation.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';

/// Standard routed page with a header and responsive readable content.
final class AppPage extends StatelessWidget {
  /// Header title.
  final Widget title;

  /// Page content.
  final Widget child;

  /// Optional scaffold footer.
  final Widget? footer;

  /// Whether the page supplies its own scrolling.
  final bool scrollable;

  /// Whether to show a back button.
  final bool showBackButton;

  /// Optional callback for when the back button is pressed.
  final VoidCallback? onBackButtonPressed;

  /// Destination used when this page was opened without a route to pop.
  final String? backFallbackLocation;

  /// Creates a page titled [title].
  const AppPage({
    super.key,
    required this.title,
    required this.child,
    this.footer,
    this.scrollable = true,
    this.showBackButton = false,
    this.onBackButtonPressed,
    this.backFallbackLocation,
  }) : assert(
         !showBackButton || onBackButtonPressed != null || backFallbackLocation != null,
         'A page with a back button needs a callback or fallback location.',
       );

  @override
  Widget build(BuildContext context) {
    String? fallbackLocation = backFallbackLocation;
    VoidCallback? backAction = onBackButtonPressed ?? (fallbackLocation == null ? null : () => popOrGo(context, fallbackLocation));

    return FScaffold(
      childPad: false,
      header: showBackButton
          ? FHeader.nested(
              title: title,
              prefixes: [
                FHeaderAction.x(
                  key: const Key('app_page_back_button'),
                  onPress: backAction,
                ),
              ],
            )
          : FHeader(
              title: title,
            ),
      footer: footer,
      child: AppPageViewport(
        scrollable: scrollable,
        // A footer owns the bottom safe area itself. Applying it to the page
        // content as well would leave an unnecessary gap above the footer.
        safeAreaBottom: footer == null,
        child: child,
      ),
    );
  }
}
