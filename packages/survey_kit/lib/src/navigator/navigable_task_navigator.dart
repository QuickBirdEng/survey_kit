import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/rules/conditional_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/direct_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/navigation_target.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/task/survey_definition.dart';
import 'package:survey_kit/src/task/survey_flow.dart';

class NavigableTaskNavigator extends TaskNavigator {
  NavigableTaskNavigator(SurveyDefinition task) : super(task);

  @override
  Step? nextStep({
    required Step step,
    required List<StepResult> previousResults,
    StepResult? questionResult,
  }) {
    record(step);
    final flowTask = task as SurveyFlow;
    final rule = flowTask.getRuleByStepIdentifier(step.id);
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
    final target =
        rule.resultToStepIdentifierMapper(previousResults, questionResult);
    return switch (target) {
      NavigateToStep(:final stepId) =>
        task.steps.firstWhere((e) => e.id == stepId),
      NavigateToNextInList() => nextInList(step),
      FinishSurvey() => null,
    };
  }

  @override
  Step? firstStep() {
    final previousStep = peekHistory();
    if (previousStep == null) {
      if (task.initialStep != null) {
        return task.initialStep;
      }
      if (task.steps.isEmpty) {
        return null;
      }
      return task.steps.first;
    }
    return nextStep(
      step: previousStep,
      previousResults: [],
      questionResult: null,
    );
  }
}
