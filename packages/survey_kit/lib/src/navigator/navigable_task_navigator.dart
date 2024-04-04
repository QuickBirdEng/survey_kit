import '../model/result/step_result.dart';
import '../model/step.dart';
import '../task/navigable_task.dart';
import '../task/task.dart';
import 'rules/conditional_navigation_rule.dart';
import 'rules/direct_navigation_rule.dart';
import 'task_navigator.dart';

class NavigableTaskNavigator extends TaskNavigator {
  NavigableTaskNavigator(Task task) : super(task);

  @override
  Step? nextStep({
    required Step step,
    required List<StepResult> previousResults,
    StepResult? questionResult,
  }) {
    record(step);
    final navigableTask = task as NavigableTask;
    final rule = navigableTask.getRuleByStepIdentifier(step.id);
    if (rule == null) {
      return nextInList(step);
    }
    switch (rule.runtimeType) {
      case DirectNavigationRule:
        return task.steps.firstWhere(
          (element) =>
              element.id ==
              (rule as DirectNavigationRule).destinationStepIdentifier,
        );
      case ConditionalNavigationRule:
        return evaluateNextStep(
          step,
          rule as ConditionalNavigationRule,
          previousResults,
          questionResult,
        );
    }
    return nextInList(step);
  }

  @override
  Step? previousInList(Step? step) {
    if (history.isEmpty) {
      return null;
    }
    return history.removeLast();
  }

  Step? evaluateNextStep(
    Step? step,
    ConditionalNavigationRule rule,
    List<StepResult> previousResults,
    StepResult? questionResult,
  ) {
    final nextStepIdentifier =
        rule.resultToStepIdentifierMapper(previousResults, questionResult);
    if (nextStepIdentifier == null) {
      return nextInList(step);
    }
    return task.steps.firstWhere((element) => element.id == nextStepIdentifier);
  }

  @override
  Step? firstStep() {
    final previousStep = peekHistory();
    return previousStep == null
        ? task.initalStep ?? task.steps.first
        : nextStep(
            step: previousStep,
            previousResults: [],
            questionResult: null,
          );
  }
}
