import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';

/// Scrolls the active lazy page list until [target] has been built and shown.
Future<void> scrollAppPageUntilVisible(
  WidgetTester tester,
  Finder target, {
  double delta = 400,
}) async {
  Finder scrollable = find
      .descendant(
        of: find.byType(AppPageList),
        matching: find.byType(Scrollable),
      )
      .first;
  expect(scrollable, findsAtLeastNWidgets(1));
  await tester.scrollUntilVisible(
    target,
    delta,
    scrollable: scrollable,
  );
  await tester.pumpAndSettle();
}
