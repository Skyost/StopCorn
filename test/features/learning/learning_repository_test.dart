import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/features/learning/data/learning_repository.dart';
import 'package:stopcorn/features/learning/domain/learning_catalog.dart';
import 'package:stopcorn/features/learning/domain/learning_library_item.dart';
import 'package:stopcorn/features/learning/domain/learning_progress.dart';
import 'package:stopcorn/features/learning/domain/learning_reading_time.dart';
import 'package:stopcorn/i18n/strings.g.dart';

import '../../helpers/test_database.dart';

/// Runs learning repository tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  test('loads the nine English modules in order by default', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);

    LearningCatalog catalog = await repository.loadCatalog();

    expect(catalog.contentVersion, 1);
    expect(catalog.modules, hasLength(9));
    expect(
      catalog.modules.map((module) => module.id),
      [
        'why-change',
        'understand-loop',
        'separate-shame',
        'map-terrain',
        'ride-urge',
        'prepare-environment',
        'build-alternatives',
        'track-progress',
        'continue-after-setback',
      ],
    );
    expect(catalog.modules.first.title, 'Why change?');
    expect(
      catalog.modules.every((module) => module.sections.length >= 5),
      isTrue,
    );
    expect(
      catalog.modules.every(
        (module) => module.sections.every(
          (section) => section.paragraphs.length >= 3,
        ),
      ),
      isTrue,
    );
    expect(
      catalog.modules.every((module) => module.references.isNotEmpty),
      isTrue,
    );
  });

  test('exposes the takeaways bundled with a section', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);

    LearningCatalog catalog = await repository.loadCatalog();

    LearningModule whyChange = catalog.modules.first;
    expect(
      whyChange.sections.first.keyPoints,
      contains('Starting with observation is a valid goal.'),
    );
    expect(whyChange.sections[2].keyPoints, isEmpty);
    expect(
      catalog.modules.every(
        (module) => module.sections.any(
          (section) => section.keyPoints.isNotEmpty,
        ),
      ),
      isTrue,
      reason: 'every module must offer at least one takeaway list.',
    );
  });

  test('derives the reading duration from the module word count', () {
    expect(
      estimateLearningMinutes(wordCount: 0, sectionCount: 0),
      1,
      reason: 'an estimate is never below one minute.',
    );
    expect(
      estimateLearningMinutes(
        wordCount: learningWordsPerMinute * 4,
        sectionCount: 0,
      ),
      5,
      reason: 'four minutes of words plus the reflection overhead.',
    );
    expect(
      estimateLearningMinutes(
        wordCount: learningWordsPerMinute * 4,
        sectionCount: 6,
      ),
      8,
      reason: 'each section adds half a minute.',
    );
    expect(
      estimateLearningMinutes(wordCount: 500, sectionCount: 5),
      greaterThan(estimateLearningMinutes(wordCount: 300, sectionCount: 5)),
    );
    expect(
      () => estimateLearningMinutes(wordCount: -1, sectionCount: 1),
      throwsArgumentError,
    );
    expect(countLearningWords('  situation → émotion  '), 2);
  });

  test('recomputes every duration from the localized content', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);

    LearningCatalog english = await repository.loadCatalog();
    Map<String, int> englishWords = {
      for (LearningModule module in english.modules) module.id: _readableWords(module),
    };
    LocaleSettings.setLocaleSync(.fr);
    addTearDown(() => LocaleSettings.setLocaleSync(.en));
    LearningCatalog french = await repository.loadCatalog();

    for (LearningCatalog catalog in [english, french]) {
      for (LearningModule module in catalog.modules) {
        expect(
          module.estimatedMinutes,
          estimateLearningMinutes(
            wordCount: _readableWords(module),
            sectionCount: module.sections.length,
          ),
          reason: module.id,
        );
      }
    }
    expect(
      french.modules.every(
        (module) => _readableWords(module) != englishWords[module.id],
      ),
      isTrue,
      reason: 'each locale must be measured on its own copy.',
    );
  });

  test('loads the French catalog when that locale is active', () async {
    LocaleSettings.setLocaleSync(.fr);
    addTearDown(() => LocaleSettings.setLocaleSync(.en));
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);

    LearningCatalog catalog = await repository.loadCatalog();

    expect(catalog.modules, hasLength(9));
    expect(catalog.modules.first.title, 'Pourquoi changer ?');
    expect(catalog.modules.first.sections.first.title, 'Une direction qui vient de toi');
    expect(
      catalog.modules.first.sections.first.keyPoints,
      contains('Commencer par observer est un objectif valable.'),
    );
  });

  test('exposes every audited scientific reference', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);
    Map<String, List<String>> expectedReferenceUrls = {
      'why-change': [
        'https://pubmed.ncbi.nlm.nih.gov/26168470/',
        'https://pubmed.ncbi.nlm.nih.gov/29954290/',
        'https://doi.org/10.1111/spc3.12265',
      ],
      'understand-loop': [
        'https://pubmed.ncbi.nlm.nih.gov/12500811/',
        'https://pubmed.ncbi.nlm.nih.gov/26361052/',
        'https://pubmed.ncbi.nlm.nih.gov/28409565/',
        'https://pubmed.ncbi.nlm.nih.gov/29450222/',
        'https://pubmed.ncbi.nlm.nih.gov/31247240/',
      ],
      'separate-shame': [
        'https://pubmed.ncbi.nlm.nih.gov/30076491/',
        'https://pubmed.ncbi.nlm.nih.gov/29412013/',
        'https://pubmed.ncbi.nlm.nih.gov/22645164/',
        'https://doi.org/10.1111/hcre.12108',
        'https://pubmed.ncbi.nlm.nih.gov/29352554/',
        'https://pubmed.ncbi.nlm.nih.gov/26893127/',
      ],
      'map-terrain': [
        'https://pubmed.ncbi.nlm.nih.gov/15982113/',
        'https://pubmed.ncbi.nlm.nih.gov/32730047/',
        'https://pubmed.ncbi.nlm.nih.gov/22149456/',
        'https://doi.org/10.1002/ejsp.674',
        'https://pubmed.ncbi.nlm.nih.gov/20015584/',
      ],
      'ride-urge': [
        'https://pubmed.ncbi.nlm.nih.gov/20025372/',
        'https://pubmed.ncbi.nlm.nih.gov/10751965/',
        'https://pubmed.ncbi.nlm.nih.gov/20569778/',
        'https://pubmed.ncbi.nlm.nih.gov/26817725/',
      ],
      'prepare-environment': [
        'https://pubmed.ncbi.nlm.nih.gov/26817725/',
        'https://doi.org/10.1177/1948550616679237',
        'https://doi.org/10.1016/S0065-2601(06)38002-1',
      ],
      'build-alternatives': [
        'https://pubmed.ncbi.nlm.nih.gov/17184887/',
        'https://pubmed.ncbi.nlm.nih.gov/25547522/',
        'https://pubmed.ncbi.nlm.nih.gov/20569778/',
      ],
      'track-progress': [
        'https://pubmed.ncbi.nlm.nih.gov/26479070/',
        'https://pubmed.ncbi.nlm.nih.gov/19916637/',
      ],
      'continue-after-setback': [
        'https://pubmed.ncbi.nlm.nih.gov/8916628/',
        'https://pubmed.ncbi.nlm.nih.gov/22645164/',
        'https://pubmed.ncbi.nlm.nih.gov/23070875/',
        'https://pubmed.ncbi.nlm.nih.gov/21771314/',
        'https://pubmed.ncbi.nlm.nih.gov/37880509/',
        'https://pubmed.ncbi.nlm.nih.gov/40126561/',
      ],
    };

    LearningCatalog catalog = await repository.loadCatalog();

    for (MapEntry<String, List<String>> entry in expectedReferenceUrls.entries) {
      LearningModule module = catalog.modules.singleWhere(
        (module) => module.id == entry.key,
      );
      expect(
        module.references.map((reference) => reference.url),
        unorderedEquals(entry.value),
        reason: entry.key,
      );
      expect(
        module.references.every(
          (reference) => reference.citation.contains('https://doi.org/'),
        ),
        isTrue,
        reason: '${entry.key} must expose a verified DOI.',
      );
    }
  });

  test('persists reading, reflection, and module completion', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);
    DateTime startedAt = DateTime.utc(2026, 7, 28, 10);
    DateTime completedAt = DateTime.utc(2026, 7, 28, 10, 10);

    await repository.startModule(moduleId: 'why-change', now: startedAt);
    await repository.savePosition(
      moduleId: 'why-change',
      sectionIndex: 4,
      now: startedAt.add(const Duration(minutes: 5)),
    );
    await repository.completeModule(
      moduleId: 'why-change',
      lastSectionIndex: 4,
      reflectionText: '  Regain time.  ',
      now: completedAt,
    );

    ModuleProgressData? progress = await repository.getProgress('why-change');
    expect(progress, isNotNull);
    expect(progress!.startedAt?.toUtc(), startedAt);
    expect(progress.lastSectionIndex, 4);
    expect(progress.reflectionText, 'Regain time.');
    expect(progress.completedAt?.toUtc(), completedAt);
    List<LearningLibraryItem> library = await repository.loadLibrary();
    expect(library.first.isCompleted, isTrue);
    expect(library.first.completion, 1);
  });

  test('ignores the optional reflection in reading progress', () {
    expect(
      calculateLearningProgress(
        sectionIndex: 0,
        sectionCount: 3,
      ),
      closeTo(1 / 3, 0.001),
    );
    expect(
      calculateLearningProgress(
        sectionIndex: 2,
        sectionCount: 3,
      ),
      1,
    );
    expect(
      calculateLearningProgress(
        sectionIndex: 3,
        sectionCount: 3,
      ),
      1,
    );
  });

  test('immediately observes progress changes', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);
    DateTime now = DateTime.utc(2026, 7, 28, 10);
    StreamIterator<List<LearningLibraryItem>> library = StreamIterator(
      repository.watchLibrary(),
    );
    addTearDown(library.cancel);
    expect(await library.moveNext(), isTrue);
    expect(library.current.first.completion, 0);

    await repository.startModule(
      moduleId: 'why-change',
      now: now,
    );

    expect(await library.moveNext(), isTrue);
    expect(library.current.first.completion, closeTo(1 / 5, 0.001));
  });

  test('recommends the latest active reading and then the next module', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);
    DateTime now = DateTime.utc(2026, 7, 28, 10);

    List<LearningLibraryItem> library = await repository.loadLibrary();
    expect(selectLearningRecommendation(library)?.module.id, 'why-change');

    await repository.startModule(moduleId: 'why-change', now: now);
    await repository.startModule(
      moduleId: 'understand-loop',
      now: now.add(const Duration(minutes: 1)),
    );
    library = await repository.loadLibrary();
    expect(selectLearningRecommendation(library)?.module.id, 'understand-loop');

    await repository.completeModule(
      moduleId: 'understand-loop',
      lastSectionIndex: 5,
      reflectionText: '',
      now: now.add(const Duration(minutes: 2)),
    );
    library = await repository.loadLibrary();
    expect(selectLearningRecommendation(library)?.module.id, 'why-change');

    await repository.completeModule(
      moduleId: 'why-change',
      lastSectionIndex: 4,
      reflectionText: '',
      now: now.add(const Duration(minutes: 3)),
    );
    library = await repository.loadLibrary();
    expect(selectLearningRecommendation(library)?.module.id, 'separate-shame');
  });

  test(
    'resumes a completed module without losing its first completion',
    () async {
      AppDatabase database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      LearningRepository repository = LearningRepository(database, rootBundle);
      DateTime completedAt = DateTime.utc(2026, 7, 28, 10);

      await repository.startModule(
        moduleId: 'why-change',
        now: completedAt.subtract(const Duration(minutes: 10)),
      );
      await repository.completeModule(
        moduleId: 'why-change',
        lastSectionIndex: 4,
        reflectionText: 'Regain time.',
        now: completedAt,
      );
      await repository.restartModule(
        moduleId: 'why-change',
        now: completedAt.add(const Duration(days: 1)),
      );

      ModuleProgressData progress = (await repository.getProgress(
        'why-change',
      ))!;
      expect(progress.completedAt?.toUtc(), completedAt);
      expect(progress.isReviewing, isTrue);
      expect(progress.lastSectionIndex, 0);
      expect(progress.reflectionText, 'Regain time.');
      LearningLibraryItem item = (await repository.loadLibrary()).first;
      expect(item.isCompleted, isFalse);
      expect(item.isReviewing, isTrue);

      await repository.completeModule(
        moduleId: 'why-change',
        lastSectionIndex: 4,
        reflectionText: 'Still relevant.',
        now: completedAt.add(const Duration(days: 2)),
      );

      ModuleProgressData completedAgain = (await repository.getProgress(
        'why-change',
      ))!;
      expect(completedAgain.completedAt?.toUtc(), completedAt);
      expect(completedAgain.isReviewing, isFalse);
    },
  );
}

/// Counts the words a reader goes through in [module].
int _readableWords(LearningModule module) =>
    module.sections.fold(0, (total, section) => total + section.wordCount) + countLearningWords(module.reflectionPrompt);
