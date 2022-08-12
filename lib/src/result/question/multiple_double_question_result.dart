import 'package:survey_kit/src/answer_format/multi_double.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'multiple_double_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class MultipleDoubleQuestionResult extends QuestionResult<List<MultiDouble>?> {
  MultipleDoubleQuestionResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required String valueIdentifier,
    required List<MultiDouble>? result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  factory MultipleDoubleQuestionResult.fromJson(Map<String, dynamic> json) => _$MultipleDoubleQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$MultipleDoubleQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
