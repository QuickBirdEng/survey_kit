import 'package:survey_kit/src/answer_format/text_choice.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'single_choice_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SingleChoiceQuestionResult extends QuestionResult<TextChoice?> {
  const SingleChoiceQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory SingleChoiceQuestionResult.fromJson(Map<String, dynamic> json) => _$SingleChoiceQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$SingleChoiceQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
