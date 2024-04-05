import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/view/widget/answer/multiple_choice_auto_complete_answer_view.dart';

part 'multiple_choice_auto_complete_answer_format.g.dart';

@JsonSerializable()
class MultipleChoiceAutoCompleteAnswerFormat extends AnswerFormat {
  static const String type = 'multiple_auto_complete';

  final List<TextChoice> textChoices;
  @JsonKey(defaultValue: <TextChoice>[])
  final List<TextChoice> defaultSelection;
  @JsonKey(defaultValue: <TextChoice>[])
  final List<TextChoice> suggestions;
  @JsonKey(defaultValue: false)
  final bool otherField;

  const MultipleChoiceAutoCompleteAnswerFormat({
    required this.textChoices,
    this.defaultSelection = const [],
    this.suggestions = const [],
    this.otherField = false,
    super.question,
    super.answerType = type,
  }) : super();

  factory MultipleChoiceAutoCompleteAnswerFormat.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MultipleChoiceAutoCompleteAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MultipleChoiceAutoCompleteAnswerFormatToJson(this);

  @override
  Widget createView(Step step, StepResult? stepResult) {
    return MultipleChoiceAutoCompleteAnswerView(
      questionStep: step,
      result: stepResult,
    );
  }
}
