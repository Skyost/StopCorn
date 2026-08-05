import 'package:stopcorn/features/learning/domain/learning_catalog.dart';
import 'package:stopcorn/features/learning/domain/learning_progress.dart';

/// Immutable reading state for one learning module.
final class ModuleViewState {
  /// Localized content currently being read.
  final LearningModule module;

  /// Current section index, including the reflection step after all sections.
  final int sectionIndex;

  /// Optional device-only reflection text.
  final String reflectionText;

  /// Whether completion has been persisted.
  final bool isCompleted;

  /// Whether reading progress is being persisted.
  final bool isSaving;

  /// Localized recoverable persistence error.
  final String? errorMessage;

  /// Creates a module reading snapshot.
  const ModuleViewState({
    required this.module,
    required this.sectionIndex,
    required this.reflectionText,
    this.isCompleted = false,
    this.isSaving = false,
    this.errorMessage,
  });

  /// Whether [sectionIndex] points to the final reflection step.
  bool get isReflectionStep => sectionIndex >= module.sections.length;

  /// Reading completion excluding the optional reflection step.
  double get completion => calculateLearningProgress(
    sectionIndex: sectionIndex,
    sectionCount: module.sections.length,
  );

  /// Returns a new snapshot with the supplied fields replaced.
  ModuleViewState copyWith({
    int? sectionIndex,
    String? reflectionText,
    bool? isCompleted,
    bool? isSaving,
    Object? errorMessage = _unchanged,
  }) => ModuleViewState(
    module: module,
    sectionIndex: sectionIndex ?? this.sectionIndex,
    reflectionText: reflectionText ?? this.reflectionText,
    isCompleted: isCompleted ?? this.isCompleted,
    isSaving: isSaving ?? this.isSaving,
    errorMessage: identical(errorMessage, _unchanged) ? this.errorMessage : errorMessage as String?,
  );
}

/// Sentinel distinguishing an omitted nullable value from an explicit `null`.
const Object _unchanged = Object();
