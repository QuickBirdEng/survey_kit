import 'package:flutter/material.dart' hide Step;
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  testWidgets('empty task completes without pushing loading route',
      (WidgetTester tester) async {
    SurveyResult? callbackResult;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SurveyKit(
            task: SurveyFlow(id: 'empty-task', steps: const []),
            onResult: (result) {
              callbackResult = result;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(callbackResult, isNotNull);
    expect(callbackResult!.finishReason, FinishReason.completed);
    expect(callbackResult!.results, isEmpty);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('final next step finishes without rendering loading route',
      (WidgetTester tester) async {
    SurveyResult? callbackResult;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SurveyKit(
            task: SurveyFlow(
              id: 'single-step',
              steps: [
                Step(
                  content: const [
                    TextContent(text: 'Single step survey'),
                  ],
                  buttonText: 'Finish',
                ),
              ],
            ),
            onResult: (result) {
              callbackResult = result;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Finish'));
    await tester.pumpAndSettle();

    expect(callbackResult, isNotNull);
    expect(callbackResult!.finishReason, FinishReason.completed);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('step back on first step keeps current route',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SurveyKit(
            task: SurveyFlow(
              id: 'step-back-first',
              steps: [
                Step(
                  id: 'first-step',
                  content: const [
                    TextContent(text: 'No previous step exists'),
                  ],
                  buttonText: 'Next',
                ),
              ],
            ),
            onResult: (_) {},
            stepShell: (step, answerWidget, context) {
              return Column(
                children: [
                  Text('step-${step.id}'),
                  TextButton(
                    onPressed: () {
                      SurveyStateProvider.of(context).onEvent(
                        StepBack(null),
                      );
                    },
                    child: const Text('Trigger Back'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('step-'), findsOneWidget);
    await tester.tap(find.text('Trigger Back'));
    await tester.pumpAndSettle();

    expect(find.textContaining('step-'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('initial step does not create an extra navigator route',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SurveyKit(
            task: SurveyFlow(
              id: 'initial-route',
              steps: [
                Step(
                  id: 'initial-step',
                  content: const [
                    TextContent(text: 'Initial step content'),
                  ],
                  buttonText: 'Continue',
                ),
              ],
            ),
            onResult: (_) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Initial step content'), findsOneWidget);

    final nestedNavigator = find
        .byType(Navigator)
        .evaluate()
        .map((element) => element.widget as Navigator)
        .firstWhere(
          (navigator) => navigator.key is GlobalKey<NavigatorState>,
        );

    final navigatorKey = nestedNavigator.key! as GlobalKey<NavigatorState>;
    expect(navigatorKey.currentState?.canPop(), isFalse);
  });

  testWidgets('next-step transition does not render destination twice',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SurveyKit(
            task: SurveyFlow(
              id: 'duplicate-check',
              steps: [
                Step(
                  id: 'first',
                  content: const [
                    TextContent(text: 'First step'),
                  ],
                  buttonText: 'Next',
                ),
                Step(
                  id: 'second',
                  content: const [
                    TextContent(text: 'Second step'),
                  ],
                  buttonText: 'Done',
                ),
              ],
            ),
            onResult: (_) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Next'));
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.text('Second step'), findsOneWidget);
    expect(find.text('First step'), findsOneWidget);
  });
}
