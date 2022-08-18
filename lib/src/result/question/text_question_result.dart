import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'text_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class TextQuestionResult extends QuestionResult<String?> {
  TextQuestionResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required String valueIdentifier,
    required String? result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  factory TextQuestionResult.fromJson(Map<String, dynamic> json) => _$TextQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$TextQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
