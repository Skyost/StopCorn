import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/app/widgets/app_countdown.dart';

/// Runs reusable countdown widget tests.
void main() {
  testWidgets('the countdown synchronizes with the start time', (
    tester,
  ) async {
    DateTime startedAt = DateTime.utc(2026, 7, 30, 12);
    DateTime current = startedAt;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AppCountdown(
          startedAt: startedAt,
          totalSeconds: 5,
          now: () => current,
          builder: (context, value) => Text(
            '${value.elapsedSeconds}|${value.remainingSeconds}|'
            '${value.progress}|${value.isComplete}',
          ),
        ),
      ),
    );

    expect(find.text('0|5|0.0|false'), findsOneWidget);

    current = current.add(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('2|3|0.4|false'), findsOneWidget);

    current = current.add(const Duration(seconds: 10));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('5|0|1.0|true'), findsOneWidget);
  });
}
