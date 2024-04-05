import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';

part 'direct_navigation_rule.g.dart';

@JsonSerializable()
class DirectNavigationRule implements NavigationRule {
  final String destinationStepIdentifier;

  DirectNavigationRule(this.destinationStepIdentifier);

  factory DirectNavigationRule.fromJson(Map<String, dynamic> json) =>
      _$DirectNavigationRuleFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DirectNavigationRuleToJson(this);
}
