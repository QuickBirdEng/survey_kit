import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/answer_format/date_answer_format.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/date_answer_view.dart';

void main() {
  DateAnswerView _validDateAnswerView() => DateAnswerView(
        questionStep: QuestionStep(
          answerFormat: DateAnswerFormat(
            minDate: DateTime.now().subtract(const Duration(days: 365 * 70)),
            maxDate: DateTime.now().subtract(const Duration(days: 365 * 15)),
            defaultDate:
                DateTime.now().subtract(const Duration(days: 365 * 20)),
          ),
        ),
        result: null,
      );

  testWidgets('Detects iOS platform and displays correct widget',
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    await tester.pumpWidget(
      CupertinoApp(
        home: _validDateAnswerView(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CupertinoDatePicker), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Detects Android platform and displays correct widget',
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: _validDateAnswerView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CalendarDatePicker), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Initial date in between first and last date',
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DateAnswerView(
            questionStep: QuestionStep(
              title: 'Your Birthday?',
              answerFormat: DateAnswerFormat(),
            ),
            result: null,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CalendarDatePicker), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });
}
