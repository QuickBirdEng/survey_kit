// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScaleAnswerFormat _$ScaleAnswerFormatFromJson(Map<String, dynamic> json) {
  return ScaleAnswerFormat(
    maximumValue: (json['maximumValue'] as num).toDouble(),
    minimumValue: (json['minimumValue'] as num).toDouble(),
    defaultValue: (json['defaultValue'] as num).toDouble(),
    step: (json['step'] as num).toDouble(),
    maximumValueDescription: json['maximumValueDescription'] as String,
    minimumValueDescription: json['minimumValueDescription'] as String,
  );
}

Map<String, dynamic> _$ScaleAnswerFormatToJson(ScaleAnswerFormat instance) =>
    <String, dynamic>{
      'maximumValue': instance.maximumValue,
      'minimumValue': instance.minimumValue,
      'defaultValue': instance.defaultValue,
      'step': instance.step,
      'maximumValueDescription': instance.maximumValueDescription,
      'minimumValueDescription': instance.minimumValueDescription,
    };
