import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/result/video_result.dart';

part 'step_result.g.dart';

@JsonSerializable()
class StepResult<T> {
  final String id;
  @_Converter()
  final T? result;
  final DateTime startTime;
  final DateTime endTime;
  final String? valueIdentifier;

  const StepResult({
    required this.id,
    required this.result,
    required this.startTime,
    required this.endTime,
    this.valueIdentifier,
  });

  factory StepResult.fromJson(Map<String, dynamic> json) =>
      _$StepResultFromJson(json);
  Map<String, dynamic> toJson() => _$StepResultToJson(this);

  factory StepResult.fromQuestion({required StepResult questionResult}) {
    return StepResult(
      id: questionResult.id,
      startTime: questionResult.startTime,
      endTime: questionResult.endTime,
      result: [questionResult] as T?,
    );
  }
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is TimeOfDay?) {
      return const TimeOfDayConverter().fromJson(json as String?) as T;
    }
    if (json is VideoResult) {
      return VideoResult.fromJson(json as Map<String, dynamic>) as T;
    }
    return json as T;
  }

  @override
  Object toJson(T object) {
    return object as Object;
  }
}

class TimeOfDayConverter extends JsonConverter<TimeOfDay?, String?> {
  const TimeOfDayConverter();

  @override
  TimeOfDay? fromJson(String? json) {
    if (json == null) {
      return null;
    }

    String _removeLeadingZeroIfNeeded(String value) {
      if (value.startsWith('0')) {
        const indexOfSecondCharacter = 1;
        return value.substring(indexOfSecondCharacter);
      } else {
        return value;
      }
    }

    final elements = json.split(':');
    final hourString = _removeLeadingZeroIfNeeded(elements.first);
    final minuteString = _removeLeadingZeroIfNeeded(elements.last);

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

    String _addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final hourLabel = _addLeadingZeroIfNeeded(object.hour);
    final minuteLabel = _addLeadingZeroIfNeeded(object.minute);

    return '$hourLabel:$minuteLabel';
  }
}
