// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepResult _$StepResultFromJson(Map<String, dynamic> json) => StepResult(
      id: json['id'] == null
          ? null
          : Identifier.fromJson(json['id'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      results: const _Converter().fromJson(json['results'] as Object),
    );

Map<String, dynamic> _$StepResultToJson(StepResult instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'results': const _Converter().toJson(instance.results),
    };
