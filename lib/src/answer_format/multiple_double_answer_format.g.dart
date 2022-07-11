// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_double_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultipleDoubleAnswerFormat _$DoubleAnswerFormatFromJson(
        Map<String, dynamic> json) =>
    MultipleDoubleAnswerFormat(
      multiDouble: (json['multiDouble'] as List<dynamic>)
          .map((e) => MultiDouble.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultValues: (json['defaultValues'] as List<dynamic>?)
              ?.map((e) => MultiDouble.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DoubleAnswerFormatToJson(
        MultipleDoubleAnswerFormat instance) =>
    <String, dynamic>{
      'multiDouble': instance.multiDouble,
      'defaultValues': instance.defaultValues,
    };
