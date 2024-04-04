// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateAnswerFormat _$DateAnswerFormatFromJson(Map<String, dynamic> json) =>
    DateAnswerFormat(
      defaultDate: json['defaultDate'] == null
          ? null
          : DateTime.parse(json['defaultDate'] as String),
      minDate: json['minDate'] == null
          ? null
          : DateTime.parse(json['minDate'] as String),
      maxDate: json['maxDate'] == null
          ? null
          : DateTime.parse(json['maxDate'] as String),
      question: json['question'] as String?,
      answerType: json['type'] as String?,
    );

Map<String, dynamic> _$DateAnswerFormatToJson(DateAnswerFormat instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'defaultDate': instance.defaultDate?.toIso8601String(),
      'minDate': instance.minDate?.toIso8601String(),
      'maxDate': instance.maxDate?.toIso8601String(),
    };
