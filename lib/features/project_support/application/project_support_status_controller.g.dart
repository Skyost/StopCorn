// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_support_status_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reports whether the supporter acknowledgement should be displayed.
///
/// The check is opt-in: as long as nobody has opened the support paywall,
/// StopCorn never contacts RevenueCat, so displaying Settings stays a purely
/// local operation. Opening the paywall already involves the store, and it is
/// also the only moment a purchase can exist, so it is what turns the check on
/// for later launches.

@ProviderFor(ProjectSupportStatusController)
final projectSupportStatusControllerProvider = ProjectSupportStatusControllerProvider._();

/// Reports whether the supporter acknowledgement should be displayed.
///
/// The check is opt-in: as long as nobody has opened the support paywall,
/// StopCorn never contacts RevenueCat, so displaying Settings stays a purely
/// local operation. Opening the paywall already involves the store, and it is
/// also the only moment a purchase can exist, so it is what turns the check on
/// for later launches.
final class ProjectSupportStatusControllerProvider extends $AsyncNotifierProvider<ProjectSupportStatusController, bool> {
  /// Reports whether the supporter acknowledgement should be displayed.
  ///
  /// The check is opt-in: as long as nobody has opened the support paywall,
  /// StopCorn never contacts RevenueCat, so displaying Settings stays a purely
  /// local operation. Opening the paywall already involves the store, and it is
  /// also the only moment a purchase can exist, so it is what turns the check on
  /// for later launches.
  ProjectSupportStatusControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectSupportStatusControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectSupportStatusControllerHash();

  @$internal
  @override
  ProjectSupportStatusController create() => ProjectSupportStatusController();
}

String _$projectSupportStatusControllerHash() => r'8dbcf02d9b138013492ed9c876577391228e1b98';

/// Reports whether the supporter acknowledgement should be displayed.
///
/// The check is opt-in: as long as nobody has opened the support paywall,
/// StopCorn never contacts RevenueCat, so displaying Settings stays a purely
/// local operation. Opening the paywall already involves the store, and it is
/// also the only moment a purchase can exist, so it is what turns the check on
/// for later launches.

abstract class _$ProjectSupportStatusController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<bool>, bool>, AsyncValue<bool>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
