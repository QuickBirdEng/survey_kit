import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/task/identifier/task_identifier.dart';
import 'package:survey_kit/src/task/task.dart';

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
  })  : navigationRules = navigationRules ?? {},
        super(
          id: id,
          steps: steps,
          initalStep: initialStep,
        );

  /// Adds a [NavigationRule] to the [navigationRule] Map
  /// It only adds the [NavigationRule] if none is already set for the
  /// [StepIdentifier]
  void addNavigationRule({
    required StepIdentifier forTriggerStepIdentifier,
    required NavigationRule navigationRule,
  }) {
    navigationRules.putIfAbsent(forTriggerStepIdentifier, () => navigationRule);
  }

  /// Gets the [NavigationRule] which is defined for the given [StepIndentifier]
  /// Returns null if none is defined
  NavigationRule? getRuleByStepIdentifier(StepIdentifier? stepIdentifier) {
    return navigationRules[stepIdentifier];
  }

  factory NavigableTask.fromJson(Map<String, dynamic> json) {
    final navigationRules = <StepIdentifier, NavigationRule>{};

    if (json['rules'] != null) {
      final rules = json['rules'] as List;
      for (final rule in rules) {
        navigationRules.putIfAbsent(
          StepIdentifier.fromJson(
            rule['triggerStepIdentifier'] as Map<String, dynamic>,
          ),
          () => NavigationRule.fromJson(rule as Map<String, dynamic>),
        );
      }
    }

    return NavigableTask(
      id: TaskIdentifier.fromJson(json),
      steps: json['steps'] != null
          ? (json['steps'] as List)
              .map(
                (dynamic step) => Step.fromJson(step as Map<String, dynamic>),
              )
              .toList()
          : [],
      navigationRules: navigationRules,
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id.toJson(),
        'steps': steps.map((step) => step.toJson()).toList(),
        'navigationRules': navigationRules,
      };
}
