// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageAnswerFormat _$ImageAnswerFormatFromJson(Map<String, dynamic> json) =>
    ImageAnswerFormat(
      defaultValue: json['defaultValue'] as String?,
      buttonText: json['buttonText'] as String? ?? 'Image: ',
      useGallery: json['useGallery'] as bool? ?? true,
      hintImage: json['hintImage'] as String?,
      hintTitle: json['hintTitle'] as String?,
    );

Map<String, dynamic> _$ImageAnswerFormatToJson(ImageAnswerFormat instance) =>
    <String, dynamic>{
      'defaultValue': instance.defaultValue,
      'buttonText': instance.buttonText,
      'useGallery': instance.useGallery,
      'hintImage': instance.hintImage,
      'hintTitle': instance.hintTitle,
    };
