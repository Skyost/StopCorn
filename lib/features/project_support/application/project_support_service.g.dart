// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_support_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the optional project-support integration.

@ProviderFor(projectSupportService)
final projectSupportServiceProvider = ProjectSupportServiceProvider._();

/// Provides the optional project-support integration.

final class ProjectSupportServiceProvider extends $FunctionalProvider<ProjectSupportService, ProjectSupportService, ProjectSupportService> with $Provider<ProjectSupportService> {
  /// Provides the optional project-support integration.
  ProjectSupportServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectSupportServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectSupportServiceHash();

  @$internal
  @override
  $ProviderElement<ProjectSupportService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectSupportService create(Ref ref) {
    return projectSupportService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectSupportService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectSupportService>(value),
    );
  }
}

String _$projectSupportServiceHash() => r'4db1d1c24ba9633160c21bae45f90e17d5e828f4';
