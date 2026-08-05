// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads and persists the progress period selected by the user.

@ProviderFor(ProgressPeriodController)
final progressPeriodControllerProvider = ProgressPeriodControllerProvider._();

/// Loads and persists the progress period selected by the user.
final class ProgressPeriodControllerProvider extends $AsyncNotifierProvider<ProgressPeriodController, ProgressPeriod> {
  /// Loads and persists the progress period selected by the user.
  ProgressPeriodControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'progressPeriodControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$progressPeriodControllerHash();

  @$internal
  @override
  ProgressPeriodController create() => ProgressPeriodController();
}

String _$progressPeriodControllerHash() => r'008f73d94d78aa1a80e5ce37f2814c373d27ce18';

/// Loads and persists the progress period selected by the user.

abstract class _$ProgressPeriodController extends $AsyncNotifier<ProgressPeriod> {
  FutureOr<ProgressPeriod> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProgressPeriod>, ProgressPeriod>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<ProgressPeriod>, ProgressPeriod>, AsyncValue<ProgressPeriod>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

/// Watches the progress dashboard for the selected period.

@ProviderFor(progressDashboard)
final progressDashboardProvider = ProgressDashboardProvider._();

/// Watches the progress dashboard for the selected period.

final class ProgressDashboardProvider extends $FunctionalProvider<AsyncValue<ProgressDashboard>, ProgressDashboard, Stream<ProgressDashboard>>
    with $FutureModifier<ProgressDashboard>, $StreamProvider<ProgressDashboard> {
  /// Watches the progress dashboard for the selected period.
  ProgressDashboardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'progressDashboardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$progressDashboardHash();

  @$internal
  @override
  $StreamProviderElement<ProgressDashboard> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ProgressDashboard> create(Ref ref) {
    return progressDashboard(ref);
  }
}

String _$progressDashboardHash() => r'9d70dfba1f87158b939933cab0cc614cccfb3554';

/// Watches the durable answers recorded at the end of onboarding.

@ProviderFor(initialProfile)
final initialProfileProvider = InitialProfileProvider._();

/// Watches the durable answers recorded at the end of onboarding.

final class InitialProfileProvider extends $FunctionalProvider<AsyncValue<InitialProfile?>, InitialProfile?, Stream<InitialProfile?>>
    with $FutureModifier<InitialProfile?>, $StreamProvider<InitialProfile?> {
  /// Watches the durable answers recorded at the end of onboarding.
  InitialProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialProfileHash();

  @$internal
  @override
  $StreamProviderElement<InitialProfile?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<InitialProfile?> create(Ref ref) {
    return initialProfile(ref);
  }
}

String _$initialProfileHash() => r'59ca62c8c2a17ddb4490d05750a42ce2490d55dd';
