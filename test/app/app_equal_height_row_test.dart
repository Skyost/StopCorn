import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/app/widgets/app_equal_height_row.dart';

/// Runs equal-height row widget tests.
void main() {
  testWidgets('stretches every child to the height of the tallest one', (
    tester,
  ) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 300,
            child: AppEqualHeightRow(
              children: [
                const SizedBox(
                  key: Key('short_child'),
                  height: 40,
                ),
                const SizedBox(
                  key: Key('tall_child'),
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Size shortSize = tester.getSize(find.byKey(const Key('short_child')));
    Size tallSize = tester.getSize(find.byKey(const Key('tall_child')));
    expect(shortSize.height, 80);
    expect(shortSize.height, tallSize.height);
    expect(shortSize.width, tallSize.width);
  });
}
