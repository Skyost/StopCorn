// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the database-backed onboarding repository.

@ProviderFor(onboardingRepository)
final onboardingRepositoryProvider = OnboardingRepositoryProvider._();

/// Provides the database-backed onboarding repository.

final class OnboardingRepositoryProvider extends $FunctionalProvider<OnboardingRepository, OnboardingRepository, OnboardingRepository> with $Provider<OnboardingRepository> {
  /// Provides the database-backed onboarding repository.
  OnboardingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingRepositoryHash();

  @$internal
  @override
  $ProviderElement<OnboardingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingRepository create(Ref ref) {
    return onboardingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingRepository>(value),
    );
  }
}

String _$onboardingRepositoryHash() => r'ce087353584b9a17b05c2e28720feb9660692700';
