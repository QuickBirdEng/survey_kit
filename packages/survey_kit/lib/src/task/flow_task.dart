import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/task/survey_flow.dart';

/// Legacy name for [SurveyFlow].
@Deprecated('Use SurveyFlow instead.')
class FlowTask extends SurveyFlow {
  static const String type = SurveyFlow.type;

  @Deprecated('Use SurveyFlow instead.')
  FlowTask({
    String? id,
    List<Step> steps = const [],
    Step? initialStep,
    Map<String, NavigationRule>? navigationRules,
  }) : super(
          id: id,
          steps: steps,
          initialStep: initialStep,
          navigationRules: navigationRules,
        );

  @Deprecated('Use SurveyFlow.fromJson instead.')
  factory FlowTask.fromJson(Map<String, dynamic> json) {
    final surveyFlow = SurveyFlow.fromJson(json);
    return FlowTask(
      id: surveyFlow.id,
      steps: surveyFlow.steps,
      initialStep: surveyFlow.initialStep,
      navigationRules: surveyFlow.navigationRules,
    );
  }
}
