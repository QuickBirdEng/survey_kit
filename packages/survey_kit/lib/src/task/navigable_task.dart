import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/task/task.dart';

/// Definition of task which can handle routing between [Tasks]
/// The [navigationRules] defines on which Step [StepIdentifier] which next Step
/// is called. The logic which [Step] is called is defined in the
/// [NavigationRule]
class NavigableTask extends Task {
  final Map<String, NavigationRule> navigationRules;

  NavigableTask({
    String? id,
    List<Step> steps = const [],
    Step? initialStep,
    Map<String, NavigationRule>? navigationRules,
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
    required String forTriggerStepIdentifier,
    required NavigationRule navigationRule,
  }) {
    navigationRules.putIfAbsent(forTriggerStepIdentifier, () => navigationRule);
  }

  /// Gets the [NavigationRule] which is defined for the given [StepIndentifier]
  /// Returns null if none is defined
  NavigationRule? getRuleByStepIdentifier(String? stepIdentifier) {
    return navigationRules[stepIdentifier];
  }

  factory NavigableTask.fromJson(Map<String, dynamic> json) {
    final navigationRules = <String, NavigationRule>{};

    if (json['rules'] != null) {
      final rules = json['rules'] as List;
      for (final rule in rules) {
        navigationRules.putIfAbsent(
          ((rule as Map<String, dynamic>)['triggerStepIdentifier']
              as Map<String, dynamic>)['id'] as String,
          () => NavigationRule.fromJson(rule),
        );
      }
    }

    return NavigableTask(
      id: json['id'] as String,
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
        'id': id,
        'steps': steps.map((step) => step.toJson()).toList(),
        'navigationRules': navigationRules,
      };
}
