// CODE TO BE GENERATED   

part of 'double_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubleAnswerFormat _$DoubleAnswerFormatFromJson(Map<String, dynamic> json) {
  return DoubleAnswerFormat(
    defaultValue: json['defaultValue'] as double?,
    hint: json['hint'] as String,
  );
}

Map<String, dynamic> _$DoubleAnswerFormatToJson(
        DoubleAnswerFormat instance) =>
    <String, dynamic>{
      'defaultValue': instance.defaultValue,
      'hint': instance.hint,
    };
