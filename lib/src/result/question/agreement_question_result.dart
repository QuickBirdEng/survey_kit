import 'package:survey_kit/src/answer_format/boolean_answer_format.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'agreement_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class AgreementQuestionResult extends QuestionResult<BooleanResult?> {
  AgreementQuestionResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required String valueIdentifier,
    required BooleanResult? result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  factory AgreementQuestionResult.fromJson(Map<String, dynamic> json) =>
      _$AgreementQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$AgreementQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
