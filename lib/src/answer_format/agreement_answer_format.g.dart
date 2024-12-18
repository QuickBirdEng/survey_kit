// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreement_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgreementAnswerFormat _$AgreementAnswerFormatFromJson(
        Map<String, dynamic> json) =>
    AgreementAnswerFormat(
      result: $enumDecodeNullable(_$BooleanResultEnumMap, json['result']) ??
          BooleanResult.NEGATIVE,
      defaultValue:
          $enumDecodeNullable(_$BooleanResultEnumMap, json['defaultValue']),
      markdownDescription: json['markdownDescription'] as String?,
      markdownAgreementText: json['markdownAgreementText'] as String?,
    );

Map<String, dynamic> _$AgreementAnswerFormatToJson(
        AgreementAnswerFormat instance) =>
    <String, dynamic>{
      'result': _$BooleanResultEnumMap[instance.result]!,
      'defaultValue': _$BooleanResultEnumMap[instance.defaultValue],
      'markdownDescription': instance.markdownDescription,
      'markdownAgreementText': instance.markdownAgreementText,
    };

const _$BooleanResultEnumMap = {
  BooleanResult.NONE: 'NONE',
  BooleanResult.POSITIVE: 'POSITIVE',
  BooleanResult.NEGATIVE: 'NEGATIVE',
};
