// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integer_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntegerAnswerFormat _$IntegerAnswerFormatFromJson(Map<String, dynamic> json) =>
    IntegerAnswerFormat(
      defaultValue: json['defaultValue'] as int?,
      hint: json['hint'] as String? ?? '',
      min: json['min'] as int? ?? minInt,
      max: json['max'] as int? ?? maxInt,
    );

Map<String, dynamic> _$IntegerAnswerFormatToJson(
        IntegerAnswerFormat instance) =>
    <String, dynamic>{
      'defaultValue': instance.defaultValue,
      'hint': instance.hint,
      'min': instance.min,
      'max': instance.max,
    };
