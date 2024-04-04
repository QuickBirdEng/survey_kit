import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';

import '../../view/widget/answer/multiple_choice_auto_complete_answer_view.dart';
import '../result/step_result.dart';
import '../step.dart';
import 'answer_format.dart';
import 'text_choice.dart';

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
