import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'completion_step_result.g.dart';

@JsonSerializable(explicitToJson: true)
class CompletionStepResult extends QuestionResult {
  CompletionStepResult(
    Identifier id,
    DateTime startDate,
    DateTime endDate,
  ) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: 'completion',
          result: null,
        );
  factory CompletionStepResult.fromJson(Map<String, dynamic> json) =>
      _$CompletionStepResultFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionStepResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier];
}
