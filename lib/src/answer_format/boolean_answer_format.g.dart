// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boolean_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooleanAnswerFormat _$BooleanAnswerFormatFromJson(Map<String, dynamic> json) =>
    BooleanAnswerFormat(
      positiveAnswer: json['positiveAnswer'] as String,
      negativeAnswer: json['negativeAnswer'] as String,
      result: $enumDecodeNullable(_$BooleanResultEnumMap, json['result']) ??
          BooleanResult.NONE,
      defaultValue:
          $enumDecodeNullable(_$BooleanResultEnumMap, json['defaultValue']),
    );

Map<String, dynamic> _$BooleanAnswerFormatToJson(
        BooleanAnswerFormat instance) =>
    <String, dynamic>{
      'positiveAnswer': instance.positiveAnswer,
      'negativeAnswer': instance.negativeAnswer,
      'result': _$BooleanResultEnumMap[instance.result]!,
      'defaultValue': _$BooleanResultEnumMap[instance.defaultValue],
    };

const _$BooleanResultEnumMap = {
  BooleanResult.NONE: 'NONE',
  BooleanResult.POSITIVE: 'POSITIVE',
  BooleanResult.NEGATIVE: 'NEGATIVE',
};
