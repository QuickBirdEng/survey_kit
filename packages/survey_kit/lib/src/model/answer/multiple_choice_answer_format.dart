import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';

part 'multiple_choice_answer_format.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class MultipleChoiceAnswerFormat<T extends TextChoice> extends AnswerFormat {
  static const String type = 'multi';

  @JsonKey(name: 'textChoices')
  final List<T> choices;
  final T? defaultSelection;
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
