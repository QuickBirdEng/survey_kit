// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeAnswerFormat _$TimeAnswerFormatFromJson(Map<String, dynamic> json) =>
    TimeAnswerFormat(
      defaultValue: _$JsonConverterFromJson<Map<String, dynamic>, TimeOfDay?>(
          json['defaultValue'], const _TimeOfDayJsonConverter().fromJson),
      question: json['question'] as String?,
      answerType: json['type'] as String?,
    );

Map<String, dynamic> _$TimeAnswerFormatToJson(TimeAnswerFormat instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'defaultValue':
          const _TimeOfDayJsonConverter().toJson(instance.defaultValue),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
