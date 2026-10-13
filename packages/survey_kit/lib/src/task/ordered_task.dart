import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/task/survey_flow.dart';

/// Legacy linear task model.
@Deprecated(
  'Use SurveyFlow instead. For linear flow, provide no navigationRules.',
)
class OrderedTask extends SurveyFlow {
  static const String legacyType = 'ordered';

  @Deprecated('Use SurveyFlow instead.')
  OrderedTask({
    required String id,
    required List<Step> steps,
    Step? initialStep,
  }) : super(
         id: id,
         steps: steps,
         initialStep: initialStep,
         navigationRules: const <String, NavigationRule>{},
       );

  @Deprecated('Use SurveyFlow.fromJson instead.')
  factory OrderedTask.fromJson(Map<String, dynamic> json) {
    final flow = SurveyFlow.fromJson(json);
    return OrderedTask(
      id: flow.id,
      steps: flow.steps,
      initialStep: flow.initialStep,
    );
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..['type'] = legacyType
    ..remove('rules');
}
