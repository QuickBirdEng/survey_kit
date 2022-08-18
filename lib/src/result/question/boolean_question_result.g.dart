// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boolean_question_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooleanQuestionResult _$BooleanQuestionResultFromJson(
        Map<String, dynamic> json) =>
    BooleanQuestionResult(
      id: Identifier.fromJson(json['id'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      valueIdentifier: json['valueIdentifier'] as String,
      result: $enumDecodeNullable(_$BooleanResultEnumMap, json['result']),
    );

Map<String, dynamic> _$BooleanQuestionResultToJson(
        BooleanQuestionResult instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'result': _$BooleanResultEnumMap[instance.result],
      'valueIdentifier': instance.valueIdentifier,
    };

const _$BooleanResultEnumMap = {
  BooleanResult.NONE: 'NONE',
  BooleanResult.POSITIVE: 'POSITIVE',
  BooleanResult.NEGATIVE: 'NEGATIVE',
};
