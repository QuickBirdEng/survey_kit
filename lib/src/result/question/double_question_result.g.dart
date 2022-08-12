// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'double_question_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleQuestionResult _$DoubleQuestionResultFromJson(
        Map<String, dynamic> json) =>
    DoubleQuestionResult(
      id: Identifier.fromJson(json['id'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      valueIdentifier: json['valueIdentifier'] as String,
      result: (json['result'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DoubleQuestionResultToJson(
        DoubleQuestionResult instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'result': instance.result,
      'valueIdentifier': instance.valueIdentifier,
    };
