// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Removes journal entries the user no longer considers accurate.
///
/// Deleting is deliberately narrow: it removes one record and refreshes the
/// journal, without touching anything the entry does not own.
///
/// The controller outlives the sheet that triggers it: an auto-disposed one
/// would be discarded while the deletion is still running, and refreshing the
/// journal afterwards would then fail even though the record is gone.

@ProviderFor(JournalEntryController)
final journalEntryControllerProvider = JournalEntryControllerProvider._();

/// Removes journal entries the user no longer considers accurate.
///
/// Deleting is deliberately narrow: it removes one record and refreshes the
/// journal, without touching anything the entry does not own.
///
/// The controller outlives the sheet that triggers it: an auto-disposed one
/// would be discarded while the deletion is still running, and refreshing the
/// journal afterwards would then fail even though the record is gone.
final class JournalEntryControllerProvider extends $NotifierProvider<JournalEntryController, void> {
  /// Removes journal entries the user no longer considers accurate.
  ///
  /// Deleting is deliberately narrow: it removes one record and refreshes the
  /// journal, without touching anything the entry does not own.
  ///
  /// The controller outlives the sheet that triggers it: an auto-disposed one
  /// would be discarded while the deletion is still running, and refreshing the
  /// journal afterwards would then fail even though the record is gone.
  JournalEntryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalEntryControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalEntryControllerHash();

  @$internal
  @override
  JournalEntryController create() => JournalEntryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$journalEntryControllerHash() => r'041aa5cbf6c9a48d144b2b250edc3867f00880eb';

/// Removes journal entries the user no longer considers accurate.
///
/// Deleting is deliberately narrow: it removes one record and refreshes the
/// journal, without touching anything the entry does not own.
///
/// The controller outlives the sheet that triggers it: an auto-disposed one
/// would be discarded while the deletion is still running, and refreshing the
/// journal afterwards would then fail even though the record is gone.

abstract class _$JournalEntryController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<void, void>, void, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
