import 'package:survey_kit/src/navigator/rules/conditional_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/direct_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/rule_not_defined_exception.dart';

/// Abstract base for navigation rules that determine which step follows a given
/// step. The two built-in subtypes are [DirectNavigationRule] and
/// [ConditionalNavigationRule]. Custom rules can be added by implementing this
/// class.
abstract class NavigationRule {
  const NavigationRule();

  /// Deserializes a [NavigationRule] from [json]. Dispatches to
  /// [DirectNavigationRule] or [ConditionalNavigationRule] based on the 'type'
  /// field.
  factory NavigationRule.fromJson(Map<String, dynamic> json) {
    final type = (json['type'] as String?) ??
        (json.containsKey('destinationStepIdentifier')
            ? DirectNavigationRule.type
            : ConditionalNavigationRule.type);
    if (type == 'conditional') {
      return ConditionalNavigationRule.fromJson(json);
    } else if (type == 'direct') {
      return DirectNavigationRule.fromJson(json);
    }
    throw const RuleNotDefinedException();
  }
  /// Serializes this rule to a JSON map.
  Map<String, dynamic> toJson();
}
