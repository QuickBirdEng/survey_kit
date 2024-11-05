import 'dart:collection';

import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/completion_step.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/task/task.dart';

abstract class TaskNavigator {
  final Task task;
  final ListQueue<Step> history = ListQueue();

  TaskNavigator(this.task);

  Step? firstStep();
  Step? nextStep({required Step step, QuestionResult? questionResult});
  Step? previousInList(Step step);

  Step? nextInList(Step? step) {
    final currentIndex = task.steps.indexWhere(
        (element) => element.stepIdentifier == step?.stepIdentifier);
    // end survey if already completed via CompletionStep
    if (step is CompletionStep) {
      return null;
    }
    return (currentIndex + 1 > task.steps.length - 1)
        ? null
        : task.steps[currentIndex + 1];
  }

  Step? peekHistory() {
    if (history.isEmpty) {
      return null;
    }
    return history.last;
  }

  bool hasPreviousStep() {
    final step = peekHistory();
    return step != null;
  }

  void record(Step step) {
    history.add(step);
  }

  // Discard count of multiple completion steps and count only one if present
  int get countSteps =>
      task.steps.where((step) => !(step is CompletionStep)).length +
      (task.steps.where((step) => step is CompletionStep).isEmpty ? 0 : 1);

  int currentStepIndex(Step step) {
    return task.steps.indexOf(step);
  }
}
