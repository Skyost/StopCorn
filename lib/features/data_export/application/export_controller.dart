import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stopcorn/core/diagnostics/error_reporter.dart';
import 'package:stopcorn/features/data_export/data/data_export_service.dart';
import 'package:stopcorn/features/data_export/domain/export_view_state.dart';
import 'package:stopcorn/i18n/strings.g.dart';

part 'export_controller.g.dart';

/// Coordinates explicit confirmation and creation of a local export.
@riverpod
final class ExportController extends _$ExportController {
  @override
  ExportViewState build() => const ExportViewState();

  /// Updates the user's explicit sensitive-data confirmation.
  void setConfirmed(bool value) {
    if (!state.isExporting) {
      state = state.copyWith(isConfirmed: value, errorMessage: null);
    }
  }

  /// Creates the export and opens the system share sheet.
  Future<bool> exportAndShare() async {
    if (!state.isConfirmed || state.isExporting) {
      return false;
    }
    state = state.copyWith(
      isExporting: true,
      shareOpened: false,
      errorMessage: null,
    );
    try {
      await ref.read(dataExportServiceProvider).createAndShareExport();
      state = state.copyWith(
        isExporting: false,
        shareOpened: true,
        errorMessage: null,
      );
      return true;
    } catch (error, stackTrace) {
      ref.reportFailure(error, stackTrace, operation: 'export.share');
      state = state.copyWith(
        isExporting: false,
        shareOpened: false,
        errorMessage: t.export.error,
      );
      return false;
    }
  }
}
