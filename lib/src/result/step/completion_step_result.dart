import 'package:surveykit/src/steps/identifier/identifier.dart';
import 'package:surveykit/src/result/question_result.dart';

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
}
