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
    );

Map<String, dynamic> _$SingleChoiceAnswerFormatToJson(
        SingleChoiceAnswerFormat instance) =>
    <String, dynamic>{
      'textChoices': instance.textChoices,
      'defaultSelection': instance.defaultSelection,
    };
