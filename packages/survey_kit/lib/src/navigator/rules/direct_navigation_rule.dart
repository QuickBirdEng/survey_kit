import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';

part 'direct_navigation_rule.g.dart';

/// A [NavigationRule] that always routes to a specific step, regardless of user
/// input. The JSON type identifier is `'direct'`.
@JsonSerializable()
class DirectNavigationRule implements NavigationRule {
  static const type = 'direct';

  /// The ID of the step to navigate to.
  final String destinationStepIdentifier;

  DirectNavigationRule(this.destinationStepIdentifier);

  factory DirectNavigationRule.fromJson(Map<String, dynamic> json) =>
      _$DirectNavigationRuleFromJson(json);
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        ..._$DirectNavigationRuleToJson(this),
      };
}
