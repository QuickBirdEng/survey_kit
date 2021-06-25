import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/task/task.dart';
import 'package:survey_kit/src/task/identifier/task_identifier.dart';

class NavigableTask extends Task {
  final Map<StepIdentifier, NavigationRule> navigationRules;

  NavigableTask({
    TaskIdentifier? id,
    List<Step> steps = const [],
    Map<StepIdentifier, NavigationRule>? navigationRules,
  })  : this.navigationRules = navigationRules ?? {},
        super(id: id, steps: steps);

  void addNavigationRule(
      {required StepIdentifier forTriggerStepIdentifier,
      required NavigationRule navigationRule}) {
    navigationRules.putIfAbsent(forTriggerStepIdentifier, () => navigationRule);
  }

  NavigationRule? getRuleByStepIdentifier(StepIdentifier? stepIdentifier) {
    return navigationRules[stepIdentifier];
  }

  factory NavigableTask.fromJson(Map<String, dynamic> json) {
    final Map<StepIdentifier, NavigationRule> navigationRules = {};
    final rules = json['rules'] as List;
    rules.forEach((rule) {
      navigationRules.putIfAbsent(
          StepIdentifier.fromJson(rule['triggerStepIdentifier']),
          () => NavigationRule.fromJson(rule as Map<String, dynamic>));
    });

    return NavigableTask(
      id: TaskIdentifier.fromJson(json),
      steps: (json['steps'] as List)
          .map((step) => Step.fromJson(step as Map<String, dynamic>))
          .toList(),
      navigationRules: navigationRules,
    );
  }
}
