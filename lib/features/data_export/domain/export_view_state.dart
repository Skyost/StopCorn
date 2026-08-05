/// Immutable state of the explicit export-and-share flow.
final class ExportViewState {
  /// Whether the user acknowledged that the file may be sensitive.
  final bool isConfirmed;

  /// Whether the export file is currently being generated.
  final bool isExporting;

  /// Whether the platform share sheet was opened successfully.
  final bool shareOpened;

  /// Localized recoverable error shown in the flow.
  final String? errorMessage;

  /// Creates an export flow snapshot.
  const ExportViewState({
    this.isConfirmed = false,
    this.isExporting = false,
    this.shareOpened = false,
    this.errorMessage,
  });

  /// Returns a new snapshot with the supplied fields replaced.
  ExportViewState copyWith({
    bool? isConfirmed,
    bool? isExporting,
    bool? shareOpened,
    Object? errorMessage = _unchanged,
  }) => ExportViewState(
    isConfirmed: isConfirmed ?? this.isConfirmed,
    isExporting: isExporting ?? this.isExporting,
    shareOpened: shareOpened ?? this.shareOpened,
    errorMessage: identical(errorMessage, _unchanged) ? this.errorMessage : errorMessage as String?,
  );
}

/// Sentinel distinguishing an omitted nullable value from an explicit `null`.
const Object _unchanged = Object();
