import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';

/// Displays a consistently styled section title and reserves space below it.
final class AppSectionHeader extends StatelessWidget {
  /// Section title.
  final Widget title;

  /// Optional explanation displayed below [title].
  final Widget? subtitle;

  /// Optional leading icon, primarily used by settings sections.
  final IconData? icon;

  /// Creates a section header with shared bottom spacing.
  const AppSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .only(bottom: AppSpacing.section),
    child: Row(
      crossAxisAlignment: .start,
      children: [
        if (icon != null) ...[
          Padding(
            padding: EdgeInsets.only(top: (context.theme.typography.display.lg.fontSize ?? 0) / 7.5),
            child: Icon(icon),
          ),
          const SizedBox(width: AppSpacing.medium),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              DefaultTextStyle.merge(
                style: context.theme.typography.display.lg.copyWith(
                  fontWeight: .w700,
                ),
                child: title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.small),
                AppSubtitle.raw(child: subtitle!),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
