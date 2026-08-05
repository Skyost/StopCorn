import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/features/learning/domain/learning_library_item.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Promotes the current or next learning module from the Home screen.
final class LearningRecommendationCard extends StatelessWidget {
  /// Fallback size for icons embedded in the metadata line.
  static const double _metadataIconFallbackSize = 14;

  /// Module and persisted progress represented by this recommendation.
  final LearningLibraryItem item;

  /// Creates a recommendation for [item].
  const LearningRecommendationCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          item.module.title,
          style: context.theme.typography.display.lg.copyWith(
            fontWeight: .w700,
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        Text(item.module.summary),
        const SizedBox(height: AppSpacing.medium),
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  FLucideIcons.clock,
                  size: context.theme.typography.body.xs.fontSize ?? _metadataIconFallbackSize,
                  color: context.theme.colors.mutedForeground,
                ),
                alignment: .middle,
              ),
              TextSpan(
                text: ' ${context.t.app.minutes(count: item.module.estimatedMinutes)} · ',
              ),
              WidgetSpan(
                child: Icon(
                  FLucideIcons.bookOpen,
                  size: context.theme.typography.body.xs.fontSize ?? _metadataIconFallbackSize,
                  color: context.theme.colors.mutedForeground,
                ),
                alignment: .middle,
              ),
              TextSpan(
                text: ' ${context.t.app.moduleNumber(order: formatCount(item.module.order))}',
              ),
            ],
          ),
          style: context.theme.typography.body.xs.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
        const SizedBox(height: AppSpacing.big),
        AppButton(
          key: const Key('home_learning_recommendation_button'),
          variant: .secondary,
          onPress: () => context.push(AppRoutes.module(item.module.id)),
          child: Text(context.t.home.learningRecommendation.action),
        ),
      ],
    ),
  );
}
