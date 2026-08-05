// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bootstrap.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Verifies local resources and prepares seed data before the first route.

@ProviderFor(BootstrapController)
final bootstrapControllerProvider = BootstrapControllerProvider._();

/// Verifies local resources and prepares seed data before the first route.
final class BootstrapControllerProvider extends $AsyncNotifierProvider<BootstrapController, BootstrapData> {
  /// Verifies local resources and prepares seed data before the first route.
  BootstrapControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bootstrapControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bootstrapControllerHash();

  @$internal
  @override
  BootstrapController create() => BootstrapController();
}

String _$bootstrapControllerHash() => r'00f0bd5483d29047a9432efb0b106386b5b076da';

/// Verifies local resources and prepares seed data before the first route.

abstract class _$BootstrapController extends $AsyncNotifier<BootstrapData> {
  FutureOr<BootstrapData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BootstrapData>, BootstrapData>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<BootstrapData>, BootstrapData>, AsyncValue<BootstrapData>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
