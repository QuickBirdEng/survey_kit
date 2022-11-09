// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageAnswerFormat _$ImageAnswerFormatFromJson(Map<String, dynamic> json) =>
    ImageAnswerFormat(
      defaultValue: json['defaulValue'] as String?,
      buttonText: json['hint'] as String? ?? '',
    );

Map<String, dynamic> _$ImageAnswerFormatToJson(ImageAnswerFormat instance) =>
    <String, dynamic>{
      'defaultValue': instance.defaultValue,
      'hint': instance.buttonText,
    };
