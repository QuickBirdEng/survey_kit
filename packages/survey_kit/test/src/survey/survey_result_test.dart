import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

import '../result/question/mock.dart';

void main() {
  final tQuestionResults = <StepResult>[
    StepResult<void>(
      id: 'example1_intro',
      step: sampleStep,
      startTime: DateTime.utc(2022, 8, 12, 16, 4),
      endTime: DateTime.utc(2022, 8, 12, 16, 5),
      result: null,
    ),
    StepResult<BooleanResult>(
      id: 'example1_boolean',
      step: sampleStep,
      startTime: DateTime.utc(2022, 8, 12, 16, 5),
      endTime: DateTime.utc(2022, 8, 12, 16, 10),
      valueIdentifier: 'bool1',
      result: BooleanResult.negative,
    ),
  ];
  final tSurveyResult = SurveyResult(
    id: 'example1',
    startTime: DateTime.utc(2022, 8, 12, 16, 4),
    endTime: DateTime.utc(2022, 8, 12, 16, 14),
    finishReason: FinishReason.completed,
    results: [
      StepResult<List<StepResult>>(
        id: 'example1_stepResult',
        step: sampleStep,
        startTime: DateTime.utc(2022, 8, 12, 16, 5),
        endTime: DateTime.utc(2022, 8, 12, 16, 10),
        result: tQuestionResults,
      ),
      StepResult<TextChoice>(
        id: 'example1_choice',
        step: sampleStep,
        startTime: DateTime.utc(2022, 8, 12, 16, 10),
        endTime: DateTime.utc(2022, 8, 12, 16, 11),
        result: TextChoice(id: 'c', text: 'Yes', value: 'yes'),
      ),
    ],
  );

  group('serialisation', () {
    test('round-trips through jsonEncode and jsonDecode', () {
      final encoded = jsonEncode(tSurveyResult.toJson());
      final decoded = SurveyResult.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>,
      );
      expect(decoded, tSurveyResult);
      expect(decoded.hashCode, tSurveyResult.hashCode);
      expect(decoded.results[1].result, isA<TextChoice>());
    });
  });

  group('equality', () {
    SurveyResult build() => SurveyResult(
      id: 'x',
      startTime: DateTime.utc(2020),
      endTime: DateTime.utc(2020),
      finishReason: FinishReason.completed,
      results: [
        StepResult<String>(
          id: 'q',
          step: sampleStep,
          startTime: DateTime.utc(2020),
          endTime: DateTime.utc(2020),
          result: 'a',
        ),
      ],
    );

    test('equal results have equal hash codes', () {
      expect(build(), build());
      expect(build().hashCode, build().hashCode);
    });
  });
}
