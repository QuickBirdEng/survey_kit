import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  test('SurveyDefinition.fromJson parses flow task type', () {
    final task = SurveyFlow(
      id: 'flow-task',
      steps: const <Step>[],
      navigationRules: <String, NavigationRule>{
        'start': DirectNavigationRule('end'),
      },
    );

    final decoded = SurveyDefinition.fromJson(task.toJson());
    expect(decoded, isA<SurveyFlow>());

    final flow = decoded as SurveyFlow;
    final directRule = flow.getRuleByStepIdentifier('start');
    expect(directRule, isA<DirectNavigationRule>());
    expect(
      (directRule! as DirectNavigationRule).destinationStepIdentifier,
      'end',
    );
  });

  test('SurveyFlow toJson serializes initialStep as map', () {
    final initialStep = Step(
      id: 'initial-step',
      content: const <Content>[],
      buttonText: 'Next',
    );
    final task = SurveyFlow(
      id: 'flow-with-initial',
      steps: <Step>[initialStep],
      initialStep: initialStep,
    );

    final encoded = task.toJson();
    expect(encoded['initialStep'], isA<Map<String, dynamic>>());

    final decoded = SurveyDefinition.fromJson(encoded);
    expect(decoded.initialStep?.id, initialStep.id);
  });

  test('SurveyDefinition.fromJson keeps legacy ordered type compatibility', () {
    final json = <String, dynamic>{
      ...SurveyFlow(
        id: 'legacy-ordered',
        steps: const <Step>[],
      ).toJson(),
      'type': 'ordered',
    };

    final decoded = SurveyDefinition.fromJson(json);
    expect(decoded, isA<SurveyFlow>());
    expect((decoded as SurveyFlow).navigationRules, isEmpty);
  });

  test(
      'SurveyDefinition.fromJson keeps legacy navigable type compatibility',
      () {
    final json = <String, dynamic>{
      ...SurveyFlow(
        id: 'legacy-navigable',
        steps: const <Step>[],
        navigationRules: <String, NavigationRule>{
          'start': ConditionalNavigationRule(
            resultToStepIdentifierMapper: (results, input) => null,
            values: const <String, String>{
              'yes': 'yes',
              'no': 'no',
            },
          ),
        },
      ).toJson(),
      'type': 'navigable',
    };

    final decoded = SurveyDefinition.fromJson(json);
    expect(decoded, isA<SurveyFlow>());
    expect(
      (decoded as SurveyFlow).getRuleByStepIdentifier('start'),
      isNotNull,
    );
  });
}
