import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/answer_format/boolean_answer_format.dart';
import 'package:survey_kit/src/navigator/navigable_task_navigator.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/steps/predefined_steps/completion_step.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/task/navigable_task.dart';
import 'package:survey_kit/src/task/task.dart';

void main() {
  test('''Navigable task navigator completes
      after first occurence of completion step''', () {
    final Task task = NavigableTask(
      steps: [
        QuestionStep(
            answerFormat: BooleanAnswerFormat(
                positiveAnswer: 'Yes', negativeAnswer: 'No')),
        CompletionStep(
            stepIdentifier: StepIdentifier(id: '111'), title: '', text: ''),
        CompletionStep(
            stepIdentifier: StepIdentifier(id: '222'), title: '', text: ''),
      ],
    );
    final NavigableTaskNavigator navigator = NavigableTaskNavigator(task);
    final step0 = navigator.firstStep();
    expect(step0, isNotNull);
    expect(step0, isA<QuestionStep>());

    final completionStep0 = navigator.nextStep(step: step0!);
    expect(completionStep0, isNotNull);
    expect(completionStep0, isA<CompletionStep>());

    final completionStep1 = navigator.nextStep(step: completionStep0!);
    expect(completionStep1, isNull);
  });
}
