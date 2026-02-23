// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_choice_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleChoiceAnswerFormat<T>
    _$SingleChoiceAnswerFormatFromJson<T extends TextChoice>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
        SingleChoiceAnswerFormat<T>(
          textChoices:
              (json['textChoices'] as List<dynamic>).map(fromJsonT).toList(),
          defaultSelection:
              _$nullableGenericFromJson(json['defaultSelection'], fromJsonT),
          question: json['question'] as String?,
          answerType: json['type'] as String? ?? SingleChoiceAnswerFormat.type,
        );

Map<String, dynamic> _$SingleChoiceAnswerFormatToJson<T extends TextChoice>(
  SingleChoiceAnswerFormat<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'textChoices': instance.textChoices.map(toJsonT).toList(),
      'defaultSelection':
          _$nullableGenericToJson(instance.defaultSelection, toJsonT),
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
