import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'scale_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class ScaleQuestionResult extends QuestionResult<double?> {
  ScaleQuestionResult({
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

  factory ScaleQuestionResult.fromJson(Map<String, dynamic> json) => _$ScaleQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$ScaleQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
