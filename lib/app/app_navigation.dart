import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Pops the current route when possible, otherwise opens [fallbackLocation].
///
/// Detail screens can be reached through a push, a direct link, a notification,
/// or a `go` transition. Only the first case guarantees a route to pop.
void popOrGo(BuildContext context, String fallbackLocation) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(fallbackLocation);
  }
}
