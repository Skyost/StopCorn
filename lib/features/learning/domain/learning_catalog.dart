import 'package:stopcorn/features/learning/domain/learning_reading_time.dart';

/// Versioned collection of offline learning modules for one locale.
final class LearningCatalog {
  /// Schema version of the bundled content.
  final int contentVersion;

  /// Modules ordered for library presentation.
  final List<LearningModule> modules;

  /// Creates an immutable learning catalog.
  const LearningCatalog({
    required this.contentVersion,
    required this.modules,
  });

  /// Validates and parses a catalog assembled from module descriptors.
  factory LearningCatalog.fromJson(
    Map<String, Object?> json, {
    required LearningTranslationResolver translate,
  }) {
    Object? version = json['contentVersion'];
    Object? rawModules = json['modules'];
    if (version is! int || rawModules is! List<Object?>) {
      throw const FormatException('Invalid learning catalog.');
    }
    List<LearningModule> modules = rawModules.map((raw) {
      if (raw is! Map<String, Object?>) {
        throw const FormatException('Invalid learning module.');
      }
      return LearningModule.fromJson(raw, translate: translate);
    }).toList()..sort((first, second) => first.order.compareTo(second.order));
    if (modules.map((module) => module.id).toSet().length != modules.length) {
      throw const FormatException('Duplicate learning module identifiers.');
    }
    return LearningCatalog(
      contentVersion: version,
      modules: List<LearningModule>.unmodifiable(modules),
    );
  }
}

/// One short, offline educational module.
final class LearningModule {
  /// Stable identifier shared across locales.
  final String id;

  /// Position in the learning library.
  final int order;

  /// Localized module title.
  final String title;

  /// Localized short module summary.
  final String summary;

  /// Approximate reading duration, derived from the localized word count.
  final int estimatedMinutes;

  /// Ordered localized reading sections.
  final List<LearningSection> sections;

  /// Localized optional reflection question.
  final String reflectionPrompt;

  /// Scientific references supporting the module's general principles.
  final List<LearningReference> references;

  /// Creates an immutable learning module.
  const LearningModule({
    required this.id,
    required this.order,
    required this.title,
    required this.summary,
    required this.estimatedMinutes,
    required this.sections,
    required this.reflectionPrompt,
    required this.references,
  });

  /// Validates and translates one locale-neutral module descriptor.
  factory LearningModule.fromJson(
    Map<String, Object?> json, {
    required LearningTranslationResolver translate,
  }) {
    Object? id = json['id'];
    Object? order = json['order'];
    Object? rawSections = json['sections'];
    Object? rawReferences = json['references'];
    if (id is! String ||
        id.isEmpty ||
        order is! int ||
        rawSections is! List<Object?> ||
        rawSections.isEmpty ||
        rawReferences is! List<Object?> ||
        rawReferences.isEmpty) {
      throw const FormatException('Invalid learning module content.');
    }
    List<LearningSection> sections = List<LearningSection>.unmodifiable(
      rawSections.map((raw) {
        if (raw is! Map<String, Object?>) {
          throw const FormatException('Invalid learning section.');
        }
        return LearningSection.fromJson(raw, translate: translate);
      }),
    );
    String reflectionPrompt = _translateRequired(
      json,
      'reflectionPromptKey',
      translate,
    );
    return LearningModule(
      id: id,
      order: order,
      title: _translateRequired(json, 'titleKey', translate),
      summary: _translateRequired(json, 'summaryKey', translate),
      estimatedMinutes: estimateLearningMinutes(
        wordCount:
            sections.fold(0, (total, section) => total + section.wordCount) +
            countLearningWords(reflectionPrompt),
        sectionCount: sections.length,
      ),
      sections: sections,
      reflectionPrompt: reflectionPrompt,
      references: List<LearningReference>.unmodifiable(
        rawReferences.map((raw) {
          if (raw is! Map<String, Object?>) {
            throw const FormatException('Invalid learning reference.');
          }
          return LearningReference.fromJson(raw);
        }),
      ),
    );
  }
}

/// One titled group of paragraphs inside a learning module.
final class LearningSection {
  /// Localized section title.
  final String title;

  /// Ordered localized paragraphs.
  final List<String> paragraphs;

  /// Ordered localized takeaways, possibly empty.
  final List<String> keyPoints;

  /// Creates an immutable learning section.
  const LearningSection({
    required this.title,
    required this.paragraphs,
    this.keyPoints = const [],
  });

  /// Number of words a reader goes through in this section.
  int get wordCount => [title, ...paragraphs, ...keyPoints].fold(
    0,
    (total, text) => total + countLearningWords(text),
  );

  /// Validates and translates one section descriptor.
  factory LearningSection.fromJson(
    Map<String, Object?> json, {
    required LearningTranslationResolver translate,
  }) {
    Object? rawParagraphKeys = json['paragraphKeys'];
    Object? rawKeyPointKeys = json['keyPointKeys'];
    if (rawParagraphKeys is! List<Object?> || rawParagraphKeys.isEmpty || rawParagraphKeys.any((key) => key is! String)) {
      throw const FormatException('Invalid learning section content.');
    }
    if (rawKeyPointKeys != null && (rawKeyPointKeys is! List<Object?> || rawKeyPointKeys.isEmpty || rawKeyPointKeys.any((key) => key is! String))) {
      throw const FormatException('Invalid learning section takeaways.');
    }
    return LearningSection(
      title: _translateRequired(json, 'titleKey', translate),
      paragraphs: List<String>.unmodifiable(
        rawParagraphKeys.cast<String>().map(translate),
      ),
      keyPoints: List<String>.unmodifiable(
        (rawKeyPointKeys as List<Object?>? ?? const []).cast<String>().map(
          translate,
        ),
      ),
    );
  }
}

/// Bibliographic reference bundled with a learning module.
final class LearningReference {
  /// Full citation suitable for offline display.
  final String citation;

  /// Stable web address for the source record.
  final String url;

  /// Creates an immutable scientific reference.
  const LearningReference({
    required this.citation,
    required this.url,
  });

  /// Validates and parses one bibliographic reference.
  factory LearningReference.fromJson(Map<String, Object?> json) {
    Object? citation = json['citation'];
    Object? url = json['url'];
    Uri? uri = url is String ? Uri.tryParse(url) : null;
    if (citation is! String || citation.trim().isEmpty || uri == null || !uri.hasScheme || uri.scheme != 'https') {
      throw const FormatException('Invalid learning reference.');
    }
    return LearningReference(
      citation: citation.trim(),
      url: url as String,
    );
  }
}

/// Resolves one exact Slang translation key.
typedef LearningTranslationResolver = String Function(String key);

/// Reads and resolves the translation key stored in [field].
String _translateRequired(
  Map<String, Object?> json,
  String field,
  LearningTranslationResolver translate,
) {
  Object? key = json[field];
  if (key is! String || key.isEmpty) {
    throw const FormatException('Invalid learning translation key.');
  }
  String value = translate(key);
  if (value.trim().isEmpty) {
    throw FormatException('Empty learning translation: $key.');
  }
  return value;
}
