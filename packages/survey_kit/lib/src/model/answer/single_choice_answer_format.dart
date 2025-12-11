import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';

part 'single_choice_answer_format.g.dart';

@JsonSerializable(explicitToJson: true)
class SingleChoiceAnswerFormat extends AnswerFormat {
  static const String type = 'single';

  final List<TextChoice> textChoices;
  final TextChoice? defaultSelection;

  const SingleChoiceAnswerFormat({
    required this.textChoices,
    this.defaultSelection,
    super.question,
    super.answerType = SingleChoiceAnswerFormat.type,
  }) : super();

  factory SingleChoiceAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$SingleChoiceAnswerFormatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SingleChoiceAnswerFormatToJson(this);
}
