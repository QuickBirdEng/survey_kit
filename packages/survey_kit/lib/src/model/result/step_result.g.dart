// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepResult<T> _$StepResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    StepResult<T>(
      id: json['id'] as String,
      result: _$nullableGenericFromJson(json['result'], fromJsonT),
      startTime:
          const CustomDateTimeConverter().fromJson(json['startTime'] as String),
      endTime:
          const CustomDateTimeConverter().fromJson(json['endTime'] as String),
      step: Step.fromJson(json['step'] as Map<String, dynamic>),
      valueIdentifier: json['valueIdentifier'] as String?,
    );

Map<String, dynamic> _$StepResultToJson<T>(
  StepResult<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{
    'id': instance.id,
    'step': instance.step,
    'result': _$nullableGenericToJson(instance.result, toJsonT),
    'startTime': const CustomDateTimeConverter().toJson(instance.startTime),
    'endTime': const CustomDateTimeConverter().toJson(instance.endTime),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('valueIdentifier', instance.valueIdentifier);
  return val;
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
