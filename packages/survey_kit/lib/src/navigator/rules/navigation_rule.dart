import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/navigator/rules/conditional_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/direct_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/navigation_target.dart';
import 'package:survey_kit/src/navigator/rules/rule_not_defined_exception.dart';

/// Abstract base for navigation rules that determine which step follows a given
/// step. The two built-in subtypes are [DirectNavigationRule] and
/// [ConditionalNavigationRule]. Custom rules can be added by implementing this
/// class and overriding [resolve]. Register a JSON factory for custom rules
/// with [registerFromJson].
abstract class NavigationRule {
  const NavigationRule();

  static final Map<String, NavigationRule Function(Map<String, dynamic>)>
  _converters = {
    ConditionalNavigationRule.type: ConditionalNavigationRule.fromJson,
    DirectNavigationRule.type: DirectNavigationRule.fromJson,
  };

  /// Registers a custom [NavigationRule] subtype for JSON deserialization.
  static void registerFromJson(
    String type,
    NavigationRule Function(Map<String, dynamic>) factory,
  ) {
    _converters[type] = factory;
  }

  /// Deserializes a [NavigationRule] from [json]. Dispatches on the 'type'
  /// field to the built-in rules or a factory added via [registerFromJson].
  /// Throws [RuleNotDefinedException] for unknown types.
  factory NavigationRule.fromJson(Map<String, dynamic> json) {
    final type =
        (json['type'] as String?) ??
        (json.containsKey('destinationStepIdentifier')
            ? DirectNavigationRule.type
            : ConditionalNavigationRule.type);
    final converter = _converters[type];
    if (converter == null) {
      throw const RuleNotDefinedException();
    }
    return converter(json);
  }

  /// Returns where to navigate after the step this rule is attached to, given
  /// all [previousResults] and the [questionResult] of that step.
  NavigationTarget resolve(
    List<StepResult> previousResults,
    StepResult? questionResult,
  ) => const NavigateToNextInList();

  /// Serializes this rule to a JSON map.
  Map<String, dynamic> toJson();
}
