import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/survey_kit.dart';

part 'image_answer_format.g.dart';

@JsonSerializable()
class ImageAnswerFormat extends AnswerFormat {
  static const String type = 'image';

  final String? defaultValue;
  final String buttonText;

  const ImageAnswerFormat({
    this.defaultValue,
    this.buttonText = 'Image: ',
    super.question,
    super.answerType = type,
  }) : super();

  factory ImageAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$ImageAnswerFormatFromJson(json);

  Map<String, dynamic> toJson() => _$ImageAnswerFormatToJson(this);

  @override
  Widget createView(Step step, StepResult? stepResult) {
    return ImageAnswerView(
      questionStep: step,
      result: stepResult,
    );
  }
}
