import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'integer_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class IntegerQuestionResult extends QuestionResult<int?> {
  IntegerQuestionResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required String valueIdentifier,
    required int? result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  factory IntegerQuestionResult.fromJson(Map<String, dynamic> json) => _$IntegerQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$IntegerQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
