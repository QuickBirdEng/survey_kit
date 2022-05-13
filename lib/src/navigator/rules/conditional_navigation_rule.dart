import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';

class ConditionalNavigationRule implements NavigationRule {
  final StepIdentifier? Function(String?) resultToStepIdentifierMapper;

  ConditionalNavigationRule({required this.resultToStepIdentifierMapper});

  factory ConditionalNavigationRule.fromJson(Map<String, dynamic> json) {
    final inputValues = json['values'] as Map<String, dynamic>;
    return ConditionalNavigationRule(
      resultToStepIdentifierMapper: (input) {
        for (final MapEntry entry in inputValues.entries) {
          if (entry.key == input) {
            return StepIdentifier(id: entry.value);
          }
        }
        return null;
      },
    );
  }

  Map<String, dynamic> toJson() => {'values': {}};
}
