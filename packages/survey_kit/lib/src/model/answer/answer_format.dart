import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';

import '../result/step_result.dart';
import '../step.dart';
import 'boolean_answer_format.dart';
import 'date_answer_format.dart';
import 'double_answer_format.dart';
import 'image_answer_format.dart';
import 'integer_answer_format.dart';
import 'multiple_choice_answer_format.dart';
import 'multiple_choice_auto_complete_answer_format.dart';
import 'multiple_double_answer_format.dart';
import 'scale_answer_format.dart';
import 'single_choice_answer_format.dart';
import 'text_answer_format.dart';
import 'time_answer_format.dart';

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
