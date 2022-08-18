import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';

import 'package:json_annotation/json_annotation.dart';

part 'date_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class DateQuestionResult extends QuestionResult<DateTime?> {
  DateQuestionResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required String valueIdentifier,
    required DateTime? result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  factory DateQuestionResult.fromJson(Map<String, dynamic> json) => _$DateQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$DateQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
