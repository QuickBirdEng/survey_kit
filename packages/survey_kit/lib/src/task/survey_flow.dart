import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/task/survey_definition.dart';

/// Unified survey flow model for both linear and branching experiences.
///
/// When [navigationRules] is empty, flow is sequential.
/// When rules are present, transitions are evaluated dynamically.
class SurveyFlow extends SurveyDefinition {
  /// JSON type identifier for SurveyFlow.
  static const String type = 'flow';

  /// Maps a step ID to the [NavigationRule] that determines the next step
  /// after it.
  final Map<String, NavigationRule> navigationRules;

  SurveyFlow({
    String? id,
    List<Step> steps = const [],
    Step? initialStep,
    Map<String, NavigationRule>? navigationRules,
  })  : navigationRules = navigationRules ?? <String, NavigationRule>{},
        super(
          id: id,
          steps: steps,
          initialStep: initialStep,
        );

  /// Adds a [NavigationRule] for the step identified by
  /// [forTriggerStepIdentifier]. Has no effect if a rule already exists for
  /// that step.
  void addNavigationRule({
    required String forTriggerStepIdentifier,
    required NavigationRule navigationRule,
  }) {
    navigationRules.putIfAbsent(forTriggerStepIdentifier, () => navigationRule);
  }

  /// Returns the [NavigationRule] for the given step ID, or null if none is
  /// configured.
  NavigationRule? getRuleByStepIdentifier(String? stepIdentifier) {
    return navigationRules[stepIdentifier];
  }

  factory SurveyFlow.fromJson(Map<String, dynamic> json) {
    final navigationRules = <String, NavigationRule>{};

    final rules = json['rules'];
    if (rules is List) {
      for (final rule in rules) {
        final ruleJson = rule as Map<String, dynamic>;
        final triggerStep = ruleJson['triggerStepIdentifier'];
        final triggerStepId = triggerStep is Map<String, dynamic>
            ? triggerStep['id'] as String?
            : triggerStep as String?;
        if (triggerStepId == null) {
          continue;
        }
        navigationRules.putIfAbsent(
          triggerStepId,
          () => NavigationRule.fromJson(ruleJson),
        );
      }
    } else if (json['navigationRules'] is Map) {
      final legacyRules =
          (json['navigationRules'] as Map).cast<String, dynamic>();
      for (final entry in legacyRules.entries) {
        if (entry.value is! Map<String, dynamic>) {
          continue;
        }
        navigationRules.putIfAbsent(
          entry.key,
          () => NavigationRule.fromJson(entry.value as Map<String, dynamic>),
        );
      }
    }

    return SurveyFlow(
      id: json['id'] as String,
      steps: json['steps'] != null
          ? (json['steps'] as List)
              .map(
                (dynamic step) => Step.fromJson(step as Map<String, dynamic>),
              )
              .toList()
          : [],
      initialStep: json['initialStep'] != null
          ? Step.fromJson(json['initialStep'] as Map<String, dynamic>)
          : json['initalStep'] != null
              ? Step.fromJson(json['initalStep'] as Map<String, dynamic>)
              : null,
      navigationRules: navigationRules,
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'type': type,
        'steps': steps.map((step) => step.toJson()).toList(),
        'initialStep': initialStep?.toJson(),
        'rules': navigationRules.entries
            .map(
              (entry) => <String, dynamic>{
                ...entry.value.toJson(),
                'triggerStepIdentifier': <String, dynamic>{
                  'id': entry.key,
                },
              },
            )
            .toList(),
      };
}
