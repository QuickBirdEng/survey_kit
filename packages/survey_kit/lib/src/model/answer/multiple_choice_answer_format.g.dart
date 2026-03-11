// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_choice_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultipleChoiceAnswerFormat<T> _$MultipleChoiceAnswerFormatFromJson<
        T extends TextChoice>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    MultipleChoiceAnswerFormat<T>(
      choices: (json['textChoices'] as List<dynamic>).map(fromJsonT).toList(),
      otherField: json['otherField'] as bool? ?? false,
      defaultSelection:
          _$nullableGenericFromJson(json['defaultSelection'], fromJsonT),
      question: json['question'] as String?,
      answerType: json['type'] as String? ?? MultipleChoiceAnswerFormat.type,
    );

Map<String, dynamic> _$MultipleChoiceAnswerFormatToJson<T extends TextChoice>(
  MultipleChoiceAnswerFormat<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'textChoices': instance.choices.map(toJsonT).toList(),
      'defaultSelection':
          _$nullableGenericToJson(instance.defaultSelection, toJsonT),
      'otherField': instance.otherField,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
