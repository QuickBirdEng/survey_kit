import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';

part 'multiple_choice_answer_format.g.dart';

@JsonSerializable()
class MultipleChoiceAnswerFormat extends AnswerFormat {
  static const String type = 'multi';

  final List<TextChoice> textChoices;
  final TextChoice? defaultSelection;
  @JsonKey(defaultValue: false)
  final bool otherField;

  const MultipleChoiceAnswerFormat({
    required this.textChoices,
    this.otherField = false,
    this.defaultSelection,
    super.question,
    super.answerType = MultipleChoiceAnswerFormat.type,
  }) : super();

  factory MultipleChoiceAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$MultipleChoiceAnswerFormatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MultipleChoiceAnswerFormatToJson(this);
}
