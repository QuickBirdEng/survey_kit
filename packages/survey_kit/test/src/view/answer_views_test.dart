import 'package:flutter/cupertino.dart' show CupertinoDatePicker;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/model/answer/multi_double.dart';
import 'package:survey_kit/src/model/result/time_result.dart';
import 'package:survey_kit/src/view/widget/answer/boolean_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/multiple_choice_auto_complete_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/multiple_double_answer_view.dart';
import 'package:survey_kit/survey_kit.dart';

typedef _AnswerViewBuilder = Widget Function(Step step, StepResult? result);

class _AnswerHarness extends StatefulWidget {
  const _AnswerHarness({
    super.key,
    required this.step,
    required this.builder,
    this.initialResult,
  });

  final Step step;
  final StepResult? initialResult;
  final _AnswerViewBuilder builder;

  @override
  State<_AnswerHarness> createState() => _AnswerHarnessState();
}

class _AnswerHarnessState extends State<_AnswerHarness> {
  bool isValid = false;
  late StepResult? stepResult = widget.initialResult;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: QuestionAnswer(
            step: widget.step,
            isValid: isValid,
            stepResult: stepResult,
            onValidityChanged: (value) => setState(() => isValid = value),
            onResultChanged: (result) => setState(
              () => stepResult = StepResult(
                id: widget.step.id,
                step: widget.step,
                result: result,
                startTime: DateTime(2026),
                endTime: DateTime(2026),
              ),
            ),
            child: widget.builder(widget.step, widget.initialResult),
          ),
        ),
      ),
    );
  }
}

Future<_AnswerHarnessState> _pumpAnswerView(
  WidgetTester tester, {
  required Step step,
  required _AnswerViewBuilder builder,
  Object? initialAnswer,
}) async {
  final key = GlobalKey<_AnswerHarnessState>();
  await tester.pumpWidget(
    _AnswerHarness(
      key: key,
      step: step,
      builder: builder,
      initialResult: initialAnswer == null
          ? null
          : StepResult(
              id: step.id,
              step: step,
              result: initialAnswer,
              startTime: DateTime(2026),
              endTime: DateTime(2026),
            ),
    ),
  );
  await tester.pump();
  return key.currentState!;
}

Future<SurveyResult?> _pumpSurvey(
  WidgetTester tester,
  Step step,
  Future<void> Function() interact,
) async {
  SurveyResult? surveyResult;
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SurveyKit(
          task: SurveyFlow(id: 'survey', steps: [step]),
          onResult: (result) => surveyResult = result,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await interact();
  await tester.pumpAndSettle();
  final nextButton = find.widgetWithText(ElevatedButton, 'Next');
  await tester.ensureVisible(nextButton);
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  return surveyResult;
}

bool _isNextEnabled(WidgetTester tester) {
  return tester
          .widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'Next'))
          .onPressed !=
      null;
}

