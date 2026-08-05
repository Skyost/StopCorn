/// Calculates reading progress while excluding the optional reflection step.
double calculateLearningProgress({
  required int sectionIndex,
  required int sectionCount,
}) {
  if (sectionCount <= 0) {
    return 0;
  }
  int visitedSectionCount = (sectionIndex + 1).clamp(0, sectionCount);
  return visitedSectionCount / sectionCount;
}
