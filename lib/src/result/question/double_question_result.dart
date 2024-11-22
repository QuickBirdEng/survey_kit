import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'double_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class DoubleQuestionResult extends QuestionResult<double?> {
  const DoubleQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory DoubleQuestionResult.fromJson(Map<String, dynamic> json) => _$DoubleQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$DoubleQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
