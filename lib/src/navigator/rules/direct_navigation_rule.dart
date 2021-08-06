import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';

part 'direct_navigation_rule.g.dart';

@JsonSerializable()
class DirectNavigationRule implements NavigationRule {
  final StepIdentifier destinationStepIdentifier;

  DirectNavigationRule(this.destinationStepIdentifier);

  factory DirectNavigationRule.fromJson(Map<String, dynamic> json) =>
      _$DirectNavigationRuleFromJson(json);
  Map<String, dynamic> toJson() => _$DirectNavigationRuleToJson(this);
}
