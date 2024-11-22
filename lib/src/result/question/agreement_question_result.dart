import 'package:survey_kit/src/answer_format/boolean_answer_format.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'agreement_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class AgreementQuestionResult extends QuestionResult<BooleanResult?> {
  const AgreementQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory AgreementQuestionResult.fromJson(Map<String, dynamic> json) =>
      _$AgreementQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$AgreementQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
