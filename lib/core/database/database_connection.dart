import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:stopcorn/core/constants/app_constants.dart';

/// Opens StopCorn's SQLite file on a background isolate.
QueryExecutor openDatabaseConnection() => LazyDatabase(() async {
  Directory directory = kDebugMode ? (await getApplicationDocumentsDirectory()) : (await getApplicationSupportDirectory());
  File file = File(path.join(directory.path, AppConstants.databaseFileName));
  return NativeDatabase.createInBackground(file);
});
