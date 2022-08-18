// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_question_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeQuestionResult _$TimeQuestionResultFromJson(Map<String, dynamic> json) =>
    TimeQuestionResult(
      id: Identifier.fromJson(json['id'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      valueIdentifier: json['valueIdentifier'] as String,
      result: const TimeOfDayConverter().fromJson(json['result'] as String?),
    );

Map<String, dynamic> _$TimeQuestionResultToJson(TimeQuestionResult instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'result': const TimeOfDayConverter().toJson(instance.result),
      'valueIdentifier': instance.valueIdentifier,
    };
