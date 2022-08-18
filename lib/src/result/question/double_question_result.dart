import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'double_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class DoubleQuestionResult extends QuestionResult<double?> {
  DoubleQuestionResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required String valueIdentifier,
    required double? result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  factory DoubleQuestionResult.fromJson(Map<String, dynamic> json) => _$DoubleQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$DoubleQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
