import 'package:flutter/material.dart' show SelectionArea;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_sheet.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/app/widgets/async_states.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/settings/application/licenses_provider.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Lists license notices bundled with the application.
final class LicensesScreen extends ConsumerWidget {
  /// Creates the open-source licenses screen.
  const LicensesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<OpenSourceLicense>> licenses = ref.watch(
      openSourceLicensesProvider,
    );
    return AppPage(
      title: Text(context.t.licenses.title),
      showBackButton: true,
      backFallbackLocation: AppRoutes.settings,
      scrollable: false,
      child: Padding(
        padding: context.theme.style.pagePadding,
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            AppSubtitle(text: context.t.licenses.intro),
            const SizedBox(height: AppSpacing.big),
            Expanded(
              child: licenses.when(
                loading: () => const AsyncStatePanel(child: LoadingState()),
                error: (error, _) => AsyncStatePanel(
                  child: ErrorState(
                    message: context.t.licenses.loadError,
                    error: error,
                    onRetry: () => ref.invalidate(openSourceLicensesProvider),
                  ),
                ),
                data: (items) => FTileGroup.builder(
                  count: items.length,
                  tileBuilder: (context, index) {
                    OpenSourceLicense item = items[index];
                    return FTile(
                      title: Text(item.title),
                      suffix: const Icon(FLucideIcons.chevronRight),
                      onPress: () => _showLicense(context, item),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Opens the full text of [license] in a bottom sheet.
Future<void> _showLicense(BuildContext context, OpenSourceLicense license) => showAppSheet<void>(
  context: context,
  builder: (sheetContext) => Column(
    crossAxisAlignment: .stretch,
    children: [
      Text(
        license.title,
        style: sheetContext.theme.typography.display.lg.copyWith(
          fontWeight: .w700,
        ),
      ),
      const SizedBox(height: AppSpacing.big),
      SelectionArea(child: Text(license.text)),
      const SizedBox(height: AppSpacing.section),
      AppButton(
        onPress: () => Navigator.of(sheetContext).pop(),
        child: Text(sheetContext.t.app.close),
      ),
    ],
  ),
);
