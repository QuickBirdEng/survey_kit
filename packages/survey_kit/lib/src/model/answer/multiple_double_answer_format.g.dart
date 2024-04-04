// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_double_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultipleDoubleAnswerFormat _$MultipleDoubleAnswerFormatFromJson(
        Map<String, dynamic> json) =>
    MultipleDoubleAnswerFormat(
      defaultValues: (json['defaultValues'] as List<dynamic>?)
          ?.map((e) => MultiDouble.fromJson(e as Map<String, dynamic>))
          .toList(),
      hints:
          (json['hints'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      question: json['question'] as String?,
      answerType: json['type'] as String?,
    );

Map<String, dynamic> _$MultipleDoubleAnswerFormatToJson(
        MultipleDoubleAnswerFormat instance) =>
    <String, dynamic>{
      'question': instance.question,
      'type': instance.answerType,
      'defaultValues': instance.defaultValues,
      'hints': instance.hints,
    };
