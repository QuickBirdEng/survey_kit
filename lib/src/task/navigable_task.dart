import 'package:flutter/widgets.dart';
import 'package:surveykit/src/navigator/rules/navigation_rule.dart';
import 'package:surveykit/src/steps/step.dart';
import 'package:surveykit/src/steps/identifier/step_identifier.dart';
import 'package:surveykit/src/task/task.dart';
import 'package:surveykit/src/task/identifier/task_identifier.dart';

class NavigableTask extends Task {
  Map<StepIdentifier, NavigationRule> navigationRules = {};

  NavigableTask({
    TaskIdentifier id,
    List<Step> steps,
  }) : super(id: id, steps: steps);

  void addNavigationRule(
      {@required StepIdentifier forTriggerStepIdentifier,
      @required NavigationRule navigationRule}) {
    navigationRules.putIfAbsent(forTriggerStepIdentifier, () => navigationRule);
  }

  NavigationRule getRuleByStepIdentifier(StepIdentifier stepIdentifier) {
    return navigationRules[stepIdentifier];
  }
}
