// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction_step_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructionStepResult _$InstructionStepResultFromJson(
        Map<String, dynamic> json) =>
    InstructionStepResult(
      Identifier.fromJson(json['id'] as Map<String, dynamic>),
      DateTime.parse(json['startDate'] as String),
      DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$InstructionStepResultToJson(
        InstructionStepResult instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
