import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  test('ordered task navigator handles empty steps', () {
    final navigator = OrderedTaskNavigator(
      SurveyFlow(
        id: 'ordered-empty',
        steps: const [],
      ),
    );

    expect(navigator.firstStep(), isNull);
  });

  test('navigable task navigator handles empty steps', () {
    final navigator = NavigableTaskNavigator(
      SurveyFlow(
        id: 'navigable-empty',
        steps: const [],
      ),
    );

    expect(navigator.firstStep(), isNull);
  });

  test('navigable task serializes rules with type and trigger step', () {
    final first = Step(
      id: 'step-1',
      content: const [
        TextContent(text: 'start'),
      ],
      buttonText: 'next',
    );
    final second = Step(
      id: 'step-2',
      content: const [
        TextContent(text: 'end'),
      ],
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
