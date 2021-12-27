import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/task/task.dart';
import 'package:survey_kit/src/task/identifier/task_identifier.dart';

/// Definition of task which can handle routing between [Tasks]
///
/// The [navigationRules] defines on which Step [StepIdentifier] which next Step
/// is called. The logic which [Step] is called is defined in the
/// [NavigationRule]
class NavigableTask extends Task {
  final Map<StepIdentifier, NavigationRule> navigationRules;

  NavigableTask({
    TaskIdentifier? id,
    List<Step> steps = const [],
    Step? initialStep,
    Map<StepIdentifier, NavigationRule>? navigationRules,
  })  : this.navigationRules = navigationRules ?? {},
        super(
          id: id,
          steps: steps,
          initalStep: initialStep,
        );

  /// Adds a [NavigationRule] to the [navigationRule] Map
  /// It only adds the [NavigationRule] if none is already set for the
  /// [StepIdentifier]
  void addNavigationRule(
      {required StepIdentifier forTriggerStepIdentifier,
      required NavigationRule navigationRule}) {
    navigationRules.putIfAbsent(forTriggerStepIdentifier, () => navigationRule);
  }

  /// Gets the [NavigationRule] which is defined for the given [StepIndentifier]
  /// Returns null if none is defined
  NavigationRule? getRuleByStepIdentifier(StepIdentifier? stepIdentifier) {
    return navigationRules[stepIdentifier];
  }

  factory NavigableTask.fromJson(Map<String, dynamic> json) {
    final Map<StepIdentifier, NavigationRule> navigationRules = {};

    if (json['rules'] != null) {
      final rules = json['rules'] as List;
      rules.forEach((rule) {
        navigationRules.putIfAbsent(
            StepIdentifier.fromJson(rule['triggerStepIdentifier']),
            () => NavigationRule.fromJson(rule as Map<String, dynamic>));
      });
    }

    return NavigableTask(
      id: TaskIdentifier.fromJson(json),
      steps: json['steps'] != null
          ? (json['steps'] as List)
              .map((step) => Step.fromJson(step as Map<String, dynamic>))
              .toList()
          : [],
      navigationRules: navigationRules,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id.toJson(),
        'steps': steps.map((step) => step.toJson()).toList(),
        'navigationRules': navigationRules,
      };
}
