import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';
import 'package:survey_kit/src/answer_format/boolean_answer_format.dart';

part 'agreement_answer_format.g.dart';

@JsonSerializable()
class AgreementAnswerFormat implements AnswerFormat {
  final BooleanResult result;
  final BooleanResult? defaultValue;
  final String? markdownDescription;
  final String? markdownAgreementText;

  const AgreementAnswerFormat({
    this.result = BooleanResult.NEGATIVE,
    this.defaultValue,
    this.markdownDescription,
    this.markdownAgreementText,
  }) : super();

  factory AgreementAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$AgreementAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$AgreementAnswerFormatToJson(this);
}
