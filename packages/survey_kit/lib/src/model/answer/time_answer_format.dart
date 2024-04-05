import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/survey_kit.dart';

part 'time_answer_format.g.dart';

@JsonSerializable()
class TimeAnswerFormat extends AnswerFormat {
  static const String type = 'time';

  @_TimeOfDayJsonConverter()
  final TimeOfDay? defaultValue;

  const TimeAnswerFormat({
    this.defaultValue,
    super.question,
    super.answerType = type,
  }) : super();

  factory TimeAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$TimeAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$TimeAnswerFormatToJson(this);

  @override
  Widget createView(Step step, StepResult? stepResult) {
    return TimeAnswerView(
      questionStep: step,
      result: stepResult,
    );
  }
}

class _TimeOfDayJsonConverter
    implements JsonConverter<TimeOfDay?, Map<String, dynamic>> {
  const _TimeOfDayJsonConverter();

  @override
  TimeOfDay? fromJson(Map<String, dynamic> json) {
    if (json['hour'] == null || json['minute'] == null) {
      return null;
    }
    return TimeOfDay(
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(TimeOfDay? timeOfDay) => <String, dynamic>{
        'hour': timeOfDay?.hour,
        'minute': timeOfDay?.minute,
      };
}
