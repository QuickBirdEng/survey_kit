// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_choice_question_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleChoiceQuestionResult _$SingleChoiceQuestionResultFromJson(
        Map<String, dynamic> json) =>
    SingleChoiceQuestionResult(
      id: Identifier.fromJson(json['id'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      valueIdentifier: json['valueIdentifier'] as String,
      result: json['result'] == null
          ? null
          : TextChoice.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleChoiceQuestionResultToJson(
        SingleChoiceQuestionResult instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'result': instance.result?.toJson(),
      'valueIdentifier': instance.valueIdentifier,
    };
