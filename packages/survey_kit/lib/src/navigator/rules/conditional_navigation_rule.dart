import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/navigation_target.dart';

/// A [NavigationRule] that routes to different steps based on the current
/// answer. Provide [resultToStepIdentifierMapper] to implement custom routing
/// logic. For JSON-driven surveys, the 'values' map in JSON is used to look up
/// the next step ID from the string representation of the answer.
class ConditionalNavigationRule implements NavigationRule {
  static const type = 'conditional';

  /// A function that receives all previous results and the current step result,
  /// and returns a [NavigationTarget] indicating where to go next.
  final NavigationTarget Function(List<StepResult>, StepResult?)
      resultToStepIdentifierMapper;
  final Map<String, String> _values;

  ConditionalNavigationRule({
    required this.resultToStepIdentifierMapper,
    Map<String, String> values = const {},
  }) : _values = values;

  factory ConditionalNavigationRule.fromJson(Map<String, dynamic> json) {
    final inputValues = (json['values'] as Map<String, dynamic>? ?? {})
        .map((key, value) => MapEntry(key, value.toString()));
    return ConditionalNavigationRule(
      values: inputValues,
      resultToStepIdentifierMapper: (results, input) {
        if (input == null) return const NavigateToNextInList();
        final mapped = inputValues[input.result?.toString()];
        if (mapped == null) return const NavigateToNextInList();
        if (mapped == FinishSurvey.jsonValue) return const FinishSurvey();
        return NavigateToStep(mapped);
      },
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'values': _values,
      };
}
