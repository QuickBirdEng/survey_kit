// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_choice_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultipleChoiceAnswerFormat _$MultipleChoiceAnswerFormatFromJson(
    Map<String, dynamic> json) {
  return MultipleChoiceAnswerFormat(
    textChoices: (json['textChoices'] as List<dynamic>)
        .map((e) => TextChoice.fromJson(e as Map<String, dynamic>))
        .toList(),
    defaultSelection: (json['defaultSelection'] as List<dynamic>?)
            ?.map((e) => TextChoice.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$MultipleChoiceAnswerFormatToJson(
        MultipleChoiceAnswerFormat instance) =>
    <String, dynamic>{
      'textChoices': instance.textChoices,
      'defaultSelection': instance.defaultSelection,
    };
