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
  factory OrderedTask.fromJson(Map<String, dynamic> json) => OrderedTask(
        id: json['id'] as String,
        steps: json['steps'] != null
            ? (json['steps'] as List)
                .map(
                  (dynamic step) => Step.fromJson(step as Map<String, dynamic>),
                )
                .toList()
            : <Step>[],
        initialStep: json['initialStep'] != null
            ? Step.fromJson(json['initialStep'] as Map<String, dynamic>)
            : json['initalStep'] != null
                ? Step.fromJson(json['initalStep'] as Map<String, dynamic>)
                : null,
      );

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..['type'] = legacyType
    ..remove('rules');
}
