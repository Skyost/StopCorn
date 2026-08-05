import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/theme/app_theme.dart';
import 'package:stopcorn/app/widgets/app_action_buttons.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_metric_card.dart';
import 'package:stopcorn/app/widgets/app_page_viewport.dart';
import 'package:stopcorn/app/widgets/app_section_header.dart';
import 'package:stopcorn/app/widgets/app_subtitle.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';

/// Runs shared section, subtitle, and metric widget tests.
void main() {
  testWidgets('the header combines its title, icon, and subtitle', (
    tester,
  ) async {
    await _pump(
      tester,
      const AppSectionHeader(
        title: Text('Progression'),
        subtitle: Text('A few useful markers.'),
        icon: FLucideIcons.chartNoAxesCombined,
      ),
    );

    Finder header = find.byType(AppSectionHeader);
    Padding outerPadding = tester.widget(
      find.descendant(of: header, matching: find.byType(Padding)).first,
    );
    expect(find.text('Progression'), findsOneWidget);
    expect(find.text('A few useful markers.'), findsOneWidget);
    expect(find.byIcon(FLucideIcons.chartNoAxesCombined), findsOneWidget);
    expect(
      outerPadding.padding,
      const EdgeInsets.only(bottom: AppSpacing.section),
    );
  });

  testWidgets('the metric can center a value with its scale', (
    tester,
  ) async {
    await _pump(
      tester,
      const SizedBox(
        width: 240,
        child: AppMetricCard(
          value: '7.5',
          valueSuffix: '/ 10',
          label: Text('average control'),
          centered: true,
        ),
      ),
    );

    Text value = tester.widget(find.text('7.5 / 10'));
    DefaultTextStyle labelStyle = DefaultTextStyle.of(
      tester.element(find.text('average control')),
    );
    expect(value.textAlign, TextAlign.center);
    expect(labelStyle.textAlign, TextAlign.center);
  });

  testWidgets('the subtitle uses the theme secondary color', (
    tester,
  ) async {
    await _pump(
      tester,
      AppSubtitle(text: 'Texte introductif'),
    );

    BuildContext context = tester.element(find.byType(AppSubtitle));
    DefaultTextStyle subtitleStyle = DefaultTextStyle.of(
      tester.element(find.text('Texte introductif')),
    );
    expect(subtitleStyle.style.color, context.theme.colors.mutedForeground);
  });

  testWidgets('the actions stack a primary and a ghost button', (
    tester,
  ) async {
    bool primaryPressed = false;
    bool secondaryPressed = false;
    await _pump(
      tester,
      AppActionButtons(
        primaryButtonKey: const Key('primary_action'),
        primarySize: .lg,
        onPrimaryPress: () => primaryPressed = true,
        primaryLabel: const Text('Continuer'),
        onSecondaryPress: () => secondaryPressed = true,
        secondaryLabel: const Text('Annuler'),
      ),
    );

    Finder group = find.byType(AppActionButtons);
    List<AppButton> buttons = tester
        .widgetList<AppButton>(
          find.descendant(of: group, matching: find.byType(AppButton)),
        )
        .toList();
    Column column = tester.widget(
      find.descendant(of: group, matching: find.byType(Column)).first,
    );
    SizedBox separator = column.children[1] as SizedBox;
    expect(buttons, hasLength(2));
    expect(buttons.first.variant, FButtonVariant.primary);
    expect(buttons.first.size, FButtonSizeVariant.lg);
    expect(buttons.last.variant, FButtonVariant.ghost);
    expect(separator.height, AppSpacing.medium);

    await tester.tap(find.byKey(const Key('primary_action')));
    await tester.tap(find.text('Annuler'));
    await tester.pump(const Duration(milliseconds: 200));
    expect(primaryPressed, isTrue);
    expect(secondaryPressed, isTrue);
  });

  testWidgets('the ghost action can be omitted', (tester) async {
    await _pump(
      tester,
      const AppActionButtons(
        onPrimaryPress: null,
        primaryLabel: Text('Enregistrer'),
      ),
    );

    expect(find.byType(AppButton), findsOneWidget);
  });

  testWidgets('the page list uses a ListView', (tester) async {
    await _pump(
      tester,
      const AppPageViewport(
        scrollable: false,
        child: AppPageList(
          children: [Text('First section'), Text('Second section')],
        ),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('the page viewport can delegate its bottom inset to a shell', (
    tester,
  ) async {
    await _pump(
      tester,
      const AppPageViewport(
        scrollable: false,
        safeAreaBottom: false,
        child: Text('Shell content'),
      ),
    );

    SafeArea safeArea = tester.widget(
      find.descendant(
        of: find.byType(AppPageViewport),
        matching: find.byType(SafeArea),
      ),
    );
    expect(safeArea.bottom, isFalse);
  });
}

/// Pumps [child] inside the application ForUI theme.
Future<void> _pump(WidgetTester tester, Widget child) => tester.pumpWidget(
  MaterialApp(
    home: FTheme(
      data: appTheme.light.touch,
      child: Scaffold(body: child),
    ),
  ),
);
