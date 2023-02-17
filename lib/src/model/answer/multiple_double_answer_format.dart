import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/multi_double.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/view/widget/answer/multiple_double_answer_view.dart';

part 'multiple_double_answer_format.g.dart';

@JsonSerializable()
class MultipleDoubleAnswerFormat extends AnswerFormat {
  static const String type = 'multiple_double';

  final List<MultiDouble>? defaultValues;
  @JsonKey(defaultValue: <String>[])
  final List<String> hints;

  const MultipleDoubleAnswerFormat({
    this.defaultValues,
    required this.hints,
    super.question,
    super.answerType = type,
  }) : super();

  factory MultipleDoubleAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$MultipleDoubleAnswerFormatFromJson(json);

  Map<String, dynamic> toJson() => _$MultipleDoubleAnswerFormatToJson(this);

  @override
  Widget createView(Step step, StepResult? stepResult) {
    return MultipleDoubleAnswerView(
      questionStep: step,
      result: stepResult,
    );
  }
}
