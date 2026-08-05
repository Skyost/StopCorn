import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/features/urge/application/urge_flow_controller.dart';

/// Intercepts system back navigation to close the active urge session safely.
final class UrgeGuard extends ConsumerWidget {
  /// Protected flow screen.
  final Widget child;

  /// Creates a back-navigation guard around [child].
  const UrgeGuard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) async {
      if (!didPop) {
        await quitUrgeFlow(context, ref);
      }
    },
    child: child,
  );
}

/// Abandons the active urge flow before navigating home.
Future<void> quitUrgeFlow(BuildContext context, WidgetRef ref, {bool abandon = true}) async {
  if (abandon) {
    await ref.read(urgeFlowControllerProvider.notifier).abandonSession();
  } else {
    ref.read(urgeFlowControllerProvider.notifier).reset();
  }
  if (context.mounted) {
    context.go(AppRoutes.home);
  }
}
