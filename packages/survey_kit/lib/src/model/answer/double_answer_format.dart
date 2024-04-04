// by Antonio Bruno, Giacomo Ignesti and Massimo Martinelli

import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';

import '../../view/widget/answer/double_answer_view.dart';
import '../result/step_result.dart';
import '../step.dart';
import 'answer_format.dart';

part 'double_answer_format.g.dart';

@JsonSerializable()
class DoubleAnswerFormat extends AnswerFormat {
  static const String type = 'double';

  final double? defaultValue;
  final String hint;

  const DoubleAnswerFormat({
    this.defaultValue,
    this.hint = '',
    super.question,
    super.answerType = type,
  }) : super();

  factory DoubleAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$DoubleAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$DoubleAnswerFormatToJson(this);

  @override
  Widget createView(Step step, StepResult? stepResult) {
    return DoubleAnswerView(
      questionStep: step,
      result: stepResult,
    );
  }
}
