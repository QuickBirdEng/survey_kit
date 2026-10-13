import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

import '../result/question/mock.dart';

void main() {
  test('conditional navigation rule fromJson uses step result value', () {
    final rule = ConditionalNavigationRule.fromJson(<String, dynamic>{
      'type': 'conditional',
      'values': <String, dynamic>{'Yes': 'step-yes', 'No': 'step-no'},
    });

    final yesResult = StepResult<String>(
      id: 'q1',
      step: sampleStep,
      startTime: DateTime.utc(2025, 1, 1),
      endTime: DateTime.utc(2025, 1, 1, 0, 0, 1),
      result: 'Yes',
    );
    final unknownResult = StepResult<String>(
      id: 'q1',
      step: sampleStep,
      startTime: DateTime.utc(2025, 1, 1),
      endTime: DateTime.utc(2025, 1, 1, 0, 0, 1),
      result: 'Maybe',
    );

    expect(
      rule.resultToStepIdentifierMapper(const [], yesResult),
      isA<NavigateToStep>().having((t) => t.stepId, 'stepId', 'step-yes'),
    );
    expect(
      rule.resultToStepIdentifierMapper(const [], unknownResult),
      isA<NavigateToNextInList>(),
    );
    expect(
      rule.resultToStepIdentifierMapper(const [], null),
      isA<NavigateToNextInList>(),
    );
    expect(rule.toJson(), <String, dynamic>{
      'type': 'conditional',
      'values': <String, String>{'Yes': 'step-yes', 'No': 'step-no'},
    });
  });

  test('direct navigation rule toJson includes type', () {
    final rule = DirectNavigationRule('next-step');

    expect(rule.toJson(), <String, dynamic>{
      'type': 'direct',
      'destinationStepIdentifier': 'next-step',
    });
  });

  group('conditional navigation rule fromJson matches typed results', () {
    final rule = ConditionalNavigationRule.fromJson(<String, dynamic>{
      'type': 'conditional',
      'values': <String, dynamic>{
        'yes': 'step-yes',
        'Maybe': 'step-maybe',
        'negative': FinishSurvey.jsonValue,
        '2024-01-02T00:00:00.000Z': 'step-date',
      },
    });

    NavigationTarget resolve(Object? value) => rule.resolve(
      const [],
      StepResult<Object?>(
        id: 'q1',
        step: sampleStep,
        startTime: DateTime.utc(2025),
        endTime: DateTime.utc(2025),
        result: value,
      ),
    );

    test('TextChoice by value', () {
      expect(
        resolve(TextChoice(id: 'c1', text: 'Yes', value: 'yes')),
        isA<NavigateToStep>().having((t) => t.stepId, 'stepId', 'step-yes'),
      );
    });

    test('TextChoice by text when value is missing', () {
      expect(
        resolve(TextChoice(id: 'c2', text: 'Maybe')),
        isA<NavigateToStep>().having((t) => t.stepId, 'stepId', 'step-maybe'),
      );
    });

    test('BooleanResult by name', () {
      expect(resolve(BooleanResult.negative), isA<FinishSurvey>());
      expect(resolve(BooleanResult.positive), isA<NavigateToNextInList>());
    });

    test('DateTime by ISO string', () {
      expect(
        resolve(DateTime.utc(2024, 1, 2)),
        isA<NavigateToStep>().having((t) => t.stepId, 'stepId', 'step-date'),
      );
    });
  });
}
