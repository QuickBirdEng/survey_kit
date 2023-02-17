// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_choice_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultipleChoiceAnswerFormat _$MultipleChoiceAnswerFormatFromJson(
        Map<String, dynamic> json) =>
    MultipleChoiceAnswerFormat(
      textChoices: (json['textChoices'] as List<dynamic>)
          .map((e) => TextChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      otherField: json['otherField'] as bool? ?? false,
      defaultSelection: json['defaultSelection'] == null
          ? null
          : TextChoice.fromJson(
              json['defaultSelection'] as Map<String, dynamic>),
      question: json['question'] as String?,
      answerType: json['type'] as String?,
    );

Map<String, dynamic> _$MultipleChoiceAnswerFormatToJson(
        MultipleChoiceAnswerFormat instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'textChoices': instance.textChoices,
      'defaultSelection': instance.defaultSelection,
      'otherField': instance.otherField,
    };
