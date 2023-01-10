// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Step _$StepFromJson(Map<String, dynamic> json) => Step(
      id: json['id'] as String?,
      content: (json['content'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
      isMandatory: json['isMandatory'] as bool? ?? true,
      answerFormat: json['answerFormat'] == null
          ? null
          : AnswerFormat.fromJson(json['answerFormat'] as Map<String, dynamic>),
      buttonText: json['buttonText'] as String?,
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'id': instance.id,
      'isMandatory': instance.isMandatory,
      'answerFormat': instance.answerFormat,
      'buttonText': instance.buttonText,
      'content': instance.content,
    };
