import 'package:survey_kit/src/answer_format/text_choice.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'multiple_choice_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class MultipleChoiceQuestionResult extends QuestionResult<List<TextChoice>?> {
  const MultipleChoiceQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory MultipleChoiceQuestionResult.fromJson(Map<String, dynamic> json) =>
      _$MultipleChoiceQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$MultipleChoiceQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
