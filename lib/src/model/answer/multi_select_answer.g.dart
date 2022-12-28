// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_select_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSelectAnswer _$MultiSelectAnswerFromJson(Map<String, dynamic> json) =>
    MultiSelectAnswer(
      options: (json['options'] as List<dynamic>)
          .map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      otherField: json['otherField'] as bool? ?? false,
      defaultSelection: json['defaultSelection'] == null
          ? null
          : Option.fromJson(json['defaultSelection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MultiSelectAnswerToJson(MultiSelectAnswer instance) =>
    <String, dynamic>{
      'options': instance.options,
      'defaultSelection': instance.defaultSelection,
      'otherField': instance.otherField,
    };
