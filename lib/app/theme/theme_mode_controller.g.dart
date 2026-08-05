// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads and persists the theme mode selected by the user.

@ProviderFor(ThemeModeController)
final themeModeControllerProvider = ThemeModeControllerProvider._();

/// Loads and persists the theme mode selected by the user.
final class ThemeModeControllerProvider extends $AsyncNotifierProvider<ThemeModeController, AppThemeMode> {
  /// Loads and persists the theme mode selected by the user.
  ThemeModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeControllerHash();

  @$internal
  @override
  ThemeModeController create() => ThemeModeController();
}

String _$themeModeControllerHash() => r'0861a8702a288b30cc60ca7fc92c9d99b7ec6a9a';

/// Loads and persists the theme mode selected by the user.

abstract class _$ThemeModeController extends $AsyncNotifier<AppThemeMode> {
  FutureOr<AppThemeMode> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppThemeMode>, AppThemeMode>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<AppThemeMode>, AppThemeMode>, AsyncValue<AppThemeMode>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
