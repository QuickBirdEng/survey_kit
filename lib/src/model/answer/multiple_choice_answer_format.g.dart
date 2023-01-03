// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_choice_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultipleChoiceAnswerFormat _$MultipleChoiceAnswerFormatFromJson(
        Map<String, dynamic> json) =>
    MultipleChoiceAnswerFormat(
      options: (json['options'] as List<dynamic>)
          .map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      otherField: json['otherField'] as bool? ?? false,
      defaultSelection: json['defaultSelection'] == null
          ? null
          : Option.fromJson(json['defaultSelection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MultipleChoiceAnswerFormatToJson(
        MultipleChoiceAnswerFormat instance) =>
    <String, dynamic>{
      'options': instance.options,
      'defaultSelection': instance.defaultSelection,
      'otherField': instance.otherField,
    };
