import 'conditional_navigation_rule.dart';
import 'direct_navigation_rule.dart';
import 'rule_not_defined_exception.dart';

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
