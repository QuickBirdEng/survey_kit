import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/model/answer/boolean_answer_format.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final tQuestionResults = <StepResult>[
    StepResult<void>(
      id: 'example1_intro',
      startTime: DateTime(2022, 8, 12, 16, 4),
      endTime: DateTime(2022, 8, 12, 16, 5),
      result: null,
    ),
    StepResult<BooleanResult>(
      id: 'example1_boolean',
      startTime: DateTime(2022, 8, 12, 16, 5),
      endTime: DateTime(2022, 8, 12, 16, 10),
      valueIdentifier: 'bool1',
      result: BooleanResult.negative,
    ),
    StepResult<void>(
      id: 'example1_intro',
      startTime: DateTime(2022, 8, 12, 16, 4),
      endTime: DateTime(2022, 8, 12, 16, 5),
      result: null,
    ),
  ];
  final tSurveyResult = SurveyResult(
    id: 'example1',
    startTime: DateTime(2022, 8, 12, 16, 4),
    endTime: DateTime(2022, 8, 12, 16, 14),
    finishReason: FinishReason.completed,
    results: [
      StepResult<dynamic>(
        id: 'example1_stepResult',
        startTime: DateTime(2022, 8, 12, 16, 5),
        endTime: DateTime(2022, 8, 12, 16, 10),
        result: tQuestionResults,
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
