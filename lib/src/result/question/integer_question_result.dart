import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'integer_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class IntegerQuestionResult extends QuestionResult<int?> {
  const IntegerQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory IntegerQuestionResult.fromJson(Map<String, dynamic> json) => _$IntegerQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$IntegerQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
