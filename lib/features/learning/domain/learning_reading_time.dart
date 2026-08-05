import 'dart:math';

/// Words a reader is assumed to cover per minute inside a learning module.
///
/// Deliberately below a silent-reading average: module copy is explanatory and
/// is usually read once, carefully, rather than skimmed.
const int learningWordsPerMinute = 160;

/// Seconds added per section for navigating to it and taking it in.
const int _sectionOverheadSeconds = 30;

/// Seconds reserved for the optional reflection closing every module.
const int _reflectionOverheadSeconds = 60;

/// Matches any character that makes a token count as a word.
final RegExp _wordCharacter = RegExp(r'[\p{L}\p{N}]', unicode: true);

/// Counts the words of [text], ignoring standalone punctuation and symbols.
int countLearningWords(String text) => text.split(RegExp(r'\s+')).where(_wordCharacter.hasMatch).length;

/// Estimates the whole minutes needed to read and reflect on module content.
///
/// Combines the reading time of [wordCount] with a fixed overhead per section
/// and for the reflection step. The result is rounded up and never below one.
int estimateLearningMinutes({
  required int wordCount,
  required int sectionCount,
}) {
  if (wordCount < 0 || sectionCount < 0) {
    throw ArgumentError('Learning content cannot have a negative length.');
  }
  double seconds =
      wordCount / learningWordsPerMinute * Duration.secondsPerMinute + sectionCount * _sectionOverheadSeconds + _reflectionOverheadSeconds;
  return max(1, (seconds / Duration.secondsPerMinute).ceil());
}
