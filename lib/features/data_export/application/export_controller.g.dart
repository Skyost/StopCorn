// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Coordinates explicit confirmation and creation of a local export.

@ProviderFor(ExportController)
final exportControllerProvider = ExportControllerProvider._();

/// Coordinates explicit confirmation and creation of a local export.
final class ExportControllerProvider extends $NotifierProvider<ExportController, ExportViewState> {
  /// Coordinates explicit confirmation and creation of a local export.
  ExportControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exportControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exportControllerHash();

  @$internal
  @override
  ExportController create() => ExportController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExportViewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExportViewState>(value),
    );
  }
}

String _$exportControllerHash() => r'f185fc3572f97853c23fb687ede1b5236d3ba1c1';

/// Coordinates explicit confirmation and creation of a local export.

abstract class _$ExportController extends $Notifier<ExportViewState> {
  ExportViewState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ExportViewState, ExportViewState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<ExportViewState, ExportViewState>, ExportViewState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
