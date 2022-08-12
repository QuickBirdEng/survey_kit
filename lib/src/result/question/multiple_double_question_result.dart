import 'package:survey_kit/src/answer_format/multi_double.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

class MultipleDoubleQuestionResult extends QuestionResult<List<MultiDouble>?> {
  MultipleDoubleQuestionResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required String valueIdentifier,
    required List<MultiDouble> results,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: results,
        );

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
