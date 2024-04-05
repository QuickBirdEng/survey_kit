import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/datetime_convert.dart';

part 'step_result.g.dart';

@immutable
@JsonSerializable(genericArgumentFactories: true)
@CustomDateTimeConverter()
class StepResult<T> {
  final String id;
  final Step step;
  final T? result;
  final DateTime startTime;
  final DateTime endTime;
  @JsonKey(includeIfNull: false)
  final String? valueIdentifier;

  const StepResult({
    required this.id,
    required this.result,
    required this.startTime,
    required this.endTime,
    required this.step,
    this.valueIdentifier,
  });

  factory StepResult.fromQuestion({required StepResult questionResult}) {
    return StepResult(
      id: questionResult.id,
      step: questionResult.step,
      startTime: questionResult.startTime,
      endTime: questionResult.endTime,
      result: questionResult as T?,
    );
  }

  factory StepResult.fromJson(Map<String, dynamic> json) =>
      _$StepResultFromJson(json, (json) => json as T);

  Map<String, dynamic> toJson() => _$StepResultToJson(this, (result) => result);

  @override
  int get hashCode => id.hashCode ^ startTime.hashCode ^ endTime.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StepResult &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            startTime == other.startTime &&
            endTime == other.endTime;
  }
}
