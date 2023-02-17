// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_choice_auto_complete_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultipleChoiceAutoCompleteAnswerFormat
    _$MultipleChoiceAutoCompleteAnswerFormatFromJson(
            Map<String, dynamic> json) =>
        MultipleChoiceAutoCompleteAnswerFormat(
          textChoices: (json['textChoices'] as List<dynamic>)
              .map((e) => TextChoice.fromJson(e as Map<String, dynamic>))
              .toList(),
          defaultSelection: (json['defaultSelection'] as List<dynamic>?)
                  ?.map((e) => TextChoice.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
          suggestions: (json['suggestions'] as List<dynamic>?)
                  ?.map((e) => TextChoice.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
          otherField: json['otherField'] as bool? ?? false,
          question: json['question'] as String?,
          answerType: json['type'] as String?,
        );

Map<String, dynamic> _$MultipleChoiceAutoCompleteAnswerFormatToJson(
        MultipleChoiceAutoCompleteAnswerFormat instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'textChoices': instance.textChoices,
      'defaultSelection': instance.defaultSelection,
      'suggestions': instance.suggestions,
      'otherField': instance.otherField,
    };
