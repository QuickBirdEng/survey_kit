import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/survey_kit.dart';

part 'scale_answer_format.g.dart';

@JsonSerializable()
class ScaleAnswerFormat extends AnswerFormat {
  static const String type = 'scale';

  final double maximumValue;
  final double minimumValue;
  final double defaultValue;
  final double step;
  final String maximumValueDescription;
  final String minimumValueDescription;

  const ScaleAnswerFormat({
    required this.maximumValue,
    required this.minimumValue,
    required this.defaultValue,
    required this.step,
    this.maximumValueDescription = '',
    this.minimumValueDescription = '',
    super.question,
    super.answerType = type,
  }) : super();

  factory ScaleAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$ScaleAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$ScaleAnswerFormatToJson(this);

  @override
  Widget createView(Step step, StepResult? stepResult) {
    return ScaleAnswerView(
      questionStep: step,
      result: stepResult,
    );
  }
}
