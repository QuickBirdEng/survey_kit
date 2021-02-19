import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';

class ConditionalNavigationRule implements NavigationRule {
  final StepIdentifier Function(String) resultToStepIdentifierMapper;

  ConditionalNavigationRule({@required this.resultToStepIdentifierMapper});
}
