import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';

class ConditionalNavigationRule implements NavigationRule {
  static const type = 'conditional';

  final String? Function(List<StepResult>, StepResult?)
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
      resultToStepIdentifierMapper: (results, input) =>
          input == null ? null : inputValues[input.result?.toString()],
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'values': _values,
      };
}
