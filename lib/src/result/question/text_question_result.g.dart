// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_question_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextQuestionResult _$TextQuestionResultFromJson(Map<String, dynamic> json) =>
    TextQuestionResult(
      id: Identifier.fromJson(json['id'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      valueIdentifier: json['valueIdentifier'] as String,
      result: json['result'] as String?,
    );

Map<String, dynamic> _$TextQuestionResultToJson(TextQuestionResult instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'result': instance.result,
      'valueIdentifier': instance.valueIdentifier,
    };
