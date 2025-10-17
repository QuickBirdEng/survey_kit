import 'package:survey_kit/src/navigator/rules/conditional_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/direct_navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/rule_not_defined_exception.dart';

abstract class NavigationRule {
  const NavigationRule();

  factory NavigationRule.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    if (type == 'conditional') {
      return ConditionalNavigationRule.fromJson(json);
    } else if (type == 'direct') {
      return DirectNavigationRule.fromJson(json);
    }
    throw const RuleNotDefinedException();
  }
  Map<String, dynamic> toJson();
}
