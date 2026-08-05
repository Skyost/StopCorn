import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/learning/data/learning_repository.dart';
import 'package:stopcorn/features/learning/domain/learning_catalog.dart';
import 'package:stopcorn/features/learning/domain/learning_library_item.dart';
import 'package:stopcorn/features/learning/domain/module_view_state.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'module_controller.g.dart';

/// Watches the localized learning library and its persisted progress.
@riverpod
Stream<List<LearningLibraryItem>> learningLibrary(Ref ref) => ref.watch(learningRepositoryProvider).watchLibrary();

/// Coordinates module reading position, reflection, and completion.
@riverpod
final class ModuleController extends _$ModuleController {
  @override
  Future<ModuleViewState> build(String moduleId) async {
    LearningRepository repository = ref.read(learningRepositoryProvider);
    LearningModule? module = await repository.getModule(moduleId);
    if (module == null) {
      throw StateError(t.learning.module.loadError);
    }
    ModuleProgressData progress = await repository.startModule(
      moduleId: moduleId,
      now: ref.read(appClockProvider).now(),
    );
    bool completed = progress.completedAt != null && !progress.isReviewing;
    int savedIndex = completed ? module.sections.length : progress.lastSectionIndex.clamp(0, module.sections.length - 1);
    return ModuleViewState(
      module: module,
      sectionIndex: savedIndex,
      reflectionText: progress.reflectionText ?? '',
      isCompleted: completed,
    );
  }

  /// Advances one section and persists the new reading position.
  Future<void> next() async {
    ModuleViewState? current = state.value;
    if (current == null || current.isSaving || current.isCompleted || current.isReflectionStep) {
      return;
    }
    int nextIndex = current.sectionIndex + 1;
    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    try {
      if (nextIndex < current.module.sections.length) {
        await ref
            .read(learningRepositoryProvider)
            .savePosition(
              moduleId: moduleId,
              sectionIndex: nextIndex,
              now: ref.read(appClockProvider).now(),
            );
      }
      state = AsyncData(
        current.copyWith(
          sectionIndex: nextIndex,
          isSaving: false,
          errorMessage: null,
        ),
      );
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          errorMessage: t.learning.error.save,
        ),
      );
    }
  }

  /// Moves back one section and persists the new position.
  Future<void> previous() async {
    ModuleViewState? current = state.value;
    if (current == null || current.isSaving || current.sectionIndex <= 0) {
      return;
    }
    int previousIndex = current.sectionIndex - 1;
    state = AsyncData(current.copyWith(sectionIndex: previousIndex));
    try {
      await ref
          .read(learningRepositoryProvider)
          .savePosition(
            moduleId: moduleId,
            sectionIndex: previousIndex,
            now: ref.read(appClockProvider).now(),
          );
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          errorMessage: t.learning.error.save,
        ),
      );
    }
  }

  /// Updates the optional local reflection text.
  void setReflection(String value) {
    ModuleViewState? current = state.value;
    if (current != null && !current.isSaving && !current.isCompleted) {
      state = AsyncData(
        current.copyWith(reflectionText: value, errorMessage: null),
      );
    }
  }

  /// Starts a completed module again from its first section.
  Future<bool> restart() async {
    ModuleViewState? current = state.value;
    if (current == null || current.isSaving || !current.isCompleted) {
      return false;
    }
    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    try {
      await ref
          .read(learningRepositoryProvider)
          .restartModule(
            moduleId: moduleId,
            now: ref.read(appClockProvider).now(),
          );
      state = AsyncData(
        current.copyWith(
          sectionIndex: 0,
          isCompleted: false,
          isSaving: false,
          errorMessage: null,
        ),
      );
      return true;
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          errorMessage: t.learning.error.save,
        ),
      );
      return false;
    }
  }

  /// Saves the reflection and marks the module complete.
  Future<bool> complete() async {
    ModuleViewState? current = state.value;
    if (current == null || current.isSaving || current.isCompleted || !current.isReflectionStep) {
      return false;
    }
    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    try {
      await ref
          .read(learningRepositoryProvider)
          .completeModule(
            moduleId: moduleId,
            lastSectionIndex: current.module.sections.length - 1,
            reflectionText: current.reflectionText,
            now: ref.read(appClockProvider).now(),
          );
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          isCompleted: true,
          errorMessage: null,
        ),
      );
      return true;
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          errorMessage: t.learning.error.save,
        ),
      );
      return false;
    }
  }
}
