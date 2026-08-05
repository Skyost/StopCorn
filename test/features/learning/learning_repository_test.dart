import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/features/learning/data/learning_repository.dart';
import 'package:stopcorn/features/learning/domain/learning_catalog.dart';
import 'package:stopcorn/features/learning/domain/learning_library_item.dart';
import 'package:stopcorn/features/learning/domain/learning_progress.dart';
import 'package:stopcorn/i18n/strings.g.dart';

import '../../helpers/test_database.dart';

/// Runs learning repository tests.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(configureTestSqlite);

  test('loads the six English modules in order by default', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);

    LearningCatalog catalog = await repository.loadCatalog();

    expect(catalog.contentVersion, 1);
    expect(catalog.modules, hasLength(6));
    expect(catalog.modules.first.id, 'why-change');
    expect(catalog.modules.first.title, 'Why change?');
    expect(catalog.modules.last.id, 'continue-after-setback');
    expect(
      catalog.modules.every((module) => module.sections.isNotEmpty),
      isTrue,
    );
    expect(
      catalog.modules.every((module) => module.references.isNotEmpty),
      isTrue,
    );
  });

  test('loads the French catalog when that locale is active', () async {
    LocaleSettings.setLocaleSync(.fr);
    addTearDown(() => LocaleSettings.setLocaleSync(.en));
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);

    LearningCatalog catalog = await repository.loadCatalog();

    expect(catalog.modules, hasLength(6));
    expect(catalog.modules.first.title, 'Pourquoi changer ?');
    expect(catalog.modules.first.sections.first.title, 'Une direction qui vient de toi');
  });

  test('exposes every audited scientific reference', () async {
    AppDatabase database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    LearningRepository repository = LearningRepository(database, rootBundle);
    Map<String, List<String>> expectedReferenceUrls = {
      'why-change': [
        'https://pubmed.ncbi.nlm.nih.gov/26168470/',
      ],
      'understand-loop': [
        'https://pubmed.ncbi.nlm.nih.gov/12500811/',
        'https://pubmed.ncbi.nlm.nih.gov/28409565/',
        'https://pubmed.ncbi.nlm.nih.gov/29450222/',
      ],
      'map-terrain': [
        'https://pubmed.ncbi.nlm.nih.gov/15982113/',
        'https://pubmed.ncbi.nlm.nih.gov/32730047/',
      ],
      'ride-urge': [
        'https://pubmed.ncbi.nlm.nih.gov/20025372/',
        'https://pubmed.ncbi.nlm.nih.gov/26817725/',
      ],
      'prepare-environment': [
        'https://pubmed.ncbi.nlm.nih.gov/26817725/',
      ],
      'continue-after-setback': [
        'https://pubmed.ncbi.nlm.nih.gov/22645164/',
        'https://pubmed.ncbi.nlm.nih.gov/8916628/',
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
      sectionIndex: 2,
      now: startedAt.add(const Duration(minutes: 5)),
    );
    await repository.completeModule(
      moduleId: 'why-change',
      lastSectionIndex: 2,
      reflectionText: '  Regain time.  ',
      now: completedAt,
    );

    ModuleProgressData? progress = await repository.getProgress('why-change');
    expect(progress, isNotNull);
    expect(progress!.startedAt?.toUtc(), startedAt);
    expect(progress.lastSectionIndex, 2);
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
    expect(library.current.first.completion, closeTo(1 / 3, 0.001));
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
      lastSectionIndex: 2,
      reflectionText: '',
      now: now.add(const Duration(minutes: 2)),
    );
    library = await repository.loadLibrary();
    expect(selectLearningRecommendation(library)?.module.id, 'why-change');

    await repository.completeModule(
      moduleId: 'why-change',
      lastSectionIndex: 2,
      reflectionText: '',
      now: now.add(const Duration(minutes: 3)),
    );
    library = await repository.loadLibrary();
    expect(selectLearningRecommendation(library)?.module.id, 'map-terrain');
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
        lastSectionIndex: 2,
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
        lastSectionIndex: 2,
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
