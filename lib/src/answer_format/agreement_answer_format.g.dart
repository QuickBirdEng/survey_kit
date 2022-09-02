// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreement_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleCheckboxAnswerFormat _$SingleCheckboxAnswerFormatFromJson(
        Map<String, dynamic> json) =>
    SingleCheckboxAnswerFormat(
      result: $enumDecodeNullable(_$BooleanResultEnumMap, json['result']) ??
          BooleanResult.NEGATIVE,
      defaultValue:
          $enumDecodeNullable(_$BooleanResultEnumMap, json['defaultValue']),
      markdownDescription: json['markdownDescription'] as String?,
      markdownAgreementText: json['markdownAgreementText'] as String?,
    );

Map<String, dynamic> _$SingleCheckboxAnswerFormatToJson(
        SingleCheckboxAnswerFormat instance) =>
    <String, dynamic>{
      'result': _$BooleanResultEnumMap[instance.result],
      'defaultValue': _$BooleanResultEnumMap[instance.defaultValue],
      'markdownDescription': instance.markdownDescription,
      'markdownAgreementText': instance.markdownAgreementText,
    };

const _$BooleanResultEnumMap = {
  BooleanResult.NONE: 'NONE',
  BooleanResult.POSITIVE: 'POSITIVE',
  BooleanResult.NEGATIVE: 'NEGATIVE',
};
