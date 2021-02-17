import 'package:flutter/widgets.dart';
import 'package:surveykit/src/navigator/rules/navigation_rule.dart';
import 'package:surveykit/src/steps/identifier/step_identifier.dart';

class ConditionalNavigationRule implements NavigationRule {
  final StepIdentifier Function(String) resultToStepIdentifierMapper;

  ConditionalNavigationRule({@required this.resultToStepIdentifierMapper});
}
