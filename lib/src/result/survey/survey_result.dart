import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/result/step_result.dart';

part 'survey_result.g.dart';

@JsonSerializable(explicitToJson: true)
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
}

enum FinishReason { saved, discarded, completed, failed }
