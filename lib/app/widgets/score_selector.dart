import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:stopcorn/app/widgets/app_button.dart';
import 'package:stopcorn/app/widgets/app_card.dart';
import 'package:stopcorn/core/constants/app_dimensions.dart';
import 'package:stopcorn/core/utils/app_number.dart';
import 'package:stopcorn/i18n/strings.g.dart';

/// Slider position used to present a score nobody has answered yet.
const int _unansweredPosition = 5;

/// Accessible integer selector for the inclusive zero-to-ten scale.
///
/// Passing [onCleared] makes the score optional: until the person moves the
/// slider, [value] stays `null`, the control is drawn in a muted color, and the
/// badge reads as unanswered instead of showing a number nobody chose.
final class ScoreSelector extends StatelessWidget {
  /// Name of the measured score.
  final String label;

  /// Current score between zero and ten, or `null` when it is unanswered.
  final int? value;

  /// Called with the rounded score whenever the slider changes.
  final ValueChanged<int> onChanged;

  /// Clears an optional score, or `null` when the score is required.
  final VoidCallback? onCleared;

  /// Optional explanation of the scale endpoints.
  final String? description;

  /// Creates a labeled score selector.
  const ScoreSelector({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.onCleared,
    this.description,
  }) : assert(
         value != null || onCleared != null,
         'A required score cannot be unanswered.',
       );

  /// Whether the person has actually chosen a value.
  bool get _answered => value != null;

  @override
  Widget build(BuildContext context) {
    int position = value ?? _unansweredPosition;
    Color mutedColor = context.theme.colors.mutedForeground;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: FLabel(
        layout: .vertical,
        label: Text(label),
        description: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Wrap(
            alignment: .spaceBetween,
            children: [
              if (value == null) Text(context.t.app.score.unanswered) else if (description != null) Text(description!),
              if (onCleared != null && value != null)
                AppButton(
                  variant: .ghost,
                  size: .xs,
                  mainAxisSize: .min,
                  onPress: onCleared,
                  semanticsLabel: context.t.app.score.clear(label: label),
                  child: Icon(
                    FLucideIcons.eraser,
                    color: context.theme.colors.destructive,
                  ),
                ),
            ],
          ),
        ),
        child: AppCard(
          padding: const EdgeInsets.all(AppSpacing.medium).copyWith(bottom: AppSpacing.big),
          child: Row(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Expanded(
                child: FSlider(
                  // The unanswered state must not read as a deliberate mid-scale
                  // answer, so the whole control is muted until it is touched.
                  style: _answered
                      ? const .context()
                      : .delta(
                          activeColor: FVariantsValueDelta.delta([
                            FVariantValueDeltaOperation.all(mutedColor),
                          ]),
                          thumbStyle: .delta(
                            borderColor: FVariantsValueDelta.delta([
                              FVariantValueDeltaOperation.all(mutedColor),
                            ]),
                          ),
                        ),
                  control: FSliderControl.liftedDiscrete(
                    value: FSliderValue(max: position / 10),
                    onChange: (sliderValue) => onChanged((sliderValue.max * 10).round()),
                  ),
                  marks: [
                    for (int score = 0; score <= 10; score++)
                      FSliderMark(
                        value: score / 10,
                        label: score == 0 || score == 5 || score == 10 ? Text(formatCount(score)) : null,
                      ),
                  ],
                ),
              ),
              if (value != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: FBadge(
                    style: .delta(
                      labelTextStyle: .delta(
                        fontSize: context.theme.typography.body.xs2.fontSize,
                      ),
                    ),
                    child: Text(
                      context.t.app.score.outOfTen(
                        value: formatCount(value!),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
