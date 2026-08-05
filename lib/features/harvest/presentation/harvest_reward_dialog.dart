import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/app/widgets/flame_icon.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/harvest/application/harvest_providers.dart';
import 'package:stopcorn/features/harvest/domain/harvest_reward.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Persists [action] and celebrates a Corn point earned by that exact action.
Future<bool> runWithHarvestReward(
  BuildContext context,
  WidgetRef ref,
  Future<bool> Function() action,
) => _runWithHarvestReward(
  context,
  ref,
  action,
  policy: .cultivatedDay,
);

/// Runs a debug action that may grant a point outside the daily limit.
Future<bool> runWithDebugHarvestReward(
  BuildContext context,
  WidgetRef ref,
  Future<bool> Function() action,
) => _runWithHarvestReward(
  context,
  ref,
  action,
  policy: .debugBonus,
);

/// Applies [policy], then presents the shared reward dialog when appropriate.
Future<bool> _runWithHarvestReward(
  BuildContext context,
  WidgetRef ref,
  Future<bool> Function() action, {
  required HarvestRewardPolicy policy,
}) async {
  HarvestActionResult result = await ref.read(harvestRewardServiceProvider).run(action, policy: policy);
  HarvestReward? reward = result.reward;
  if (reward != null && context.mounted) {
    await showHarvestRewardDialog(context, reward);
  }
  return result.succeeded;
}

/// Shows the compact animated harvest celebration for [reward].
Future<void> showHarvestRewardDialog(
  BuildContext context,
  HarvestReward reward,
) => showFDialog<void>(
  context: context,
  barrierDismissible: false,
  useRootNavigator: true,
  useSafeArea: true,
  builder: (dialogContext, style, animation) => FDialog(
    key: const Key('harvest_reward_dialog'),
    animation: animation,
    semanticsLabel: dialogContext.t.harvest.reward.title,
    builder: (contentContext, style) => SingleChildScrollView(
      child: Padding(
        padding: const .all(AppSpacing.page),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            Text(
              contentContext.t.harvest.reward.title,
              textAlign: .center,
              style: contentContext.theme.typography.display.xl.copyWith(
                fontWeight: .w700,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Text(
              contentContext.t.harvest.reward.body,
              textAlign: .center,
            ),
            const SizedBox(height: AppSpacing.section),
            _RewardCounter(
              valueKey: const Key('harvest_reward_points_value'),
              label: contentContext.t.harvest.cornPoints.title,
              semanticsLabel: contentContext.t.harvest.reward.pointsSemantics(
                gain: reward.pointDelta,
                total: reward.pointsAfter,
              ),
              before: reward.pointsBefore,
              after: reward.pointsAfter,
              icon: const CornKernelIcon(size: AppIconSize.display),
            ),
            if (reward.momentumDelta > 0) ...[
              const SizedBox(height: AppSpacing.big),
              _RewardCounter(
                valueKey: const Key('harvest_reward_momentum_value'),
                label: contentContext.t.harvest.momentum.title,
                semanticsLabel: contentContext.t.harvest.reward.momentumSemantics(
                  gain: reward.momentumDelta,
                  total: reward.momentumAfter,
                ),
                before: reward.momentumBefore,
                after: reward.momentumAfter,
                icon: const FlameIcon(size: AppIconSize.display),
                delay: 0.14,
              ),
            ],
            const SizedBox(height: AppSpacing.section),
            AppButton(
              key: const Key('harvest_reward_close_button'),
              onPress: () => Navigator.of(contentContext).pop(),
              child: Text(
                contentContext.t.harvest.reward.continueAction,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

/// Animates one reward total from its previous value to its new value.
final class _RewardCounter extends StatelessWidget {
  /// Key attached to the changing numeric total.
  final Key valueKey;

  /// Human-readable counter name.
  final String label;

  /// Final-value announcement for assistive technologies.
  final String semanticsLabel;

  /// Counter value before the action.
  final int before;

  /// Counter value after the action.
  final int after;

  /// Decorative reward icon.
  final Widget icon;

  /// Fraction of the animation reserved before this counter begins.
  final double delay;

  /// Creates an animated counter transition.
  const _RewardCounter({
    required this.valueKey,
    required this.label,
    required this.semanticsLabel,
    required this.before,
    required this.after,
    required this.icon,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    bool reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Semantics(
      liveRegion: true,
      label: semanticsLabel,
      child: ExcludeSemantics(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: reduceMotion ? Duration.zero : AppMotion.rewardCounter,
          builder: (context, animation, child) {
            double progress = delay == 0 ? animation : ((animation - delay) / (1 - delay)).clamp(0, 1);
            double countProgress = Curves.easeOutCubic.transform(progress);
            double arrival = Curves.elasticOut.transform(progress);
            int value = before + ((after - before) * countProgress).round();
            double gainOpacity = Curves.easeOut.transform(
              ((progress - 0.3) / 0.7).clamp(0, 1),
            );
            return Transform.scale(
              scale: 0.94 + (0.06 * arrival),
              child: AppCard(
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 0.78 + (0.22 * arrival),
                      child: icon,
                    ),
                    const SizedBox(width: AppSpacing.big),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            label,
                            style: context.theme.typography.body.sm.copyWith(
                              color: context.theme.colors.mutedForeground,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.small),
                          Row(
                            children: [
                              Text(
                                value.toString(),
                                key: valueKey,
                                style: context.theme.typography.display.xl.copyWith(
                                  fontWeight: .w700,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.medium),
                              Opacity(
                                opacity: gainOpacity,
                                child: Text(
                                  context.t.harvest.reward.gain(
                                    count: after - before,
                                  ),
                                  style: context.theme.typography.body.lg.copyWith(
                                    color: context.theme.colors.primary,
                                    fontWeight: .w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
