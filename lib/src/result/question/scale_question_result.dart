import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'scale_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class ScaleQuestionResult extends QuestionResult<double?> {
  const ScaleQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory ScaleQuestionResult.fromJson(Map<String, dynamic> json) => _$ScaleQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$ScaleQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
