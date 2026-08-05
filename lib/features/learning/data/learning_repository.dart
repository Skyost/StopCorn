import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/features/learning/domain/learning_catalog.dart';
import 'package:stopcorn/features/learning/domain/learning_library_item.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'learning_repository.g.dart';

/// Reads localized learning content and persists module progress.
final class LearningRepository {
  /// Local relational store used for reading progress.
  final AppDatabase _database;

  /// Asset source for the active locale's bundled content.
  final AssetBundle _assetBundle;

  /// Catalog most recently parsed for [_cachedLocale].
  LearningCatalog? _cachedCatalog;

  /// Language code represented by [_cachedCatalog].
  String? _cachedLocale;

  /// Creates a repository backed by [database] and [assetBundle].
  LearningRepository(this._database, this._assetBundle);

  /// Loads and validates the catalog for the active locale.
  Future<LearningCatalog> loadCatalog() async {
    String locale = LocaleSettings.currentLocale.languageCode;
    LearningCatalog? cached = _cachedCatalog;
    if (cached != null && _cachedLocale == locale) {
      return cached;
    }
    String rawManifest = await _assetBundle.loadString(
      'assets/learning/catalog.json',
    );
    Object? decodedManifest = jsonDecode(rawManifest);
    if (decodedManifest is! Map<String, Object?>) {
      throw const FormatException('Invalid learning catalog.');
    }
    Object? rawModuleAssets = decodedManifest['moduleAssets'];
    if (rawModuleAssets is! List<Object?> || rawModuleAssets.isEmpty || rawModuleAssets.any((asset) => asset is! String)) {
      throw const FormatException('Invalid learning module manifest.');
    }
    List<Map<String, Object?>> modules = [];
    for (String assetPath in rawModuleAssets.cast<String>()) {
      String rawModule = await _assetBundle.loadString(assetPath);
      Object? decodedModule = jsonDecode(rawModule);
      if (decodedModule is! Map<String, Object?>) {
        throw FormatException('Invalid learning module: $assetPath.');
      }
      modules.add(decodedModule);
    }
    LearningCatalog catalog = LearningCatalog.fromJson(
      {
        'contentVersion': decodedManifest['contentVersion'],
        'modules': modules,
      },
      translate: _translateLearningKey,
    );
    if (catalog.contentVersion != AppConstants.learningContentVersion) {
      throw FormatException(
        'Unexpected content version: ${catalog.contentVersion}.',
      );
    }
    _cachedCatalog = catalog;
    _cachedLocale = locale;
    return catalog;
  }

  /// Resolves an exact Slang key and requires a plain localized string.
  String _translateLearningKey(String key) {
    Object? value = t[key];
    if (value is! String) {
      throw FormatException('Unknown learning translation: $key.');
    }
    return value;
  }

  /// Combines localized modules with their persisted progress.
  Future<List<LearningLibraryItem>> loadLibrary() async {
    LearningCatalog catalog = await loadCatalog();
    List<ModuleProgressData> progressRows = await _database.select(_database.moduleProgress).get();
    return _combineLibrary(catalog, progressRows);
  }

  /// Watches localized modules and emits whenever their local progress changes.
  Stream<List<LearningLibraryItem>> watchLibrary() async* {
    LearningCatalog catalog = await loadCatalog();
    yield* _database
        .select(_database.moduleProgress)
        .watch()
        .map(
          (progressRows) => _combineLibrary(catalog, progressRows),
        );
  }

  /// Combines [catalog] with the latest persisted [progressRows].
  List<LearningLibraryItem> _combineLibrary(
    LearningCatalog catalog,
    List<ModuleProgressData> progressRows,
  ) {
    Map<String, ModuleProgressData> progressById = {
      for (final ModuleProgressData progress in progressRows) progress.moduleId: progress,
    };
    return List<LearningLibraryItem>.unmodifiable(
      catalog.modules.map(
        (module) => LearningLibraryItem(
          module: module,
          progress: progressById[module.id],
        ),
      ),
    );
  }

  /// Finds a localized module by [moduleId].
  Future<LearningModule?> getModule(String moduleId) async {
    LearningCatalog catalog = await loadCatalog();
    return catalog.modules.where((module) => module.id == moduleId).firstOrNull;
  }

