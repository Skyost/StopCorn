import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Opens an optional single-choice sheet for values of type [T].
final class OptionalChoiceTile<T extends Object> extends StatelessWidget with FTileMixin {
  /// The title.
  final Widget title;

  /// Currently selected value.
  final T? value;

  /// Available values.
  final List<T> values;

  /// Formats one value for display.
  final String Function(T) format;

  /// Called with the selected value or `null`.
  final ValueChanged<T?>? onSelected;

  /// Creates an optional choice control.
  const OptionalChoiceTile({
    super.key,
    required this.title,
    this.value,
    this.values = const [],
    required this.format,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) => FSelectMenuTile<T?>(
    title: title,
    detailsBuilder: (context, values, child) {
      T? selectedValue = values.firstOrNull;
      return Text(
        selectedValue == null ? context.t.app.noChoice : format(selectedValue),
      );
    },
    selectControl: .managedRadio(
      initial: value,
      onChange: (values) => onSelected?.call(values.firstOrNull),
    ),
    menu: [
      FSelectTile(
        title: Text(context.t.app.noChoice),
        value: null,
      ),
      for (T value in values)
        FSelectTile(
          title: Text(format(value)),
          value: value,
        ),
    ],
  );
}
