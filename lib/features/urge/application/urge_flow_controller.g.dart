// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urge_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns the end-to-end urge pause session.

@ProviderFor(UrgeFlowController)
final urgeFlowControllerProvider = UrgeFlowControllerProvider._();

/// Owns the end-to-end urge pause session.
final class UrgeFlowControllerProvider extends $NotifierProvider<UrgeFlowController, UrgeFlowState> {
  /// Owns the end-to-end urge pause session.
  UrgeFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'urgeFlowControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$urgeFlowControllerHash();

  @$internal
  @override
  UrgeFlowController create() => UrgeFlowController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UrgeFlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UrgeFlowState>(value),
    );
  }
}

String _$urgeFlowControllerHash() => r'4609acc892901be78c1e62275792cd18d7c899b0';

/// Owns the end-to-end urge pause session.

abstract class _$UrgeFlowController extends $Notifier<UrgeFlowState> {
  UrgeFlowState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UrgeFlowState, UrgeFlowState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<UrgeFlowState, UrgeFlowState>, UrgeFlowState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
