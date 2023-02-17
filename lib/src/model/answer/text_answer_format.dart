import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/survey_kit.dart';

part 'text_answer_format.g.dart';

@JsonSerializable()
class TextAnswerFormat extends AnswerFormat {
  static const String type = 'text';

  final int? maxLines;
  @JsonKey(defaultValue: '')
  final String hint;

  /// Regular expression by which the text gets validated
  /// default: '^(?!\s*$).+' that checks if the entered text is empty
  /// to allow any type of an answer including an empty one;
  /// set it explicitly to null.
  ///
  @JsonKey(defaultValue: r'^(?!s*$).+')
  final String? validationRegEx;

  const TextAnswerFormat({
    this.maxLines,
    this.hint = '',
    this.validationRegEx = r'^(?!s*$).+',
    super.question,
    super.answerType = type,
  }) : super();

  factory TextAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$TextAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$TextAnswerFormatToJson(this);

  @override
  Widget createView(Step step, StepResult? stepResult) {
    return TextAnswerView(
      questionStep: step,
      result: stepResult,
    );
  }
}
