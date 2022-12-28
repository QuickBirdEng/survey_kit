// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepResult<T> _$StepResultFromJson<T>(Map<String, dynamic> json) =>
    StepResult<T>(
      id: json['id'] as String,
      result: _$JsonConverterFromJson<Object, T>(
          json['result'], _Converter<T?>().fromJson),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      valueIdentifier: json['valueIdentifier'] as String?,
    );

Map<String, dynamic> _$StepResultToJson<T>(StepResult<T> instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': _$JsonConverterToJson<Object, T>(
          instance.result, _Converter<T?>().toJson),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'valueIdentifier': instance.valueIdentifier,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
