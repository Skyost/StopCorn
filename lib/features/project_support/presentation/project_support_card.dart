import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/app/widgets/corn_brand_mark.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/features/project_support/application/project_support_service.dart';
import 'package:stopcorn/features/project_support/application/project_support_status_controller.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Introduces the free project and provides its public and support links.
final class ProjectSupportCard extends ConsumerStatefulWidget {
  /// Whether debug tooling should force the supporter thank-you note.
  final bool debugShowThanks;

  /// Creates the card displayed at the top of Settings.
  const ProjectSupportCard({
    super.key,
    this.debugShowThanks = false,
  });

  @override
  ConsumerState<ProjectSupportCard> createState() => _ProjectSupportCardState();
}

/// Coordinates external links and the optional native support paywall.
final class _ProjectSupportCardState extends ConsumerState<ProjectSupportCard> {
  /// Whether one external action is currently running.
  bool _busy = false;

  /// Whether the optional project details are currently visible.
  bool _expanded = true;

  @override
  Widget build(BuildContext context) => AppCard(
    key: const Key('project_support_card'),
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          crossAxisAlignment: .center,
          children: [
            const CornBrandMark(size: 56),
            const SizedBox(width: AppSpacing.big),
            Expanded(
              child: Text(
                context.t.settings.support.title,
                style: context.theme.typography.display.lg.copyWith(
                  fontWeight: .w700,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            FButton.icon(
              key: const Key('project_support_collapse_button'),
              variant: .ghost,
              size: .sm,
              onPress: () => setState(() => _expanded = !_expanded),
              semanticsLabel: _expanded ? context.t.settings.support.collapseAction : context.t.settings.support.expandAction,
              semanticsTooltip: _expanded ? context.t.settings.support.collapseAction : context.t.settings.support.expandAction,
              child: Icon(
                _expanded ? FLucideIcons.chevronUp : FLucideIcons.chevronDown,
              ),
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          alignment: .topCenter,
          child: _expanded
              ? Column(
                  key: const Key('project_support_details'),
                  crossAxisAlignment: .stretch,
                  children: [
                    const SizedBox(height: AppSpacing.big),
                    Text(context.t.settings.support.body),
                    const SizedBox(height: AppSpacing.big),
                    _ProjectValues(
                      labels: [
                        context.t.settings.support.values.free,
                        context.t.settings.support.values.openSource,
                        context.t.settings.support.values.noAds,
                        context.t.settings.support.values.noTracking,
                      ],
                    ),
                    const SizedBox(height: AppSpacing.big),
                    Text(context.t.settings.support.contribution),
                    const SizedBox(height: AppSpacing.big),
                    AppButton(
                      key: const Key('project_support_paywall_button'),
                      onPress: _busy ? null : _presentPaywall,
                      prefix: const Icon(FLucideIcons.heartHandshake),
                      suffix: const Icon(FLucideIcons.chevronRight),
                      child: Text(context.t.settings.support.supportAction),
                    ),
                    if (widget.debugShowThanks || ref.watch(projectSupportStatusControllerProvider).value == true)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.medium),
                        child: Text(
                          key: const Key('project_support_thanks_note'),
                          context.t.settings.support.thanks,
                          textAlign: .center,
                          style: context.theme.typography.body.sm.copyWith(
                            color: context.theme.colors.mutedForeground,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.big),
                    _ProjectLinkButtons(
                      busy: _busy,
                      onOpenSource: () => _openLink(
                        ref.read(projectSupportServiceProvider).openSourceCode,
                      ),
                      onOpenWebsite: () => _openLink(
                        ref.read(projectSupportServiceProvider).openWebsite,
                      ),
                    ),
                  ],
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    ),
  );

  /// Presents the current RevenueCat offering and reports its outcome.
  ///
  /// Opening the paywall is the explicit gesture that allows later supporter
  /// checks, so the preference is stored before the store is reached.
  Future<void> _presentPaywall() => _run(() async {
    ProjectSupportStatusController status = ref.read(
      projectSupportStatusControllerProvider.notifier,
    );
    await status.allowChecks();
    ProjectSupportPaywallResult result = await ref.read(projectSupportServiceProvider).presentPaywall();
    if (!mounted) {
      return;
    }
    switch (result) {
      case .purchased || .restored:
        await status.refresh();
        if (!mounted) {
          return;
        }
        showFToast(
          context: context,
          icon: const Icon(FLucideIcons.heartHandshake),
          title: Text(context.t.settings.support.thanks),
        );
        break;
      case .cancelled:
        break;
      case .unavailable:
        _showError(context.t.settings.support.error.notConfigured);
        break;
      case .error:
        _showError(context.t.settings.support.error.paywall);
        break;
    }
  });

  /// Opens one public link and displays a recoverable failure when needed.
  Future<void> _openLink(Future<bool> Function() open) => _run(() async {
    bool opened = await open();
    if (!opened && mounted) {
      _showError(context.t.settings.support.error.link);
    }
  });

  /// Runs one card action while preventing accidental duplicate activation.
  Future<void> _run(Future<void> Function() action) async {
    if (_busy) {
      return;
    }
    setState(() => _busy = true);
    try {
      await action();
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  /// Displays an accessible destructive toast containing [message].
  void _showError(String message) => showFToast(
    context: context,
    variant: .destructive,
    icon: const Icon(FLucideIcons.circleAlert),
    title: Text(message),
  );
}

/// Lays out the four project values in one or two aligned columns.
final class _ProjectValues extends StatelessWidget {
  /// Labels displayed in reading order.
  final List<String> labels;

  /// Creates the responsive project-value list.
  const _ProjectValues({
    required this.labels,
  }) : assert(labels.length == 4);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      List<Widget> values = [
        for (final String label in labels) _ProjectValue(label: label),
      ];
      if (constraints.maxWidth < 280) {
        return Column(
          crossAxisAlignment: .stretch,
          children: [
            for (int index = 0; index < values.length; index++) ...[
              if (index > 0) const SizedBox(height: AppSpacing.medium),
              values[index],
            ],
          ],
        );
      }
      return Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(child: values[0]),
              const SizedBox(width: AppSpacing.big),
              Expanded(child: values[1]),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(child: values[2]),
              const SizedBox(width: AppSpacing.big),
              Expanded(child: values[3]),
            ],
          ),
        ],
      );
    },
  );
}

/// Compact project value such as free, open source, or tracker-free.
final class _ProjectValue extends StatelessWidget {
  /// Localized value label.
  final String label;

