import 'package:surveykit/src/navigator/rules/navigation_rule.dart';
import 'package:surveykit/src/steps/identifier/step_identifier.dart';

class DirectNavigationRule implements NavigationRule {
  final StepIdentifier destinationStepIdentifier;

  DirectNavigationRule(this.destinationStepIdentifier);
}
