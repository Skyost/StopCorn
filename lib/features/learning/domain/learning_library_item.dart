import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/features/learning/domain/learning_catalog.dart';
import 'package:stopcorn/features/learning/domain/learning_progress.dart';

/// Localized module paired with optional device-only progress.
final class LearningLibraryItem {
  /// Localized bundled module content.
  final LearningModule module;

  /// Persisted progress, or `null` before the module is opened.
  final ModuleProgressData? progress;

  /// Creates a module library entry.
  const LearningLibraryItem({
    required this.module,
    this.progress,
  });

  /// Whether the module has ever been opened.
  bool get isStarted => progress?.startedAt != null;

  /// Whether a previously completed module is being read again.
  bool get isReviewing => progress?.isReviewing ?? false;

  /// Whether the module has been completed.
  bool get isCompleted => progress?.completedAt != null && !isReviewing;

  /// Reading completion ratio excluding the optional reflection step.
  double get completion {
    if (isCompleted) {
      return 1;
    }
    if (!isStarted) {
      return 0;
    }
    return calculateLearningProgress(
      sectionIndex: progress!.lastSectionIndex,
      sectionCount: module.sections.length,
    );
  }
}

/// Selects the most relevant module to recommend outside the library.
///
/// The latest active reading takes priority. Without one, the first unfinished
/// module in catalog order becomes the next recommendation. A fully completed
/// library has no recommendation.
LearningLibraryItem? selectLearningRecommendation(
  List<LearningLibraryItem> items,
) {
  LearningLibraryItem? current;
  for (LearningLibraryItem item in items) {
    if (!item.isStarted || item.isCompleted) {
      continue;
    }
    if (current == null || item.progress!.updatedAt.isAfter(current.progress!.updatedAt)) {
      current = item;
    }
  }
  if (current != null) {
    return current;
  }
  for (LearningLibraryItem item in items) {
    if (!item.isCompleted) {
      return item;
    }
  }
  return null;
}
