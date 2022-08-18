import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final List<QuestionResult> tQuestionResults = ([
    InstructionStepResult(
      Identifier(id: 'example1_intro'),
      DateTime(2022, 8, 12, 16, 4),
      DateTime(2022, 8, 12, 16, 5),
    ),
    BooleanQuestionResult(
      id: Identifier(id: 'example1_boolean'),
      startDate: DateTime(2022, 8, 12, 16, 5),
      endDate: DateTime(2022, 8, 12, 16, 10),
      valueIdentifier: 'bool1',
      result: BooleanResult.NEGATIVE,
    ),
    CompletionStepResult(
      Identifier(id: 'example1_completion'),
      DateTime(2022, 8, 12, 16, 10),
      DateTime(2022, 8, 12, 16, 14),
    ),
  ]);
  final tSurveyResult = SurveyResult(
    id: Identifier(id: 'example1'),
    startDate: DateTime(2022, 8, 12, 16, 4),
    endDate: DateTime(2022, 8, 12, 16, 14),
    finishReason: FinishReason.COMPLETED,
    results: [
      StepResult(
        id: Identifier(id: 'example1_stepResult'),
        startDate: DateTime(2022, 8, 12, 16, 5),
        endDate: DateTime(2022, 8, 12, 16, 10),
        results: tQuestionResults,
      ),
    ],
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tSurveyResult.toJson();
        final decodedResult = SurveyResult.fromJson(encodedResult);
        expect(tSurveyResult, decodedResult);
      },
    );
  });
}
