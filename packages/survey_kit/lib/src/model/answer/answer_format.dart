import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/boolean_answer_format.dart';
import 'package:survey_kit/src/model/answer/date_answer_format.dart';
import 'package:survey_kit/src/model/answer/double_answer_format.dart';
import 'package:survey_kit/src/model/answer/image_answer_format.dart';
import 'package:survey_kit/src/model/answer/integer_answer_format.dart';
import 'package:survey_kit/src/model/answer/multiple_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/multiple_choice_auto_complete_answer_format.dart';
import 'package:survey_kit/src/model/answer/multiple_double_answer_format.dart';
import 'package:survey_kit/src/model/answer/scale_answer_format.dart';
import 'package:survey_kit/src/model/answer/single_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_answer_format.dart';
import 'package:survey_kit/src/model/answer/time_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';

@JsonSerializable()
abstract class AnswerFormat {
  const AnswerFormat({this.answerType, this.question});

  final String? question;
  @JsonKey(name: 'type')
  final String? answerType;

  Widget createView(Step step, StepResult? stepResult);

  factory AnswerFormat.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    assert(type != null, 'type is required');

    switch (type) {
      case MultipleChoiceAnswerFormat.type:
        return MultipleChoiceAnswerFormat.fromJson(json);
      case SingleChoiceAnswerFormat.type:
        return SingleChoiceAnswerFormat.fromJson(json);
      case BooleanAnswerFormat.type:
        return BooleanAnswerFormat.fromJson(json);
      case DateAnswerFormat.type:
        return DateAnswerFormat.fromJson(json);
      case DoubleAnswerFormat.type:
        return DoubleAnswerFormat.fromJson(json);
      case IntegerAnswerFormat.type:
        return IntegerAnswerFormat.fromJson(json);
      case ImageAnswerFormat.type:
        return ImageAnswerFormat.fromJson(json);
      case TextAnswerFormat.type:
        return TextAnswerFormat.fromJson(json);
      case TimeAnswerFormat.type:
        return TimeAnswerFormat.fromJson(json);
      case ScaleAnswerFormat.type:
        return ScaleAnswerFormat.fromJson(json);
      case MultipleChoiceAutoCompleteAnswerFormat.type:
        return MultipleChoiceAutoCompleteAnswerFormat.fromJson(json);
      case MultipleDoubleAnswerFormat.type:
        return MultipleDoubleAnswerFormat.fromJson(json);
      default:
        throw Exception('Unknown type: $type');
    }
  }
}