  /// Creates one checked value label.
  const _ProjectValue({
    required this.label,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(
        FLucideIcons.circleCheck,
        size: 16,
        color: context.theme.colors.primary,
      ),
      const SizedBox(width: AppSpacing.small),
      Flexible(
        child: Text(
          label,
          style: context.theme.typography.body.sm.copyWith(
            fontWeight: .w600,
          ),
        ),
      ),
    ],
  );
}

/// Responsive source-code and website buttons.
final class _ProjectLinkButtons extends StatelessWidget {
  /// Whether both links are temporarily disabled.
  final bool busy;

  /// Opens the public source-code repository.
  final VoidCallback onOpenSource;

  /// Opens the public project website.
  final VoidCallback onOpenWebsite;

  /// Creates the pair of external link buttons.
  const _ProjectLinkButtons({
    required this.busy,
    required this.onOpenSource,
    required this.onOpenWebsite,
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      Widget source = AppButton(
        key: const Key('project_source_link_button'),
        variant: .outline,
        onPress: busy ? null : onOpenSource,
        prefix: const Icon(FLucideIcons.codeXml),
        suffix: const Icon(FLucideIcons.externalLink),
        child: Text(context.t.settings.support.sourceAction),
      );
      Widget website = AppButton(
        key: const Key('project_website_link_button'),
        variant: .outline,
        onPress: busy ? null : onOpenWebsite,
        prefix: const Icon(FLucideIcons.globe),
        suffix: const Icon(FLucideIcons.externalLink),
        child: Text(context.t.settings.support.websiteAction),
      );
      if (constraints.maxWidth < 420) {
        return Column(
          crossAxisAlignment: .stretch,
          children: [
            source,
            const SizedBox(height: AppSpacing.medium),
            website,
          ],
        );
      }
      return Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(child: source),
          const SizedBox(width: AppSpacing.medium),
          Expanded(child: website),
        ],
      );
    },
  );
}
