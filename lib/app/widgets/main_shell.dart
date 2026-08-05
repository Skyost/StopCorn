import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/app_routes.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';
import 'package:stopcorn/features/harvest/application/harvest_providers.dart';
import 'package:stopcorn/features/harvest/domain/harvest_summary.dart';
import 'package:stopcorn/features/harvest/presentation/harvest_header_button.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Provides the four primary destinations and their shared layout.
final class MainShell extends ConsumerWidget {
  /// Current router location.
  final String location;

  /// Active destination content.
  final Widget child;

  /// Creates the shell around [child] for the current [location].
  const MainShell({
    super.key,
    required this.location,
    required this.child,
  });

  /// The route matching [location].
  _Route get _route {
    if (location.startsWith(AppRoutes.progress)) {
      return _Route.progress;
    }
    if (location.startsWith(AppRoutes.learn)) {
      return _Route.learn;
    }
    if (location.startsWith(AppRoutes.settings)) {
      return _Route.settings;
    }
    return _Route.home;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool showHarvest = ref.watch(harvestVisibilityProvider).value ?? false;
    HarvestSummary? harvest = showHarvest ? ref.watch(harvestSummaryProvider).value : null;
    return FScaffold(
      childPad: false,
      header: FHeader(
        title: switch (_route) {
          _Route.home => Text.rich(
            TextSpan(
              text: '${context.t.navigation.home.title} ',
              children: [
                WidgetSpan(
                  child: SvgPicture.asset(
                    'assets/images/waving-hand.svg',
                    height: context.theme.typography.display.xl3.fontSize,
                    fit: .contain,
                  ),
                  alignment: .middle,
                ),
              ],
            ),
          ),
          _Route.progress => Text(context.t.navigation.progress),
          _Route.learn => Text(context.t.navigation.learn),
          _Route.settings => Text(context.t.navigation.settings),
        },
        suffixes: [
          if (harvest != null && _route != .settings) HarvestHeaderButton(summary: harvest),
        ],
      ),
      footer: FBottomNavigationBar(
        index: _route.index,
        onChange: (index) => context.go(
          AppRoutes.primaryDestinations[index],
        ),
        children: [
          FBottomNavigationBarItem(
            icon: const Icon(FLucideIcons.house),
            label: Text(context.t.navigation.home.item),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FLucideIcons.chartNoAxesCombined),
            label: Text(context.t.navigation.progress),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FLucideIcons.bookOpen),
            label: Text(context.t.navigation.learn),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FLucideIcons.settings),
            label: Text(context.t.navigation.settings),
          ),
        ],
      ),
      child: AppPageViewport(
        scrollable: false,
        safeAreaBottom: false,
        child: child,
      ),
    );
  }
}

enum _Route {
  home,
  progress,
  learn,
  settings,
}
