import 'package:flutter/material.dart' hide Step;
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

StepResult _result(String id, Object value) => StepResult<Object>(
  id: id,
  step: Step(id: id, content: const []),
  result: value,
  startTime: DateTime.utc(2020),
  endTime: DateTime.utc(2020),
);

Step _step(String id) => Step(
  id: id,
  content: [TextContent(text: id)],
);

void main() {
  testWidgets('results of an abandoned branch are dropped on finish', (
    tester,
  ) async {
    final controller = SurveyController();
    SurveyResult? surveyResult;

    await tester.pumpWidget(
      MaterialApp(
        home: SurveyKit(
          surveyController: controller,
          task: SurveyFlow(
            id: 'branching',
            steps: [_step('q'), _step('a'), _step('b')],
            navigationRules: {
              'q': ConditionalNavigationRule(
                resultToStepIdentifierMapper: (_, result) =>
                    NavigateToStep(result?.result == 'A' ? 'a' : 'b'),
              ),
              'a': ConditionalNavigationRule(
                resultToStepIdentifierMapper: (_, _) => const FinishSurvey(),
              ),
            },
          ),
          onResult: (result) => surveyResult = result,
        ),
      ),
    );
    await tester.pumpAndSettle();

    controller.next(stepResult: _result('q', 'A'));
    await tester.pumpAndSettle();
    expect(find.text('a'), findsOneWidget);

    controller.stepBack(stepResult: _result('a', 'answer-a'));
    await tester.pumpAndSettle();
    expect(find.text('q'), findsOneWidget);

    controller.next(stepResult: _result('q', 'B'));
    await tester.pumpAndSettle();
    expect(find.text('b'), findsOneWidget);

    controller.next(stepResult: _result('b', 'answer-b'));
    await tester.pumpAndSettle();

    expect(surveyResult!.results.map((r) => r.id), ['q', 'b']);
    expect(surveyResult!.results.first.result, 'B');
  });

  testWidgets('results are ordered by visit order', (tester) async {
    final controller = SurveyController();
    SurveyResult? surveyResult;

    await tester.pumpWidget(
      MaterialApp(
        home: SurveyKit(
          surveyController: controller,
          task: SurveyFlow(
            id: 'jumping',
            steps: [_step('a'), _step('b'), _step('c')],
            navigationRules: {
              'a': DirectNavigationRule('c'),
              'c': DirectNavigationRule('b'),
              'b': ConditionalNavigationRule(
                resultToStepIdentifierMapper: (_, _) => const FinishSurvey(),
              ),
            },
          ),
          onResult: (result) => surveyResult = result,
        ),
      ),
    );
    await tester.pumpAndSettle();

    controller.next(stepResult: _result('a', 1));
    await tester.pumpAndSettle();
    controller.next(stepResult: _result('c', 3));
    await tester.pumpAndSettle();
    controller.next(stepResult: _result('b', 2));
    await tester.pumpAndSettle();

    expect(surveyResult!.results.map((r) => r.id), ['a', 'c', 'b']);
  });

  testWidgets('going back in a linear survey keeps later answers', (
    tester,
  ) async {
    final controller = SurveyController();
    SurveyResult? surveyResult;

    await tester.pumpWidget(
      MaterialApp(
        home: SurveyKit(
          surveyController: controller,
          task: SurveyFlow(
            id: 'linear',
            steps: [_step('a'), _step('b'), _step('c')],
          ),
          onResult: (result) => surveyResult = result,
        ),
      ),
    );
    await tester.pumpAndSettle();

    controller.next(stepResult: _result('a', 1));
    await tester.pumpAndSettle();
    controller.next(stepResult: _result('b', 2));
    await tester.pumpAndSettle();
    controller.stepBack(stepResult: _result('c', 3));
    await tester.pumpAndSettle();
    expect(find.text('b'), findsOneWidget);
    controller.closeSurvey(stepResult: _result('b', 2));
    await tester.pumpAndSettle();

    expect(surveyResult!.results.map((r) => r.id), ['a', 'b', 'c']);
  });

  testWidgets('returning along the same path keeps later answers', (
    tester,
  ) async {
    final controller = SurveyController();
    SurveyResult? surveyResult;

    await tester.pumpWidget(
      MaterialApp(
        home: SurveyKit(
          surveyController: controller,
          task: SurveyFlow(
            id: 'revisit',
            steps: [_step('a'), _step('b'), _step('c')],
          ),
          onResult: (result) => surveyResult = result,
        ),
      ),
    );
    await tester.pumpAndSettle();

    controller.next(stepResult: _result('a', 1));
    await tester.pumpAndSettle();
    controller.next(stepResult: _result('b', 2));
    await tester.pumpAndSettle();
    controller.stepBack(stepResult: _result('c', 3));
    await tester.pumpAndSettle();
    controller.next(stepResult: _result('b', 2));
    await tester.pumpAndSettle();
    expect(find.text('c'), findsOneWidget);
    controller.next();
    await tester.pumpAndSettle();

    expect(surveyResult!.results.map((r) => r.id), ['a', 'b', 'c']);
    expect(surveyResult!.results.last.result, 3);
  });

  testWidgets('a new task with the same steps applies its navigation rules', (
    tester,
  ) async {
    final controller = SurveyController();
    var target = 'b';
    late StateSetter rebuildParent;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            rebuildParent = setState;
            return SurveyKit(
              surveyController: controller,
              task: SurveyFlow(
                id: 'rules-$target',
                steps: [_step('a'), _step('b'), _step('c')],
                navigationRules: {'a': DirectNavigationRule(target)},
              ),
              onResult: (_) {},
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    rebuildParent(() => target = 'c');
    await tester.pumpAndSettle();
    controller.next(stepResult: _result('a', 1));
    await tester.pumpAndSettle();
    expect(find.text('c'), findsOneWidget);

    controller.stepBack();
    await tester.pumpAndSettle();
    expect(find.text('a'), findsOneWidget);
  });

  testWidgets('closing keeps the result of the current step', (tester) async {
    final controller = SurveyController();
    SurveyResult? surveyResult;

    await tester.pumpWidget(
      MaterialApp(
        home: SurveyKit(
          surveyController: controller,
          task: SurveyFlow(id: 'closing', steps: [_step('a'), _step('b')]),
          onResult: (result) => surveyResult = result,
        ),
      ),
    );
    await tester.pumpAndSettle();

    controller.next(stepResult: _result('a', 1));
    await tester.pumpAndSettle();
    controller.closeSurvey(stepResult: _result('b', 2));
    await tester.pumpAndSettle();

    expect(surveyResult!.finishReason, FinishReason.discarded);
    expect(surveyResult!.results.map((r) => r.id), ['a', 'b']);
  });

  testWidgets('back navigation survives a parent rebuild with a new task', (
    tester,
  ) async {
    final controller = SurveyController();
    late StateSetter rebuildParent;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            rebuildParent = setState;
            return SurveyKit(
              surveyController: controller,
              task: SurveyFlow(
                steps: [_step('s1'), _step('s2')],
                navigationRules: {'s1': DirectNavigationRule('s2')},
              ),
              onResult: (_) {},
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    controller.next();
    await tester.pumpAndSettle();
    expect(find.text('s2'), findsOneWidget);

    rebuildParent(() {});
    await tester.pumpAndSettle();

    controller.stepBack();
    await tester.pumpAndSettle();
    expect(find.text('s1'), findsOneWidget);
  });

  testWidgets('presented states hold immutable result snapshots', (
    tester,
  ) async {
    final controller = SurveyController();
    final states = <SurveyState>[];

    await tester.pumpWidget(
      MaterialApp(
        home: SurveyKit(
          surveyController: controller,
          task: SurveyFlow(id: 'snapshots', steps: [_step('a'), _step('b')]),
          onResult: (_) {},
        ),
      ),
    );
    await tester.pumpAndSettle();
    final surveyContext = tester.element(find.text('a'));
    final subscription = SurveyStateProvider.of(
      surveyContext,
    ).stateStream.listen(states.add);
    addTearDown(subscription.cancel);

    controller.next(stepResult: _result('a', 1));
    await tester.pumpAndSettle();
    controller.stepBack(stepResult: _result('b', 2));
    await tester.pumpAndSettle();

    final first = states.first as PresentingSurveyState;
    expect(first.questionResults.map((r) => r.id), ['a']);
    expect(
      () => first.questionResults.add(_result('x', 0)),
      throwsUnsupportedError,
    );
    expect(
      () => SurveyStateProvider.of(surveyContext).results.clear(),
      throwsUnsupportedError,
    );
  });
}
