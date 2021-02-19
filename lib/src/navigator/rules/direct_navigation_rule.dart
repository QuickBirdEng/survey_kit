import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';

class DirectNavigationRule implements NavigationRule {
  final StepIdentifier destinationStepIdentifier;

  DirectNavigationRule(this.destinationStepIdentifier);
}
