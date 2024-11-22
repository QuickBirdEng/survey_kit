import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'text_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class TextQuestionResult extends QuestionResult<String?> {
  const TextQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory TextQuestionResult.fromJson(Map<String, dynamic> json) => _$TextQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$TextQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
