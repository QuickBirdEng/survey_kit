import 'package:flutter/material.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';

class TimeAnswerFormat implements AnswerFormat {
  final TimeOfDay defaultValue;

  TimeAnswerFormat({
    this.defaultValue,
  });
}
