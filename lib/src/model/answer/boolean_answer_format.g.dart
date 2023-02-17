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
          BooleanResult.none,
      question: json['question'] as String?,
      answerType: json['type'] as String?,
    );

Map<String, dynamic> _$BooleanAnswerFormatToJson(
        BooleanAnswerFormat instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'positiveAnswer': instance.positiveAnswer,
      'negativeAnswer': instance.negativeAnswer,
      'result': _$BooleanResultEnumMap[instance.result]!,
    };

const _$BooleanResultEnumMap = {
  BooleanResult.none: 'none',
  BooleanResult.positive: 'positive',
  BooleanResult.negative: 'negative',
};
