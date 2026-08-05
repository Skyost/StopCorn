import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Gives loading and error feedback one consistent, content-friendly viewport.
final class AsyncStatePanel extends StatelessWidget {
  /// Minimum height that keeps transient feedback visually centered on a page.
  static const double _minimumHeight = 320;

  /// Loading or error feedback displayed by the panel.
  final Widget child;

  /// Creates a shared asynchronous-state viewport.
  const AsyncStatePanel({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const .new(minHeight: _minimumHeight),
    child: child,
  );
}

/// Centered, accessible loading feedback.
final class LoadingState extends StatelessWidget {
  /// Custom accessible label, or the localized default when omitted.
  final String? label;

  /// Creates loading feedback, optionally overriding its [label].
  const LoadingState({
    super.key,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    String effectiveLabel = label ?? context.t.app.loading;
    return Center(
      child: Semantics(
        liveRegion: true,
        label: effectiveLabel,
        child: Column(
          mainAxisSize: .min,
          children: [
            FCircularProgress(semanticsLabel: effectiveLabel),
            const SizedBox(height: AppSpacing.big),
            Text(effectiveLabel, textAlign: .center),
          ],
        ),
      ),
    );
  }
}

/// Recoverable error state with optional debug details.
final class ErrorState extends StatefulWidget {
  /// User-facing error message.
  final String message;

  /// Retry callback.
  final VoidCallback onRetry;

  /// Optional technical error exposed only in debug builds.
  final Object? error;

  /// Creates error feedback with a retry [onRetry] action.
  const ErrorState({
    super.key,
    required this.message,
    required this.onRetry,
    this.error,
  });

  @override
  State<ErrorState> createState() => _ErrorStateState();
}

/// Controls visibility of debug-only error details.
final class _ErrorStateState extends State<ErrorState> {
  /// Whether the technical error text is expanded.
  bool _detailsVisible = false;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const .new(maxWidth: 520),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          const Icon(FLucideIcons.circleAlert, size: AppIconSize.display),
          const SizedBox(height: AppSpacing.big),
          Text(widget.message, textAlign: .center),
          const SizedBox(height: AppSpacing.section),
          AppActionButtons(
            onPrimaryPress: widget.onRetry,
            primaryLabel: Text(context.t.app.retry),
            onSecondaryPress: kDebugMode && widget.error != null ? () => setState(() => _detailsVisible = !_detailsVisible) : null,
            secondaryLabel: kDebugMode && widget.error != null
                ? Text(
                    _detailsVisible ? context.t.app.technicalDetails.hide : context.t.app.technicalDetails.show,
                  )
                : null,
          ),
          if (kDebugMode && widget.error != null) ...[
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 150),
              crossFadeState: _detailsVisible ? .showSecond : .showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const .only(top: AppSpacing.medium),
                child: SelectableText(widget.error.toString()),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
