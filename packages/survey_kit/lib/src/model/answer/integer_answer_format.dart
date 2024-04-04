import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';

import '../../../survey_kit.dart';
import '../../util/int_extension.dart';

part 'integer_answer_format.g.dart';

@JsonSerializable()
class IntegerAnswerFormat extends AnswerFormat {
  static const String type = 'integer';

  final int? defaultValue;
  final String hint;
  final int min;
  final int max;

  const IntegerAnswerFormat({
    this.defaultValue,
    this.hint = '',
    this.min = minInt,
    this.max = maxInt,
    super.question,
    super.answerType = type,
  }) : super();

  factory IntegerAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$IntegerAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$IntegerAnswerFormatToJson(this);

  @override
  Widget createView(Step step, StepResult? stepResult) {
    return IntegerAnswerView(
      questionStep: step,
      result: stepResult,
    );
  }
}
