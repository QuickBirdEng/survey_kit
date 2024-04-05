import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/view/widget/answer/boolean_answer_view.dart';

part 'boolean_answer_format.g.dart';

@JsonSerializable()
class BooleanAnswerFormat extends AnswerFormat {
  static const String type = 'bool';

  final String positiveAnswer;
  final String negativeAnswer;
  final BooleanResult result;

  const BooleanAnswerFormat({
    required this.positiveAnswer,
    required this.negativeAnswer,
    this.result = BooleanResult.none,
    super.question,
    super.answerType = type,
  }) : super();

  factory BooleanAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$BooleanAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$BooleanAnswerFormatToJson(this);

  @override
  Widget createView(Step step, StepResult? stepResult) {
    return BooleanAnswerView(
      questionStep: step,
      result: stepResult,
    );
  }
}

@JsonEnum()
enum BooleanResult { none, positive, negative }
