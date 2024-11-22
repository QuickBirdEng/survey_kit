import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';

import 'package:json_annotation/json_annotation.dart';

part 'date_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class DateQuestionResult extends QuestionResult<DateTime?> {
  const DateQuestionResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required String super.valueIdentifier,
    required super.result,
  });

  factory DateQuestionResult.fromJson(Map<String, dynamic> json) => _$DateQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$DateQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
