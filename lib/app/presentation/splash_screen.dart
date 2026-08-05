import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/bootstrap.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Displays local bootstrap progress before routing is ready.
final class SplashScreen extends ConsumerWidget {
  /// Creates the splash screen.
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<BootstrapData> bootstrap = ref.watch(bootstrapControllerProvider);
    return ColoredBox(
      color: context.theme.colors.background,
      child: SafeArea(
        child: Padding(
          padding: const .all(AppSpacing.page),
          child: bootstrap.when(
            data: (_) => const LoadingState(),
            loading: () => Center(
              child: Column(
                mainAxisSize: .min,
                children: [
                  const CornBrandMark(
                    size: AppIconSize.brand,
                  ),
                  const SizedBox(height: AppSpacing.section),
                  LoadingState(label: context.t.app.splash.preparing),
                ],
              ),
            ),
            error: (error, _) => ErrorState(
              message: context.t.app.splash.error,
              error: error,
              onRetry: () => ref.read(bootstrapControllerProvider.notifier).retry(),
            ),
          ),
        ),
      ),
    );
  }
}
