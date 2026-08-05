import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stopcorn/core/constants/app_constants.dart';
import 'package:stopcorn/core/database/app_database.dart';
import 'package:stopcorn/core/preferences/app_preferences.dart';
import 'package:stopcorn/core/providers/infrastructure_providers.dart';
import 'package:stopcorn/core/time/app_clock.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'data_export_service.g.dart';

/// Resolves the temporary directory used for an export file.
typedef TemporaryDirectoryProvider = Future<Directory> Function();

/// Opens the platform share flow for one generated export [file].
typedef ShareExportFile = Future<void> Function(File file);

/// Builds the versioned local JSON export and invokes platform sharing.
class DataExportService {
  /// Local relational history included in the export.
  final AppDatabase _database;

  /// StopCorn-owned simple preferences included in the export.
  final AppPreferences _preferences;

  /// Clock used for deterministic filenames and export metadata.
  final AppClock _clock;

  /// Injectable platform temporary-directory boundary.
  final TemporaryDirectoryProvider _temporaryDirectoryProvider;

  /// Injectable platform sharing boundary.
  final ShareExportFile _shareExportFile;

  /// Creates an export service with injectable filesystem and sharing edges.
  const DataExportService(
    this._database,
    this._preferences,
    this._clock,
    this._temporaryDirectoryProvider,
    this._shareExportFile,
  );