void main() {
  group('DoubleAnswerView', () {
    testWidgets('accepts input on a mandatory step without crashing', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: const DoubleAnswerFormat(),
      );

      final result = await _pumpSurvey(tester, step, () async {
        await tester.enterText(find.byType(TextField), '3');
        await tester.pump();
        expect(tester.takeException(), isNull);
        expect(_isNextEnabled(tester), isTrue);
        await tester.enterText(find.byType(TextField), '1,5');
      });

      expect(tester.takeException(), isNull);
      expect(result?.results.single.result, 1.5);
    });
  });

  group('MultipleChoiceAutoCompleteAnswerView', () {
    final first = TextChoice(id: 'a', text: 'Apple');
    final second = TextChoice(id: 'b', text: 'Banana');

    testWidgets('first tap without default selection selects the choice', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: MultipleChoiceAutoCompleteAnswerFormat(
          choices: [first, second],
        ),
      );

      final result = await _pumpSurvey(tester, step, () async {
        expect(_isNextEnabled(tester), isFalse);
        await tester.tap(find.text('Apple'));
        await tester.pump();
        expect(tester.takeException(), isNull);
        expect(_isNextEnabled(tester), isTrue);
      });

      expect(result?.results.single.result, [first]);
    });

    testWidgets('other text is reported as a single choice', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: MultipleChoiceAutoCompleteAnswerFormat(
          choices: [first],
          otherField: true,
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) => MultipleChoiceAutoCompleteAnswerView(
          questionStep: step,
          result: result,
        ),
      );
      expect(harness.isValid, isFalse);

      final otherField = find.byType(TextFormField);
      await tester.enterText(otherField, 'k');
      await tester.enterText(otherField, 'ki');
      await tester.enterText(otherField, 'kiwi');
      await tester.pump();

      expect(harness.isValid, isTrue);
      final choices = harness.stepResult!.result as List<TextChoice>;
      expect(choices.map((choice) => choice.text), ['kiwi']);
    });
  });

  group('MultipleChoiceAnswerView', () {
    testWidgets('typing into the other field keeps a single entry', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: MultipleChoiceAnswerFormat(
          choices: [TextChoice(id: 'a', text: 'Apple')],
          otherField: true,
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            MultipleChoiceAnswerView(questionStep: step, result: result),
      );

      final otherField = find.byType(TextFormField);
      await tester.enterText(otherField, 'a');
      await tester.enterText(otherField, 'ab');
      await tester.enterText(otherField, 'abc');
      await tester.pump();

      var choices = harness.stepResult!.result as List<TextChoice>;
      expect(choices.map((choice) => choice.text), ['abc']);
      expect(harness.isValid, isTrue);

      await tester.enterText(otherField, '');
      await tester.pump();

      choices = harness.stepResult!.result as List<TextChoice>;
      expect(choices, isEmpty);
      expect(harness.isValid, isFalse);
    });

    testWidgets('restored answer is valid immediately', (tester) async {
      final choice = TextChoice(id: 'a', text: 'Apple');
      final step = Step(
        content: const [],
        answerFormat: MultipleChoiceAnswerFormat(choices: [choice]),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: [choice],
        builder: (step, result) =>
            MultipleChoiceAnswerView(questionStep: step, result: result),
      );

      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, [choice]);
    });
  });

  group('SingleChoiceAnswerView', () {
    testWidgets('deselecting the choice clears the result', (tester) async {
      final choice = TextChoice(id: 'a', text: 'Apple');
      final step = Step(
        content: const [],
        answerFormat: SingleChoiceAnswerFormat(
          choices: [
            choice,
            TextChoice(id: 'b', text: 'Banana'),
          ],
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            SingleChoiceAnswerView(questionStep: step, result: result),
      );

      await tester.tap(find.text('Apple'));
      await tester.pump();
      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, choice);

      await tester.tap(find.text('Apple'));
      await tester.pump();
      expect(harness.isValid, isFalse);
      expect(harness.stepResult!.result, isNull);
    });

    testWidgets('restored answer stays selected and valid', (tester) async {
      final choice = TextChoice(id: 'a', text: 'Apple');
      final step = Step(
        content: const [],
        answerFormat: SingleChoiceAnswerFormat(choices: [choice]),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: choice,
        builder: (step, result) =>
            SingleChoiceAnswerView(questionStep: step, result: result),
      );

      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, choice);
    });
  });

  group('TimeAnswerView', () {
    testWidgets('restored answer is valid immediately', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: const TimeAnswerFormat(),
      );
      const time = TimeResult(timeOfDay: TimeOfDay(hour: 8, minute: 30));
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: time,
        builder: (step, result) =>
            TimeAnswerView(questionStep: step, result: result),
      );

      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, time);
    });
  });

  group('DateAnswerView', () {
    testWidgets('clamps the initial date into the allowed range', (
      tester,
    ) async {
      final minDate = DateTime.now().add(const Duration(days: 10));
      final step = Step(
        content: const [],
        answerFormat: DateAnswerFormat(
          minDate: minDate,
          maxDate: minDate.add(const Duration(days: 30)),
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            DateAnswerView(questionStep: step, result: result),
      );

      expect(tester.takeException(), isNull);
      expect(harness.isValid, isFalse);
      expect(harness.stepResult?.result, isNull);
    });

    testWidgets('renders a future minDate without maxDate', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: DateAnswerFormat(
          minDate: DateTime.now().add(const Duration(days: 10)),
        ),
      );
      await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            DateAnswerView(questionStep: step, result: result),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(CalendarDatePicker), findsOneWidget);
    });
  });

  group('BooleanAnswerView', () {
    testWidgets('default value of none is not a valid mandatory answer', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: const BooleanAnswerFormat(
          positiveAnswer: 'Yes',
          negativeAnswer: 'No',
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            BooleanAnswerView(questionStep: step, result: result),
      );

      expect(harness.isValid, isFalse);

      await tester.tap(find.text('Yes'));
      await tester.pump();
      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, BooleanResult.positive);
    });

    testWidgets('restored answer is valid immediately', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: const BooleanAnswerFormat(
          positiveAnswer: 'Yes',
          negativeAnswer: 'No',
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: BooleanResult.negative,
        builder: (step, result) =>
            BooleanAnswerView(questionStep: step, result: result),
      );

      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, BooleanResult.negative);
    });
  });

  group('TextAnswerView', () {
    testWidgets('empty text is invalid on a mandatory step without regex', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: const TextAnswerFormat(validationRegEx: null),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            TextAnswerView(questionStep: step, result: result),
      );

      expect(harness.isValid, isFalse);

      await tester.enterText(find.byType(TextField), 'hello');
      await tester.pump();
      expect(harness.isValid, isTrue);

      await tester.enterText(find.byType(TextField), '   ');
      await tester.pump();
      expect(harness.isValid, isFalse);
    });

    testWidgets('restored answer is shown and valid immediately', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: const TextAnswerFormat(),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: 'previous',
        builder: (step, result) =>
            TextAnswerView(questionStep: step, result: result),
      );

      expect(find.text('previous'), findsOneWidget);
      expect(harness.isValid, isTrue);
    });
  });

  group('IntegerAnswerView', () {
    testWidgets('restored answer is valid immediately', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: const IntegerAnswerFormat(),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: 42,
        builder: (step, result) =>
            IntegerAnswerView(questionStep: step, result: result),
      );

      expect(find.text('42'), findsOneWidget);
      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, 42);
    });

    testWidgets('default value is reported as the initial result', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: const IntegerAnswerFormat(defaultValue: 7),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            IntegerAnswerView(questionStep: step, result: result),
      );

      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, 7);
    });

    testWidgets('clearing the field drops the stale result', (tester) async {
      final step = Step(
        content: const [],
        isMandatory: false,
        answerFormat: const IntegerAnswerFormat(),
      );

      final result = await _pumpSurvey(tester, step, () async {
        await tester.enterText(find.byType(TextField), '42');
        await tester.pump();
        await tester.enterText(find.byType(TextField), '');
      });

      expect(result?.results.single.result, isNull);
    });
  });

  group('ScaleAnswerView', () {
    testWidgets('default value is reported as the initial result', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: const ScaleAnswerFormat(
          maximumValue: 10,
          minimumValue: 0,
          defaultValue: 4,
          step: 1,
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            ScaleAnswerView(questionStep: step, result: result),
      );

      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, 4);
    });

    testWidgets('restores an integer result without crashing', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: const ScaleAnswerFormat(
          maximumValue: 10,
          minimumValue: 0,
          defaultValue: 4,
          step: 1,
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: 7,
        builder: (step, result) =>
            ScaleAnswerView(questionStep: step, result: result),
      );

      expect(tester.takeException(), isNull);
      expect(harness.stepResult!.result, 7.0);
    });
  });

  group('MultipleDoubleAnswerView', () {
    testWidgets('is only valid when every field holds a number', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: const MultipleDoubleAnswerFormat(
          hints: ['Height', 'Weight'],
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            MultipleDoubleAnswerView(questionStep: step, result: result),
      );
      final fields = find.byType(TextField);

      expect(harness.isValid, isFalse);

      await tester.enterText(fields.at(0), 'abc');
      await tester.enterText(fields.at(1), '70');
      await tester.pump();
      expect(harness.isValid, isFalse);
      expect(harness.stepResult!.result, isNull);

      await tester.enterText(fields.at(0), '1,8');
      await tester.pump();
      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, const [
        MultiDouble(text: 'Height', value: 1.8),
        MultiDouble(text: 'Weight', value: 70),
      ]);
    });

    testWidgets('restored answer fills the fields', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: const MultipleDoubleAnswerFormat(
          hints: ['Height', 'Weight'],
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: const [
          MultiDouble(text: 'Height', value: 1.8),
          MultiDouble(text: 'Weight', value: 70),
        ],
        builder: (step, result) =>
            MultipleDoubleAnswerView(questionStep: step, result: result),
      );

      expect(find.text('1.8'), findsOneWidget);
      expect(find.text('70.0'), findsOneWidget);
      expect(harness.isValid, isTrue);
    });
  });

  group('iOS pickers', () {
    final ios = TargetPlatformVariant.only(TargetPlatform.iOS);

    CupertinoDatePicker datePicker(WidgetTester tester) =>
        tester.widget<CupertinoDatePicker>(find.byType(CupertinoDatePicker));

    void expectCupertinoDatePicker() {
      expect(defaultTargetPlatform, TargetPlatform.iOS);
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
      expect(find.byType(CalendarDatePicker), findsNothing);
    }

    testWidgets('date picker shows the question text', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: DateAnswerFormat(question: 'When were you born?'),
      );
      await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            DateAnswerView(questionStep: step, result: result),
      );

      expectCupertinoDatePicker();
      expect(find.text('When were you born?'), findsOneWidget);
    }, variant: ios);

    testWidgets('date picker restores the previous answer', (tester) async {
      final restored = DateTime(2020, 5, 17);
      final step = Step(content: const [], answerFormat: DateAnswerFormat());
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: restored,
        builder: (step, result) =>
            DateAnswerView(questionStep: step, result: result),
      );

      expectCupertinoDatePicker();
      expect(datePicker(tester).initialDateTime, restored);
      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, restored);
    }, variant: ios);

    testWidgets('date picker clamps a restored answer into the range', (
      tester,
    ) async {
      final minDate = DateTime(2020);
      final step = Step(
        content: const [],
        answerFormat: DateAnswerFormat(
          minDate: minDate,
          maxDate: DateTime(2025),
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: DateTime(2000),
        builder: (step, result) =>
            DateAnswerView(questionStep: step, result: result),
      );

      expect(tester.takeException(), isNull);
      expectCupertinoDatePicker();
      expect(datePicker(tester).initialDateTime, minDate);
      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, minDate);
    }, variant: ios);

    testWidgets('date picker clamps the fallback date into the range', (
      tester,
    ) async {
      final now = DateTime.now();
      final minDate = DateTime(now.year, now.month, now.day + 10);
      final step = Step(
        content: const [],
        answerFormat: DateAnswerFormat(
          minDate: minDate,
          maxDate: minDate.add(const Duration(days: 30)),
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            DateAnswerView(questionStep: step, result: result),
      );

      expect(tester.takeException(), isNull);
      expectCupertinoDatePicker();
      expect(datePicker(tester).initialDateTime, minDate);
      expect(harness.isValid, isFalse);
      expect(harness.stepResult?.result, isNull);
    }, variant: ios);

    testWidgets('date picker clamps the fallback date to maxDate', (
      tester,
    ) async {
      final maxDate = DateTime(2010);
      final step = Step(
        content: const [],
        answerFormat: DateAnswerFormat(
          minDate: DateTime(2000),
          maxDate: maxDate,
        ),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            DateAnswerView(questionStep: step, result: result),
      );

      expect(tester.takeException(), isNull);
      expectCupertinoDatePicker();
      expect(datePicker(tester).initialDateTime, maxDate);
      expect(harness.isValid, isFalse);
      expect(harness.stepResult?.result, isNull);
    }, variant: ios);

    testWidgets('time picker without a default is not yet an answer', (
      tester,
    ) async {
      final step = Step(
        content: const [],
        answerFormat: const TimeAnswerFormat(),
      );
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            TimeAnswerView(questionStep: step, result: result),
      );

      expect(harness.isValid, isFalse);
      expect(harness.stepResult?.result, isNull);
    }, variant: ios);

    testWidgets('time picker restores the previous answer', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: const TimeAnswerFormat(
          defaultValue: TimeOfDay(hour: 6, minute: 0),
        ),
      );
      const time = TimeResult(timeOfDay: TimeOfDay(hour: 8, minute: 30));
      final harness = await _pumpAnswerView(
        tester,
        step: step,
        initialAnswer: time,
        builder: (step, result) =>
            TimeAnswerView(questionStep: step, result: result),
      );

      final initial = datePicker(tester).initialDateTime;
      expect(initial.hour, 8);
      expect(initial.minute, 30);
      expect(harness.isValid, isTrue);
      expect(harness.stepResult!.result, time);
    }, variant: ios);

    testWidgets('time picker starts at the default value', (tester) async {
      final step = Step(
        content: const [],
        answerFormat: const TimeAnswerFormat(
          defaultValue: TimeOfDay(hour: 6, minute: 45),
          question: 'When do you wake up?',
        ),
      );
      await _pumpAnswerView(
        tester,
        step: step,
        builder: (step, result) =>
            TimeAnswerView(questionStep: step, result: result),
      );

      final initial = datePicker(tester).initialDateTime;
      expect(initial.hour, 6);
      expect(initial.minute, 45);
      expect(find.text('When do you wake up?'), findsOneWidget);
    }, variant: ios);
  });
}
