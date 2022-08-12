// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_question_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateQuestionResult _$DateQuestionResultFromJson(Map<String, dynamic> json) =>
    DateQuestionResult(
      id: Identifier.fromJson(json['id'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      valueIdentifier: json['valueIdentifier'] as String,
      result: json['result'] == null
          ? null
          : DateTime.parse(json['result'] as String),
    );

Map<String, dynamic> _$DateQuestionResultToJson(DateQuestionResult instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'result': instance.result?.toIso8601String(),
      'valueIdentifier': instance.valueIdentifier,
    };
