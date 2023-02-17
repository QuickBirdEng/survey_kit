// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResult _$SurveyResultFromJson(Map<String, dynamic> json) => SurveyResult(
      id: json['id'] as String,
      startTime:
          const CustomDateTimeConverter().fromJson(json['startTime'] as String),
      endTime:
          const CustomDateTimeConverter().fromJson(json['endTime'] as String),
      finishReason: $enumDecode(_$FinishReasonEnumMap, json['finishReason']),
      results: (json['results'] as List<dynamic>)
          .map((e) => StepResult<dynamic>.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurveyResultToJson(SurveyResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': const CustomDateTimeConverter().toJson(instance.startTime),
      'endTime': const CustomDateTimeConverter().toJson(instance.endTime),
      'finishReason': _$FinishReasonEnumMap[instance.finishReason]!,
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

const _$FinishReasonEnumMap = {
  FinishReason.saved: 'saved',
  FinishReason.discarded: 'discarded',
  FinishReason.completed: 'completed',
  FinishReason.failed: 'failed',
};