  /// Loads the persisted progress for [moduleId].
  Future<ModuleProgressData?> getProgress(String moduleId) => (_database.select(_database.moduleProgress)..where((progress) => progress.moduleId.equals(moduleId))).getSingleOrNull();

  /// Creates progress for [moduleId] or records its first opening.
  Future<ModuleProgressData> startModule({
    required String moduleId,
    required DateTime now,
  }) async {
    ModuleProgressData? existing = await getProgress(moduleId);
    if (existing == null) {
      await _database
          .into(_database.moduleProgress)
          .insert(
            ModuleProgressCompanion.insert(
              moduleId: moduleId,
              startedAt: Value<DateTime?>(now.toUtc()),
              updatedAt: now.toUtc(),
            ),
          );
    } else if (existing.startedAt == null) {
      await (_database.update(
        _database.moduleProgress,
      )..where((progress) => progress.moduleId.equals(moduleId))).write(
        ModuleProgressCompanion(
          startedAt: Value<DateTime?>(now.toUtc()),
          updatedAt: Value<DateTime>(now.toUtc()),
        ),
      );
    }
    return (await getProgress(moduleId))!;
  }

  /// Persists a non-negative reading [sectionIndex].
  Future<void> savePosition({
    required String moduleId,
    required int sectionIndex,
    required DateTime now,
  }) async {
    if (sectionIndex < 0) {
      throw const FormatException('Invalid reading position.');
    }
    int updated =
        await (_database.update(
          _database.moduleProgress,
        )..where((progress) => progress.moduleId.equals(moduleId))).write(
          ModuleProgressCompanion(
            lastSectionIndex: Value<int>(sectionIndex),
            updatedAt: Value<DateTime>(now.toUtc()),
          ),
        );
    if (updated != 1) {
      throw StateError('Module progress was not found.');
    }
  }

  /// Restarts [moduleId] while preserving its first completion timestamp.
  Future<void> restartModule({
    required String moduleId,
    required DateTime now,
  }) async {
    ModuleProgressData? existing = await getProgress(moduleId);
    if (existing?.completedAt == null) {
      throw StateError('Only a completed module can be restarted.');
    }
    int updated =
        await (_database.update(
          _database.moduleProgress,
        )..where((progress) => progress.moduleId.equals(moduleId))).write(
          ModuleProgressCompanion(
            lastSectionIndex: const Value<int>(0),
            isReviewing: const Value<bool>(true),
            updatedAt: Value<DateTime>(now.toUtc()),
          ),
        );
    if (updated != 1) {
      throw StateError('Module progress was not found.');
    }
  }

  /// Persists a reflection and marks [moduleId] complete.
  Future<void> completeModule({
    required String moduleId,
    required int lastSectionIndex,
    required String reflectionText,
    required DateTime now,
  }) async {
    String reflection = reflectionText.trim();
    if (reflection.length > AppConstants.noteMaxLength) {
      throw const FormatException(
        'The reflection cannot exceed '
        '${AppConstants.noteMaxLength} characters.',
      );
    }
    ModuleProgressData? existing = await getProgress(moduleId);
    if (existing == null) {
      throw StateError('Module progress was not found.');
    }
    int updated =
        await (_database.update(
          _database.moduleProgress,
        )..where((progress) => progress.moduleId.equals(moduleId))).write(
          ModuleProgressCompanion(
            completedAt: Value<DateTime?>(
              existing.completedAt ?? now.toUtc(),
            ),
            lastSectionIndex: Value<int>(lastSectionIndex),
            isReviewing: const Value<bool>(false),
            reflectionText: Value<String?>(
              reflection.isEmpty ? null : reflection,
            ),
            updatedAt: Value<DateTime>(now.toUtc()),
          ),
        );
    if (updated != 1) {
      throw StateError('Module progress was not found.');
    }
  }
}

/// Provides the localized database-backed learning repository.
@Riverpod(keepAlive: true)
LearningRepository learningRepository(Ref ref) => LearningRepository(ref.watch(appDatabaseProvider), rootBundle);
