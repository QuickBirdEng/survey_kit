import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/task/task.dart';
import 'package:survey_kit/src/task/identifier/task_identifier.dart';

class NavigableTask extends Task {
  Map<StepIdentifier, NavigationRule> navigationRules = {};

  NavigableTask({
    TaskIdentifier? id,
    List<Step> steps = const [],
  }) : super(id: id, steps: steps);

  void addNavigationRule(
      {required StepIdentifier forTriggerStepIdentifier,
      required NavigationRule navigationRule}) {
    navigationRules.putIfAbsent(forTriggerStepIdentifier, () => navigationRule);
  }

  NavigationRule? getRuleByStepIdentifier(StepIdentifier? stepIdentifier) {
    return navigationRules[stepIdentifier];
  }
}
