import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/app_navigation.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/app_page.dart';
import 'package:stopcorn/app/widgets/app_switch_card.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/data_export/application/export_controller.dart';
import 'package:stopcorn/features/data_export/domain/export_view_state.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Guides the user through an explicit, voluntary local data export.
final class DataExportScreen extends ConsumerWidget {
  /// Creates the export screen.
  const DataExportScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ExportViewState state = ref.watch(exportControllerProvider);
    ExportController controller = ref.read(exportControllerProvider.notifier);
    return AppPage(
      title: Text(context.t.export.title),
      showBackButton: true,
      backFallbackLocation: AppRoutes.settings,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const Icon(
                  FLucideIcons.shieldAlert,
                  size: AppIconSize.display,
                ),
                const SizedBox(height: AppSpacing.big),
                Text(
                  context.t.export.warning.title,
                  style: context.theme.typography.display.lg.copyWith(
                    fontWeight: .w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.medium),
                Text(context.t.export.warning.sensitive),
                const SizedBox(height: AppSpacing.medium),
                Text(context.t.export.warning.share),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.big),
          AppSwitchCard(
            controlKey: const Key('export_confirmation_switch'),
            label: Text(context.t.export.confirm),
            value: state.isConfirmed,
            onChange: state.isExporting ? null : controller.setConfirmed,
          ),
          if (state.errorMessage != null) ...[
            const SizedBox(height: AppSpacing.big),
            AppCard(
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  const Icon(FLucideIcons.circleAlert),
                  const SizedBox(width: AppSpacing.medium),
                  Expanded(child: Text(state.errorMessage!)),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.section),
          AppActionButtons(
            primaryButtonKey: const Key('create_export_button'),
            secondaryButtonKey: const Key('data_export_back_button'),
            onPrimaryPress: !state.isConfirmed || state.isExporting ? null : controller.exportAndShare,
            primaryLabel: Text(
              state.isExporting ? context.t.export.create.progress : context.t.export.create.action,
            ),
            onSecondaryPress: state.isExporting ? null : () => popOrGo(context, AppRoutes.settings),
            secondaryLabel: Text(context.t.export.backSettings),
          ),
        ],
      ),
    );
  }
}
