import 'package:flutter/widgets.dart';
import 'package:surveykit/src/navigator/rules/conditional_navigation_rule.dart';
import 'package:surveykit/src/navigator/rules/direct_navigation_rule.dart';
import 'package:surveykit/src/navigator/rules/navigation_rule.dart';
import 'package:surveykit/src/navigator/task_navigator.dart';
import 'package:surveykit/src/result/question_result.dart';
import 'package:surveykit/src/steps/step.dart';
import 'package:surveykit/src/task/navigable_task.dart';
import 'package:surveykit/src/task/task.dart';

class NavigableTaskNavigator extends TaskNavigator {
  NavigableTaskNavigator(Task task) : super(task);

  @override
  Step nextStep({@required Step step, QuestionResult questionResult}) {
    record(step);
    final navigableTask = task as NavigableTask;
    NavigationRule rule = navigableTask.getRuleByStepIdentifier(step.id);
    if (rule == null) {
      return nextInList(step);
    }
    switch (rule.runtimeType) {
      case DirectNavigationRule:
        return task.steps.firstWhere((element) =>
            element.id ==
            (rule as DirectNavigationRule).destinationStepIdentifier);
        break;
      case ConditionalNavigationRule:
        return evaluateNextStep(step, rule, questionResult);
        break;
    }
    return nextInList(step);
  }

  @override
  Step previousInList(Step step) {
    if (history.isEmpty) {
      return null;
    }
    return history.removeLast();
  }

  Step evaluateNextStep(Step step, ConditionalNavigationRule rule,
      QuestionResult questionResult) {
    if (questionResult == null) {
      return nextInList(step);
    }
    final result = questionResult.result;
    if (result == null) {
      return nextInList(step);
    }
    final nextStepIdentifier =
        rule.resultToStepIdentifierMapper(questionResult.valueIdentifier);
    if (nextStepIdentifier == null) {
      return nextInList(step);
    }
    return task.steps.firstWhere((element) => element.id == nextStepIdentifier);
  }

  @override
  Step firstStep() {
    final previousStep = peekHistory();
    return previousStep == null
        ? task.steps.first
        : nextStep(step: previousStep, questionResult: null);
  }
}
