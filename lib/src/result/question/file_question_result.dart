import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';

class FileQuestionResult extends QuestionResult<String?> {
  FileQuestionResult({
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
}
