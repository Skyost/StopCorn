import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/project_support/application/project_support_service.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Loads the package version only when the lazy About section is mounted.
final class AppVersionSubtitle extends StatelessWidget {
  /// Creates the lazily loaded version subtitle.
  const AppVersionSubtitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: PackageInfo.fromPlatform(),
    builder: (context, asyncSnapshot) => asyncSnapshot.hasData
        ? Text(
            context.t.settings.about.version(
              version: asyncSnapshot.data!.version,
            ),
          )
        : const SizedBox.shrink(),
  );
}

/// Shows an explanation of local data storage.
Future<void> showStorageInformation(BuildContext context) => _showInformationDialog(
  context,
  title: Text(context.t.settings.data.stored.title),
  paragraphs: [
    context.t.settings.data.stored.body1,
    context.t.settings.data.stored.body2,
    context.t.settings.data.stored.body3,
  ],
);

/// Shows application version and purpose information.
Future<void> showAbout(BuildContext context) => _showInformationDialog(
  context,
  logo: const CornBrandMark(),
  title: Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: context.t.app.name,
        ),
        WidgetSpan(
          child: FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, asyncSnapshot) => asyncSnapshot.hasData ? Text(' v${asyncSnapshot.data!.version}') : const SizedBox.shrink(),
          ),
          alignment: .baseline,
          baseline: .alphabetic,
        ),
      ],
    ),
    textAlign: .center,
    style: context.theme.typography.display.lg.copyWith(
      fontWeight: .w700,
    ),
  ),
  paragraphs: [
    context.t.settings.about.body,
    context.t.app.notMedicalDisclaimer,
  ],
);

/// Shows the application privacy commitments and its public policy link.
Future<void> showPrivacy(BuildContext context, WidgetRef ref) => _showInformationDialog(
  context,
  title: Text(context.t.settings.about.privacy.title),
  paragraphs: [
    context.t.settings.about.privacy.body1,
    context.t.settings.about.privacy.body2,
    context.t.settings.about.privacy.body3,
    context.t.settings.about.privacy.body5,
    context.t.settings.about.privacy.body4,
  ],
  secondaryAction: AppButton(
    key: const Key('privacy_policy_link_button'),
    variant: .outline,
    suffix: const Icon(FLucideIcons.externalLink),
    onPress: () => _openPrivacyPolicy(context, ref),
    child: Text(context.t.settings.about.privacy.policyAction),
  ),
);

/// Shows guidance about seeking professional support.
Future<void> showProfessionalHelp(BuildContext context) => _showInformationDialog(
  context,
  title: Text(context.t.settings.about.help.title),
  paragraphs: [
    context.t.settings.about.help.body1,
    context.t.settings.about.help.body2,
    context.t.settings.about.help.body3,
  ],
);

/// Opens the privacy policy and reports a recoverable browser failure.
Future<void> _openPrivacyPolicy(BuildContext context, WidgetRef ref) async {
  bool opened = await ref.read(projectSupportServiceProvider).openPrivacyPolicy();
  if (!opened && context.mounted) {
    showFToast(
      context: context,
      variant: .destructive,
      icon: const Icon(FLucideIcons.circleAlert),
      title: Text(context.t.settings.about.privacy.policyError),
    );
  }
}

/// Shows a standard informational dialog containing [paragraphs].
Future<void> _showInformationDialog(
  BuildContext context, {
  Widget? logo,
  required Text title,
  required List<String> paragraphs,
  Widget? secondaryAction,
}) => showFDialog<void>(
  context: context,
  useRootNavigator: true,
  useSafeArea: true,
  builder: (dialogContext, style, animation) => FDialog(
    animation: animation,
    semanticsLabel: title.data,
    builder: (contentContext, style) => Padding(
      padding: const .all(AppSpacing.page),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            if (logo != null) ...[
              logo,
              const SizedBox(height: AppSpacing.medium),
            ],
            DefaultTextStyle(
              style: contentContext.theme.typography.display.lg.copyWith(
                fontWeight: .w700,
              ),
              child: title,
            ),
            for (final String paragraph in paragraphs) ...[
              const SizedBox(height: AppSpacing.big),
              Text(paragraph),
            ],
            const SizedBox(height: AppSpacing.section),
            if (secondaryAction != null) ...[
              secondaryAction,
              const SizedBox(height: AppSpacing.medium),
            ],
            AppButton(
              onPress: () => Navigator.of(contentContext).pop(),
              child: Text(contentContext.t.app.close),
            ),
          ],
        ),
      ),
    ),
  ),
);
