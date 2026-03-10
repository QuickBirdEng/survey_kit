import 'package:flutter/material.dart' hide Step;
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  testWidgets('SurveyController navigates without explicit BuildContext',
      (WidgetTester tester) async {
    final controller = SurveyController();
    SurveyResult? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SurveyKit(
            task: SurveyFlow(
              id: 'controller-flow',
              steps: [
                Step(
                  id: 'step-1',
                  content: const <Content>[
                    TextContent(text: 'Step 1'),
                  ],
                  buttonText: 'Next',
                ),
                Step(
                  id: 'step-2',
                  content: const <Content>[
                    TextContent(text: 'Step 2'),
                  ],
                  buttonText: 'Next',
                ),
              ],
            ),
            surveyController: controller,
            onResult: (surveyResult) {
              result = surveyResult;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Step 1'), findsOneWidget);

    controller.next();
    await tester.pumpAndSettle();
    expect(find.text('Step 2'), findsOneWidget);

    controller.stepBack();
    await tester.pumpAndSettle();
    expect(find.text('Step 1'), findsOneWidget);

    controller.closeSurvey();
    await tester.pumpAndSettle();
    expect(result, isNotNull);
    expect(result!.finishReason, FinishReason.discarded);
  });

  testWidgets('SurveyController.next provides context to override callback',
      (WidgetTester tester) async {
    BuildContext? callbackContext;
    final controller = SurveyController(
      onNextStep: (context, stepResult, proceed) {
        callbackContext = context;
        proceed();
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SurveyKit(
            task: SurveyFlow(
              id: 'controller-override-flow',
              steps: [
                Step(
                  id: 'step-1',
                  content: const <Content>[
                    TextContent(text: 'Step 1'),
                  ],
                  buttonText: 'Next',
                ),
                Step(
                  id: 'step-2',
                  content: const <Content>[
                    TextContent(text: 'Step 2'),
                  ],
                  buttonText: 'Next',
                ),
              ],
            ),
            surveyController: controller,
            onResult: (_) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    controller.next();
    await tester.pumpAndSettle();

    expect(callbackContext, isNotNull);
    expect(find.text('Step 2'), findsOneWidget);
  });
}
