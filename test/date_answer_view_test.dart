import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/answer_format/date_answer_format.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/date_answer_view.dart';

void main() {
  testWidgets('DateAnswerView with default date in min and maxrange',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DateAnswerView(
          questionStep: QuestionStep(
            answerFormat: DateAnswerFormat(
              minDate: DateTime.now().subtract(const Duration(days: 365 * 70)),
              maxDate: DateTime.now().subtract(const Duration(days: 365 * 15)),
              defaultDate:
                  DateTime.now().subtract(const Duration(days: 365 * 20)),
            ),
          ),
        ),
      ),
    );
    expect(find.byType(CupertinoDatePicker), findsOneWidget);
  });
}
