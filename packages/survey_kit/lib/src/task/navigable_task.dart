import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/task/survey_flow.dart';

/// Definition of task which can handle routing between [Tasks]
/// The [navigationRules] defines on which Step [StepIdentifier] which next Step
/// is called. The logic which [Step] is called is defined in the
/// [NavigationRule]
@Deprecated(
  'Use SurveyFlow instead. It supports both linear and branching flow.',
)
class NavigableTask extends SurveyFlow {
  static const String legacyType = 'navigable';

  @Deprecated('Use SurveyFlow instead.')
  NavigableTask({
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
  factory NavigableTask.fromJson(Map<String, dynamic> json) {
    final flowTask = SurveyFlow.fromJson(json);
    return NavigableTask(
      id: flowTask.id,
      steps: flowTask.steps,
      initialStep: flowTask.initialStep,
      navigationRules: flowTask.navigationRules,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['type'] = legacyType;
    return json;
  }
}
