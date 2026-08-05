// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Watches the localized learning library and its persisted progress.

@ProviderFor(learningLibrary)
final learningLibraryProvider = LearningLibraryProvider._();

/// Watches the localized learning library and its persisted progress.

final class LearningLibraryProvider extends $FunctionalProvider<AsyncValue<List<LearningLibraryItem>>, List<LearningLibraryItem>, Stream<List<LearningLibraryItem>>>
    with $FutureModifier<List<LearningLibraryItem>>, $StreamProvider<List<LearningLibraryItem>> {
  /// Watches the localized learning library and its persisted progress.
  LearningLibraryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningLibraryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningLibraryHash();

  @$internal
  @override
  $StreamProviderElement<List<LearningLibraryItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<LearningLibraryItem>> create(Ref ref) {
    return learningLibrary(ref);
  }
}

String _$learningLibraryHash() => r'229fae804d5f81dd165e2fb7d6b6e5cc9d80d22c';

/// Coordinates module reading position, reflection, and completion.

@ProviderFor(ModuleController)
final moduleControllerProvider = ModuleControllerFamily._();

/// Coordinates module reading position, reflection, and completion.
final class ModuleControllerProvider extends $AsyncNotifierProvider<ModuleController, ModuleViewState> {
  /// Coordinates module reading position, reflection, and completion.
  ModuleControllerProvider._({
    required ModuleControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'moduleControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$moduleControllerHash();

  @override
  String toString() {
    return r'moduleControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ModuleController create() => ModuleController();

  @override
  bool operator ==(Object other) {
    return other is ModuleControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$moduleControllerHash() => r'8f6db2ea3e680cf0630ac3489bba7ae22aaff119';

/// Coordinates module reading position, reflection, and completion.

final class ModuleControllerFamily extends $Family with $ClassFamilyOverride<ModuleController, AsyncValue<ModuleViewState>, ModuleViewState, FutureOr<ModuleViewState>, String> {
  ModuleControllerFamily._()
    : super(
        retry: null,
        name: r'moduleControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Coordinates module reading position, reflection, and completion.

  ModuleControllerProvider call(String moduleId) => ModuleControllerProvider._(argument: moduleId, from: this);

  @override
  String toString() => r'moduleControllerProvider';
}

/// Coordinates module reading position, reflection, and completion.

abstract class _$ModuleController extends $AsyncNotifier<ModuleViewState> {
  late final _$args = ref.$arg as String;
  String get moduleId => _$args;

  FutureOr<ModuleViewState> build(String moduleId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ModuleViewState>, ModuleViewState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<ModuleViewState>, ModuleViewState>, AsyncValue<ModuleViewState>, Object?, Object?>;
    return element.handleCreate(ref, () => build(_$args));
  }
}
