// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageAnswerFormat _$ImageAnswerFormatFromJson(Map<String, dynamic> json) =>
    ImageAnswerFormat(
      defaultValue: json['defaultValue'] as String?,
      buttonText: json['buttonText'] as String? ?? 'Image: ',
      question: json['question'] as String?,
      answerType: json['type'] as String?,
    );

Map<String, dynamic> _$ImageAnswerFormatToJson(ImageAnswerFormat instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'defaultValue': instance.defaultValue,
      'buttonText': instance.buttonText,
    };
