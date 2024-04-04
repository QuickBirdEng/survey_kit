// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_choice_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleChoiceAnswerFormat _$SingleChoiceAnswerFormatFromJson(
        Map<String, dynamic> json) =>
    SingleChoiceAnswerFormat(
      textChoices: (json['textChoices'] as List<dynamic>)
          .map((e) => TextChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultSelection: json['defaultSelection'] == null
          ? null
          : TextChoice.fromJson(
              json['defaultSelection'] as Map<String, dynamic>),
      question: json['question'] as String?,
      answerType: json['type'] as String?,
    );

Map<String, dynamic> _$SingleChoiceAnswerFormatToJson(
        SingleChoiceAnswerFormat instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'textChoices': instance.textChoices.map((e) => e.toJson()).toList(),
      'defaultSelection': instance.defaultSelection?.toJson(),
    };
