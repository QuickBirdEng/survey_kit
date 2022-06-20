// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_answer_formart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeAnswerFormat _$TimeAnswerFormatFromJson(Map<String, dynamic> json) =>
    TimeAnswerFormat(
      defaultValue: const _TimeOfDayJsonConverter()
          .fromJson(json['defaultValue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimeAnswerFormatToJson(TimeAnswerFormat instance) =>
    <String, dynamic>{
      'defaultValue':
          const _TimeOfDayJsonConverter().toJson(instance.defaultValue),
    };
