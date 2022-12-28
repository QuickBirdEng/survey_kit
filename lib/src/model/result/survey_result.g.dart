// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResult _$SurveyResultFromJson(Map<String, dynamic> json) => SurveyResult(
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      finishReason: $enumDecode(_$FinishReasonEnumMap, json['finishReason']),
      results: (json['results'] as List<dynamic>)
          .map((e) => StepResult<dynamic>.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurveyResultToJson(SurveyResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'finishReason': _$FinishReasonEnumMap[instance.finishReason]!,
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

const _$FinishReasonEnumMap = {
  FinishReason.saved: 'saved',
  FinishReason.discarded: 'discarded',
  FinishReason.completed: 'completed',
  FinishReason.failed: 'failed',
};
