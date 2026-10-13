import 'package:flutter/foundation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/double_answer_format.dart';
import 'package:survey_kit/src/model/answer/integer_answer_format.dart';
import 'package:survey_kit/src/model/answer/scale_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result_codec.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/datetime_convert.dart';

/// The result produced by a single [Step]. Captures the user's answer together
/// with timing metadata. The generic type [T] is the answer value type.
@immutable
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

  /// Deserializes a [StepResult] produced by [toJson]. The `resultType` field
  /// selects the [StepResultCodec] that restores the typed [result]. Without
  /// a `resultType` the raw JSON value is used.
  factory StepResult.fromJson(Map<String, dynamic> json) {
    const dateTimeConverter = CustomDateTimeConverter();
    final step = Step.fromJson(json['step'] as Map<String, dynamic>);
    final decoded = StepResultCodec.decodeValue(
      json['resultType'] as String?,
      json['result'],
    );
    return StepResult<T>(
      id: json['id'] as String,
      step: step,
      result: _numberForAnswerFormat(decoded, step.answerFormat) as T?,
      startTime: dateTimeConverter.fromJson(json['startTime'] as String),
      endTime: dateTimeConverter.fromJson(json['endTime'] as String),
      valueIdentifier: json['valueIdentifier'] as String?,
    );
  }

  static Object? _numberForAnswerFormat(
    Object? value,
    AnswerFormat? answerFormat,
  ) {
    if (value is! num) {
      return value;
    }
    return switch (answerFormat) {
      DoubleAnswerFormat() || ScaleAnswerFormat() => value.toDouble(),
      IntegerAnswerFormat() => value.toInt(),
      _ => value,
    };
  }

  /// Registers a [StepResultCodec] used by [toJson] and [fromJson] for custom
  /// result value types.
  static void registerResultCodec(StepResultCodec codec) =>
      StepResultCodec.register(codec);

  /// Serializes this result to a JSON-encodable map. The [result] value is
  /// converted by the matching [StepResultCodec] and its type is written to
  /// `resultType`.
  Map<String, dynamic> toJson() {
    const dateTimeConverter = CustomDateTimeConverter();
    final encoded = StepResultCodec.encodeValue(result);
    return <String, dynamic>{
      'id': id,
      'step': step.toJson(),
      'result': encoded.value,
      'resultType': encoded.type,
      'startTime': dateTimeConverter.toJson(startTime),
      'endTime': dateTimeConverter.toJson(endTime),
      'valueIdentifier': valueIdentifier,
    };
  }

  @override
  int get hashCode =>
      Object.hash(id, step, _resultHash, startTime, endTime, valueIdentifier);

  Object? get _resultHash {
    final value = result;
    return value is List ? Object.hashAll(value) : value;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StepResult &&
            id == other.id &&
            step == other.step &&
            _resultEquals(result, other.result) &&
            startTime == other.startTime &&
            endTime == other.endTime &&
            valueIdentifier == other.valueIdentifier;
  }

  static bool _resultEquals(Object? a, Object? b) {
    if (a is List && b is List) {
      return listEquals(a, b);
    }
    return a == b;
  }
}
