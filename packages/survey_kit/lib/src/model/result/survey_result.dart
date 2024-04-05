import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/util/datetime_convert.dart';

part 'survey_result.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
class SurveyResult {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final FinishReason finishReason;
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
          finishReason == other.finishReason;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      finishReason.hashCode ^
      results.hashCode;
}

enum FinishReason { saved, discarded, completed, failed }
