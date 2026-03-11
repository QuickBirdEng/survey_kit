import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';

part 'multiple_choice_answer_format.g.dart';

/// Answer format that allows selecting multiple items from a list of
/// [TextChoice]s. The JSON type identifier is `'multi'`.
@JsonSerializable(genericArgumentFactories: true)
class MultipleChoiceAnswerFormat<T extends TextChoice> extends AnswerFormat {
  static const String type = 'multi';

  /// The list of selectable options.
  @JsonKey(name: 'textChoices')
  final List<T> choices;

  /// The option pre-selected when the step is first shown.
  final T? defaultSelection;

  /// When true, an additional free-text 'Other' field is shown below the
  /// choices.
  @JsonKey(defaultValue: false)
  final bool otherField;

  const MultipleChoiceAnswerFormat({
    required this.choices,
    this.otherField = false,
    this.defaultSelection,
    super.question,
    super.answerType = MultipleChoiceAnswerFormat.type,
  }) : super();

  factory MultipleChoiceAnswerFormat.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$MultipleChoiceAnswerFormatFromJson(json, fromJsonT);

  @override
  Map<String, dynamic> toJson() => _$MultipleChoiceAnswerFormatToJson(
        this,
        (value) => value.toJson(),
      );
}
