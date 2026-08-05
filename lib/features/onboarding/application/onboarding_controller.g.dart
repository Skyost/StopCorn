// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns the resumable onboarding draft and its persistence.

@ProviderFor(OnboardingController)
final onboardingControllerProvider = OnboardingControllerProvider._();

/// Owns the resumable onboarding draft and its persistence.
final class OnboardingControllerProvider extends $AsyncNotifierProvider<OnboardingController, OnboardingViewState> {
  /// Owns the resumable onboarding draft and its persistence.
  OnboardingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingControllerHash();

  @$internal
  @override
  OnboardingController create() => OnboardingController();
}

String _$onboardingControllerHash() => r'3a572b12fa19c76a795ca65ae765115522613349';

/// Owns the resumable onboarding draft and its persistence.

abstract class _$OnboardingController extends $AsyncNotifier<OnboardingViewState> {
  FutureOr<OnboardingViewState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<OnboardingViewState>, OnboardingViewState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<OnboardingViewState>, OnboardingViewState>, AsyncValue<OnboardingViewState>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
