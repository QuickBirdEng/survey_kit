import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

import '../result/question/mock.dart';

void main() {
  test('conditional navigation rule fromJson uses step result value', () {
    final rule = ConditionalNavigationRule.fromJson(
      <String, dynamic>{
        'type': 'conditional',
        'values': <String, dynamic>{
          'Yes': 'step-yes',
          'No': 'step-no',
        },
      },
    );

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
    expect(
      rule.toJson(),
      <String, dynamic>{
        'type': 'conditional',
        'values': <String, String>{
          'Yes': 'step-yes',
          'No': 'step-no',
        },
      },
    );
  });

  test('direct navigation rule toJson includes type', () {
    final rule = DirectNavigationRule('next-step');

    expect(
      rule.toJson(),
      <String, dynamic>{
        'type': 'direct',
        'destinationStepIdentifier': 'next-step',
      },
    );
  });
}
