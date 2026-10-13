import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

class _SkipToLastRule extends NavigationRule {
  const _SkipToLastRule();

  @override
  NavigationTarget resolve(
    List<StepResult> previousResults,
    StepResult? questionResult,
  ) => const NavigateToStep('c');

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'type': 'skipToLast'};
}

Step _step(String id) => Step(
  id: id,
  content: [TextContent(text: id)],
  answerFormat: const TextAnswerFormat(),
);

StepResult _resultFor(Step step) => StepResult<String>(
  id: step.id,
  step: step,
  result: 'x',
  startTime: DateTime.utc(2020),
  endTime: DateTime.utc(2020),
);

void main() {
  final a = _step('a');
  final b = _step('b');
  final c = _step('c');

  test('initial step decoded from json is found by id', () {
    final flow = SurveyFlow(id: 'f', steps: [a, b, c], initialStep: b);
    final decoded = SurveyFlow.fromJson(
      jsonDecode(jsonEncode(flow.toJson())) as Map<String, dynamic>,
    );
    final navigator = NavigableTaskNavigator(decoded);
    final first = navigator.firstStep()!;

    expect(identical(first, decoded.steps[1]), isFalse);
    expect(navigator.currentStepIndex(first), 1);
  });

  test('custom rule overriding resolve is evaluated', () {
    final navigator = NavigableTaskNavigator(
      SurveyFlow(
        id: 'f',
        steps: [a, b, c],
        navigationRules: const {'a': _SkipToLastRule()},
      ),
    );

    expect(navigator.nextStep(step: a, previousResults: const [])?.id, 'c');
  });

  test('custom rule can be registered for json decoding', () {
    NavigationRule.registerFromJson(
      'skipToLast',
      (json) => const _SkipToLastRule(),
    );
    final flow = SurveyFlow(
      id: 'f',
      steps: [a, b, c],
      navigationRules: const {'a': _SkipToLastRule()},
    );
    final decoded = SurveyFlow.fromJson(
      jsonDecode(jsonEncode(flow.toJson())) as Map<String, dynamic>,
    );

    expect(decoded.getRuleByStepIdentifier('a'), isA<_SkipToLastRule>());
  });

  test('missing navigation target throws a descriptive error', () {
    final navigator = NavigableTaskNavigator(
      SurveyFlow(
        id: 'f',
        steps: [a, b],
        navigationRules: {'a': DirectNavigationRule('missing')},
      ),
    );

    expect(
      () => navigator.nextStep(step: a, previousResults: const []),
      throwsA(
        isA<StateError>().having(
          (e) => e.message,
          'message',
          allOf(contains('"a"'), contains('"missing"')),
        ),
      ),
    );
  });

  test('back navigation returns visited steps and tracks visit order', () {
    final navigator = NavigableTaskNavigator(
      SurveyFlow(
        id: 'f',
        steps: [a, b, c],
        navigationRules: {'a': DirectNavigationRule('c')},
      ),
    );

    final next = navigator.nextStep(step: a, previousResults: [_resultFor(a)])!;
    expect(next.id, 'c');
    expect(navigator.visitedStepIds(currentStep: next), ['a', 'c']);
    expect(navigator.previousInList(next)?.id, 'a');
    expect(navigator.visitedStepIds(), isEmpty);
  });

  test('navigable task navigator handles empty steps', () {
    final navigator = NavigableTaskNavigator(
      SurveyFlow(id: 'navigable-empty', steps: const []),
    );

    expect(navigator.firstStep(), isNull);
  });

  test('navigable task serializes rules with type and trigger step', () {
    final first = Step(
      id: 'step-1',
      content: const [TextContent(text: 'start')],
      buttonText: 'next',
    );
    final second = Step(
      id: 'step-2',
      content: const [TextContent(text: 'end')],
      buttonText: 'done',
    );

    final task = SurveyFlow(
      id: 'navigable-json',
      steps: [first, second],
      navigationRules: <String, NavigationRule>{
        'step-1': DirectNavigationRule('step-2'),
      },
    );

    final encoded = task.toJson();
    final rules = encoded['rules']! as List<dynamic>;
    final firstRule = rules.first as Map<String, dynamic>;

    expect(firstRule['type'], DirectNavigationRule.type);
    expect(
      (firstRule['triggerStepIdentifier']! as Map<String, dynamic>)['id'],
      'step-1',
    );
    expect(firstRule['destinationStepIdentifier'], 'step-2');
  });
}
