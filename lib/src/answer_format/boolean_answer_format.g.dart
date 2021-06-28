// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boolean_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooleanAnswerFormat _$BooleanAnswerFormatFromJson(Map<String, dynamic> json) {
  return BooleanAnswerFormat(
    positiveAnswer: json['positiveAnswer'] as String,
    negativeAnswer: json['negativeAnswer'] as String,
    result: _$enumDecode(_$BooleanResultEnumMap, json['result']),
  );
}

Map<String, dynamic> _$BooleanAnswerFormatToJson(
        BooleanAnswerFormat instance) =>
    <String, dynamic>{
      'positiveAnswer': instance.positiveAnswer,
      'negativeAnswer': instance.negativeAnswer,
      'result': _$BooleanResultEnumMap[instance.result],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$BooleanResultEnumMap = {
  BooleanResult.NONE: 'NONE',
  BooleanResult.POSITIVE: 'POSITIVE',
  BooleanResult.NEGATIVE: 'NEGATIVE',
};
