import 'package:flutter/material.dart' show TimeOfDay;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';

part 'time_answer_format.g.dart';

/// Answer format that presents a time picker.
/// The JSON type identifier is `'time'`.
@JsonSerializable()
class TimeAnswerFormat extends AnswerFormat {
  static const String type = 'time';

  /// The time pre-selected when the picker is first shown.
  @_TimeOfDayJsonConverter()
  final TimeOfDay? defaultValue;

  const TimeAnswerFormat({
    this.defaultValue,
    super.question,
    super.answerType = TimeAnswerFormat.type,
  }) : super();

  factory TimeAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$TimeAnswerFormatFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TimeAnswerFormatToJson(this);
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
  @override
  Map<String, dynamic> toJson(TimeOfDay? timeOfDay) => <String, dynamic>{
        'hour': timeOfDay?.hour,
        'minute': timeOfDay?.minute,
      };
}
