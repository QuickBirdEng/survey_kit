// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_select_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleSelectAnswer _$SingleSelectAnswerFromJson(Map<String, dynamic> json) =>
    SingleSelectAnswer(
      options: (json['options'] as List<dynamic>)
          .map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultSelection: json['defaultSelection'] == null
          ? null
          : Option.fromJson(json['defaultSelection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleSelectAnswerToJson(SingleSelectAnswer instance) =>
    <String, dynamic>{
      'options': instance.options,
      'defaultSelection': instance.defaultSelection,
    };
