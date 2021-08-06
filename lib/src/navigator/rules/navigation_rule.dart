import 'package:survey_kit/src/navigator/rules/rule_not_defined_exception.dart';
import 'package:survey_kit/survey_kit.dart';

abstract class NavigationRule {
  const NavigationRule();

  factory NavigationRule.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type == 'conditional') {
      return ConditionalNavigationRule.fromJson(json);
    } else if (type == 'direct') {
      return DirectNavigationRule.fromJson(json);
    }
    throw RuleNotDefinedException();
  }
  Map<String, dynamic> toJson();
}
