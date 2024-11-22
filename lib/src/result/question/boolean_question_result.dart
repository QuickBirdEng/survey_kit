import 'package:survey_kit/src/answer_format/boolean_answer_format.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'boolean_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class BooleanQuestionResult extends QuestionResult<BooleanResult?> {
  const BooleanQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory BooleanQuestionResult.fromJson(Map<String, dynamic> json) => _$BooleanQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$BooleanQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
