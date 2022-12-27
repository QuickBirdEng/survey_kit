// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_answer_formart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeAnswerFormat _$TimeAnswerFormatFromJson(Map<String, dynamic> json) =>
    TimeAnswerFormat(
      defaultValue: _$JsonConverterFromJson<Map<String, dynamic>, TimeOfDay?>(
          json['defaultValue'], const _TimeOfDayJsonConverter().fromJson),
    );

Map<String, dynamic> _$TimeAnswerFormatToJson(TimeAnswerFormat instance) =>
    <String, dynamic>{
      'defaultValue':
          const _TimeOfDayJsonConverter().toJson(instance.defaultValue),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
