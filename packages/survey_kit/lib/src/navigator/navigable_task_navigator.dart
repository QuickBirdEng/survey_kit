import 'package:collection/collection.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/rules/conditional_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/direct_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/navigation_target.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/task/survey_definition.dart';
import 'package:survey_kit/src/task/survey_flow.dart';

/// A [TaskNavigator] that resolves the next step by evaluating
/// [NavigationRule]s defined in a [SurveyFlow]. Supports
/// [DirectNavigationRule], [ConditionalNavigationRule] and any custom rule
/// overriding [NavigationRule.resolve]. Falls back to sequential order when no
/// rule is defined for the current step.
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
    return _stepForTarget(step, rule.resolve(previousResults, questionResult));
  }

  @override
  Step? previousInList(Step? step) {
    if (history.isEmpty) {
      return null;
    }
    return history.removeLast();
  }

  /// Evaluates a [ConditionalNavigationRule] for [step] and returns the
  /// resolved next step. Returns null when the rule produces a [FinishSurvey]
  /// target.
  Step? evaluateNextStep(
    Step? step,
    ConditionalNavigationRule rule,
    List<StepResult> previousResults,
    StepResult? questionResult,
  ) => _stepForTarget(step, rule.resolve(previousResults, questionResult));

  Step? _stepForTarget(Step? step, NavigationTarget target) {
    return switch (target) {
      NavigateToStep(:final stepId) => _stepById(step, stepId),
      NavigateToNextInList() => nextInList(step),
      FinishSurvey() => null,
    };
  }

  Step _stepById(Step? from, String stepId) {
    final target = task.steps.firstWhereOrNull((e) => e.id == stepId);
    if (target == null) {
      throw StateError(
        'Navigation rule for step "${from?.id}" targets step "$stepId", '
        'which does not exist in survey "${task.id}".',
      );
    }
    return target;
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
