import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/app/widgets/flame_icon.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_tile.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Shows the current harvest in the primary navigation header.
final class HarvestHeaderButton extends StatelessWidget {
  /// Locally derived harvest values displayed by the button and dialog.
  final HarvestSummary summary;

  /// Creates a compact, tappable harvest summary.
  const HarvestHeaderButton({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) => FHeaderAction(
    key: const Key('harvest_header_button'),
    semanticsLabel: '${context.t.harvest.cornPoints.title}: ${summary.grainCount}. ${context.t.harvest.momentum.currentMomentum(count: summary.currentMomentum)}',
    semanticsTooltip: context.t.harvest.label,
    onPress: () => showHarvestSummaryDialog(context, summary),
    icon: Row(
      mainAxisSize: .min,
      children: [
        const CornKernelIcon(),
        const SizedBox(width: AppSpacing.small),
        _Counter(value: summary.grainCount),
        const SizedBox(width: AppSpacing.medium),
        const FlameIcon(),
        const SizedBox(width: AppSpacing.small),
        _Counter(value: summary.currentMomentum),
      ],
    ),
  );
}

/// Opens the two harvest counters and their plain-language explanation.
Future<void> showHarvestSummaryDialog(
  BuildContext context,
  HarvestSummary summary,
) => showFDialog<void>(
  context: context,
  useRootNavigator: true,
  builder: (dialogContext, style, animation) => FDialog(
    key: const Key('harvest_summary_dialog'),
    animation: animation,
    semanticsLabel: dialogContext.t.harvest.label,
    builder: (contentContext, style) => SingleChildScrollView(
      child: Padding(
        padding: const .all(AppSpacing.page),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            Text(
              contentContext.t.harvest.label,
              style: contentContext.theme.typography.display.xl.copyWith(
                fontWeight: .w700,
              ),
            ),
            const SizedBox(height: AppSpacing.big),
            HarvestTile(
              summary: summary,
              showExplanationAction: false,
            ),
            const SizedBox(height: AppSpacing.big),
            AppButton(
              key: const Key('harvest_summary_information_button'),
              mainAxisSize: .min,
              variant: .ghost,
              onPress: () async {
                Navigator.of(contentContext).pop();
                await Future<void>.delayed(Duration.zero);
                if (!context.mounted) {
                  return;
                }
                showHarvestInformation(context);
              },
              child: Text(contentContext.t.harvest.explanationAction),
            ),
            const SizedBox(height: AppSpacing.medium),
            AppButton(
              key: const Key('harvest_summary_close_button'),
              onPress: () => Navigator.of(contentContext).pop(),
              child: Text(contentContext.t.app.close),
            ),
          ],
        ),
      ),
    ),
  ),
);

/// Typography shared by the two compact header totals.
final class _Counter extends StatelessWidget {
  /// Value displayed next to its harvest icon.
  final int value;

  /// Creates one compact header value.
  const _Counter({required this.value});

  @override
  Widget build(BuildContext context) => Text(
    value.toString(),
    style: context.theme.typography.body.sm.copyWith(
      fontWeight: .w700,
    ),
  );
}
