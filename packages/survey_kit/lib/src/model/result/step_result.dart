import 'package:flutter/material.dart' hide Step;
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/datetime_convert.dart';

part 'step_result.g.dart';

/// The result produced by a single [Step]. Captures the user's answer together
/// with timing metadata. The generic type [T] is the answer value type.
@immutable
@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
@CustomDateTimeConverter()
class StepResult<T> {
  /// The identifier of the [Step] this result belongs to.
  final String id;

  /// The step that produced this result.
  final Step step;

  /// The user's answer. May be null if the step was skipped or had no answer.
  final T? result;

  /// The time the user first saw this step.
  final DateTime startTime;

  /// The time the user left this step.
  final DateTime endTime;

  /// Optional semantic tag for the result value.
  final String? valueIdentifier;

  const StepResult({
    required this.id,
    required this.result,
    required this.startTime,
    required this.endTime,
    required this.step,
    this.valueIdentifier,
  });

  /// Creates a [StepResult] that wraps another result as its value.
  /// Used when aggregating nested results.
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
  int get hashCode =>
      Object.hash(id, step, result, startTime, endTime, valueIdentifier);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StepResult &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            step == other.step &&
            result == other.result &&
            startTime == other.startTime &&
            endTime == other.endTime &&
            valueIdentifier == other.valueIdentifier;
  }
}