  /// Writes a complete export into [directory] or the temporary directory.
  Future<File> createExportFile([Directory? directory]) async {
    DateTime now = _clock.now();
    Directory targetDirectory = directory ?? await _exportDirectory();
    Map<String, Object?> document = await buildExportDocument(now);
    File file = File(path.join(targetDirectory.path, _fileName(now)));
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(document),
      flush: true,
    );
    return file;
  }

  /// Creates an export file, opens sharing, and returns the generated file.
  Future<File> createAndShareExport() async {
    await purgeExports();
    File file = await createExportFile();
    await _shareExportFile(file);
    return file;
  }

  /// Deletes every export left behind by a previous share.
  ///
  /// The export is unencrypted, so it must not sit in the cache indefinitely.
  /// It cannot be removed as soon as the share sheet closes, because the
  /// receiving application may still be reading it, so it is cleared on the
  /// next export, on the next launch, and during complete data deletion.
  /// Set [bestEffort] to false when a failed purge must abort the caller.
  Future<void> purgeExports({bool bestEffort = true}) async {
    try {
      Directory directory = await _exportDirectory();
      await for (FileSystemEntity entity in directory.list()) {
        if (entity is File) {
          await entity.delete();
        }
      }
    } catch (_) {
      if (!bestEffort) {
        rethrow;
      }
      // A cache that cannot be cleared must never block an export.
    }
  }

  /// Returns the dedicated directory holding generated exports.
  Future<Directory> _exportDirectory() async {
    Directory temporary = await _temporaryDirectoryProvider();
    Directory directory = Directory(path.join(temporary.path, 'exports'));
    return directory.create(recursive: true);
  }

  /// Reads all user-owned data into the versioned export document.
  Future<Map<String, Object?>> buildExportDocument(DateTime exportedAt) async {
    List<Goal> goals = await (_database.select(
      _database.goals,
    )..orderBy(<OrderClauseGenerator<$GoalsTable>>[($GoalsTable goal) => OrderingTerm.asc(goal.createdAt)])).get();
    List<UrgeSession> urges = await (_database.select(
      _database.urgeSessions,
    )..orderBy(<OrderClauseGenerator<$UrgeSessionsTable>>[($UrgeSessionsTable urge) => OrderingTerm.asc(urge.startedAt)])).get();
    List<ConsumptionEvent> events = await (_database.select(
      _database.consumptionEvents,
    )..orderBy(<OrderClauseGenerator<$ConsumptionEventsTable>>[($ConsumptionEventsTable event) => OrderingTerm.asc(event.occurredAt)])).get();
    List<DailyCheckIn> checkIns = await (_database.select(
      _database.dailyCheckIns,
    )..orderBy(<OrderClauseGenerator<$DailyCheckInsTable>>[($DailyCheckInsTable checkIn) => OrderingTerm.asc(checkIn.localDate)])).get();
    List<SelfAssessment> assessments =
        await (_database.select(_database.selfAssessments)..orderBy(<OrderClauseGenerator<$SelfAssessmentsTable>>[
              ($SelfAssessmentsTable assessment) => OrderingTerm.asc(assessment.recordedAt),
            ]))
            .get();
    List<CopingStrategyUse> strategyUses = await (_database.select(
      _database.copingStrategyUses,
    )..orderBy(<OrderClauseGenerator<$CopingStrategyUsesTable>>[($CopingStrategyUsesTable use) => OrderingTerm.asc(use.usedAt)])).get();
    List<ModuleProgressData> moduleProgress = await (_database.select(
      _database.moduleProgress,
    )..orderBy(<OrderClauseGenerator<$ModuleProgressTable>>[($ModuleProgressTable progress) => OrderingTerm.asc(progress.moduleId)])).get();

    return {
      'exportVersion': AppConstants.exportVersion,
      'app': AppConstants.appName,
      'exportedAt': _date(exportedAt),
      'preferences': await _preferences.exportValues(),
      'goals': [
        for (final Goal goal in goals)
          {
            'id': goal.id,
            'type': goal.type,
            'isActive': goal.isActive,
            'weeklyLimit': goal.weeklyLimit,
            'contextKeys': _decodeStringList(goal.contextKeysJson),
            'motivation': goal.motivation,
            'startedAt': _date(goal.startedAt),
            'endedAt': _dateOrNull(goal.endedAt),
          },
      ],
      'urgeSessions': [
        for (final UrgeSession urge in urges)
          {
            'id': urge.id,
            'startedAt': _date(urge.startedAt),
            'completedAt': _dateOrNull(urge.completedAt),
            'initialIntensity': urge.initialIntensity,
            'finalIntensity': urge.finalIntensity,
            'triggerType': urge.triggerType,
            'emotionType': urge.emotionType,
            'copingStrategyId': urge.copingStrategyId,
            'outcome': urge.outcome,
            'notes': urge.notes,
            'pauseDurationSeconds': urge.pauseDurationSeconds,
          },
      ],
      'consumptionEvents': [
        for (final ConsumptionEvent event in events)
          {
            'id': event.id,
            'occurredAt': _date(event.occurredAt),
            'triggerType': event.triggerType,
            'emotionType': event.emotionType,
            'contextLabel': event.contextLabel,
            'contextKeys': _decodeStringList(event.contextKeysJson),
            'perceivedControl': event.perceivedControl,
            'notes': event.notes,
            'urgeSessionId': event.urgeSessionId,
          },
      ],
      'dailyCheckIns': [
        for (final DailyCheckIn checkIn in checkIns)
          {
            'localDate': checkIn.localDate,
            'moodScore': checkIn.moodScore,
            'controlScore': checkIn.controlScore,
            'urgeCountEstimate': checkIn.urgeCountEstimate,
            'sleepQuality': checkIn.sleepQuality,
            'note': checkIn.note,
          },
      ],
      'selfAssessments': [
        for (final SelfAssessment assessment in assessments)
          {
            'id': assessment.id,
            'recordedAt': _date(assessment.recordedAt),
            'kind': assessment.kind,
            'weeklyFrequency': assessment.weeklyFrequency,
            'perceivedControl': assessment.perceivedControl,
            'negativeImpact': assessment.negativeImpact,
            'confidenceToChange': assessment.confidenceToChange,
            'notes': assessment.notes,
          },
      ],
      'copingStrategyUses': [
        for (final CopingStrategyUse use in strategyUses)
          {
            'id': use.id,
            'strategyId': use.strategyId,
            'usedAt': _date(use.usedAt),
            'urgeSessionId': use.urgeSessionId,
            'perceivedEffect': use.perceivedEffect,
          },
      ],
      'moduleProgress': [
        for (final ModuleProgressData progress in moduleProgress)
          {
            'moduleId': progress.moduleId,
            'startedAt': _dateOrNull(progress.startedAt),
            'completedAt': _dateOrNull(progress.completedAt),
            'lastSectionIndex': progress.lastSectionIndex,
            'isReviewing': progress.isReviewing,
            'reflectionText': progress.reflectionText,
          },
      ],
    };
  }

  /// Builds a timestamped, filesystem-safe JSON filename.
  String _fileName(DateTime value) {
    DateTime local = value.toLocal();
    String month = local.month.toString().padLeft(2, '0');
    String day = local.day.toString().padLeft(2, '0');
    String hour = local.hour.toString().padLeft(2, '0');
    String minute = local.minute.toString().padLeft(2, '0');
    return 'stopcorn-export-${local.year}-$month-$day-$hour$minute.json';
  }

  /// Encodes [value] as an unambiguous UTC ISO-8601 timestamp.
  String _date(DateTime value) => value.toUtc().toIso8601String();

  /// Encodes [value] when present.
  String? _dateOrNull(DateTime? value) => value == null ? null : _date(value);

  /// Safely decodes a stored JSON array of strings for export.
  List<String>? _decodeStringList(String? raw) {
    if (raw == null) {
      return null;
    }
    Object? decoded = jsonDecode(raw);
    if (decoded is! List<Object?> || decoded.any((value) => value is! String)) {
      return null;
    }
    return decoded.cast<String>();
  }
}

/// Provides the production export service.
@Riverpod(keepAlive: true)
DataExportService dataExportService(Ref ref) => DataExportService(
  ref.watch(appDatabaseProvider),
  ref.watch(appPreferencesProvider),
  ref.watch(appClockProvider),
  getTemporaryDirectory,
  (file) async {
    await SharePlus.instance.share(
      ShareParams(
        subject: t.export.share.subject,
        title: t.export.share.title,
        files: [XFile(file.path, mimeType: 'application/json')],
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
      ),
    );
  },
);
