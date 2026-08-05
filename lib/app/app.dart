import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:stopcorn/app/router.dart';
import 'package:stopcorn/app/theme/app_theme.dart';
import 'package:stopcorn/app/theme/theme_mode_controller.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/utils/platform.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Root widget that exposes Slang translations to the complete widget tree.
final class StopCornApp extends StatelessWidget {
  /// Creates the StopCorn application.
  const StopCornApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) => TranslationProvider(
    child: const _StopCornMaterialApp(),
  );
}

/// Builds the routed application for the selected locale and theme.
final class _StopCornMaterialApp extends ConsumerWidget {
  /// Creates the localized material application.
  const _StopCornMaterialApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<AppThemeMode> themePreference = ref.watch(themeModeControllerProvider);
    AppThemeMode appThemeMode = switch (themePreference) {
      AsyncData(:AppThemeMode value) => value,
      _ => .system,
    };
    GoRouter router = ref.watch(appRouterProvider);
    FThemeData light = defaultTargetPlatform.isDesktop ? appTheme.light.desktop : appTheme.light.touch;
    FThemeData dark = defaultTargetPlatform.isDesktop ? appTheme.dark.desktop : appTheme.dark.touch;
    return MaterialApp.router(
      title: context.t.app.name,
      debugShowCheckedModeBanner: false,
      locale: LocaleSettings.currentLocale.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        ...FLocalizations.localizationsDelegates,
      ],
      darkTheme: dark.toApproximateMaterialTheme(),
      theme: light.toApproximateMaterialTheme(),
      themeMode: switch (appThemeMode) {
        .system => .system,
        .light => .light,
        .dark => .dark,
      },
      themeAnimationDuration: const Duration(milliseconds: 180),
      routerConfig: router,
      builder: (context, child) {
        FThemeData foruiTheme = Theme.brightnessOf(context) == .dark ? dark : light;
        return FTheme(
          data: foruiTheme,
          child: FToaster(
            child: FTooltipGroup(child: child ?? const SizedBox.shrink()),
          ),
        );
      },
    );
  }
}
