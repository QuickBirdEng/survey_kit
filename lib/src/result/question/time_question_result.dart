import 'package:flutter/material.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'time_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
@TimeOfDayConverter()
class TimeQuestionResult extends QuestionResult<TimeOfDay?> {
  const TimeQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory TimeQuestionResult.fromJson(Map<String, dynamic> json) =>
      _$TimeQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$TimeQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}

class TimeOfDayConverter extends JsonConverter<TimeOfDay?, String?> {
  const TimeOfDayConverter();

  @override
  TimeOfDay? fromJson(String? json) {
    if (json == null) {
      return null;
    }

    String removeLeadingZeroIfNeeded(String value) {
      if (value.startsWith('0')) {
        const indexOfSecondCharacter = 1;
        return value.substring(indexOfSecondCharacter);
      } else {
        return value;
      }
    }

    final elements = json.split(':');
    final hourString = removeLeadingZeroIfNeeded(elements.first);
    final minuteString = removeLeadingZeroIfNeeded(elements.last);

    final hour = int.tryParse(hourString);
    final minute = int.tryParse(minuteString);

    if (hour != null && minute != null) {
      return TimeOfDay(hour: hour, minute: minute);
    } else {
      return null;
    }
  }

  @override
  String? toJson(TimeOfDay? object) {
    if (object == null) {
      return null;
    }

    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final String hourLabel = addLeadingZeroIfNeeded(object.hour);
    final String minuteLabel = addLeadingZeroIfNeeded(object.minute);

    return '$hourLabel:$minuteLabel';
  }
}
