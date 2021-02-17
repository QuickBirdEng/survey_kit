import 'package:surveykit/src/result/question_result.dart';
import 'package:surveykit/src/steps/identifier/identifier.dart';

class InstructionStepResult extends QuestionResult {
  InstructionStepResult(
    Identifier id,
    DateTime startDate,
    DateTime endDate,
  ) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: 'instruction',
          result: null,
        );
}
