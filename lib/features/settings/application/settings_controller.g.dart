// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Coordinates persistent settings and dependent feature providers.

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

/// Coordinates persistent settings and dependent feature providers.
final class SettingsControllerProvider extends $AsyncNotifierProvider<SettingsController, SettingsViewState> {
  /// Coordinates persistent settings and dependent feature providers.
  SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();
}

String _$settingsControllerHash() => r'8049c78fd8cf707d2ba9484f4d43f110a848a373';

/// Coordinates persistent settings and dependent feature providers.

abstract class _$SettingsController extends $AsyncNotifier<SettingsViewState> {
  FutureOr<SettingsViewState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SettingsViewState>, SettingsViewState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<SettingsViewState>, SettingsViewState>, AsyncValue<SettingsViewState>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
