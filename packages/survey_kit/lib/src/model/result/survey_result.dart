import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/util/datetime_convert.dart';

part 'survey_result.g.dart';

/// The aggregated result of a completed or closed survey. Contains all
/// [StepResult]s collected during the session plus timing and finish metadata.
@immutable
@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
class SurveyResult {
  /// Identifier matching the [SurveyDefinition.id] of the survey that produced
  /// this result.
  final String id;

  /// The time the survey was started.
  final DateTime startTime;

  /// The time the survey ended.
  final DateTime endTime;

  /// How the survey was finished.
  final FinishReason finishReason;

  /// The ordered list of step results collected during the survey.
  final List<StepResult> results;

  const SurveyResult({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.finishReason,
    required this.results,
  });

  factory SurveyResult.fromJson(Map<String, dynamic> json) =>
      _$SurveyResultFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResultToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          finishReason == other.finishReason &&
          listEquals(results, other.results);

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      finishReason.hashCode ^
      results.hashCode;
}

/// Describes how a survey session ended.
/// [saved] — saved mid-flow, [discarded] — user closed without completing,
/// [completed] — all steps finished, [failed] — an error occurred.
enum FinishReason { saved, discarded, completed, failed }
