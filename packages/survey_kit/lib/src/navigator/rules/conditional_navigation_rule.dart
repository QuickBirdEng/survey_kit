import 'package:survey_kit/src/model/answer/boolean_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/result/time_result.dart';
import 'package:survey_kit/src/navigator/rules/navigation_rule.dart';
import 'package:survey_kit/src/navigator/rules/navigation_target.dart';

/// A [NavigationRule] that routes to different steps based on the current
/// answer. Provide [resultToStepIdentifierMapper] to implement custom routing
/// logic. For JSON-driven surveys, the 'values' map in JSON is used to look up
/// the next step ID from the answer: a [TextChoice] matches by its value, text
/// or id, a [BooleanResult] by its name, a [DateTime] by its ISO 8601 string,
/// a [TimeResult] by `HH:mm` and any other value by its string form.
class ConditionalNavigationRule extends NavigationRule {
  static const type = 'conditional';

  /// A function that receives all previous results and the current step result,
  /// and returns a [NavigationTarget] indicating where to go next.
  final NavigationTarget Function(List<StepResult>, StepResult?)
  resultToStepIdentifierMapper;
  final Map<String, String> _values;

  ConditionalNavigationRule({
    required this.resultToStepIdentifierMapper,
    Map<String, String> values = const {},
  }) : _values = Map.unmodifiable(values);

  factory ConditionalNavigationRule.fromJson(Map<String, dynamic> json) {
    final inputValues = (json['values'] as Map<String, dynamic>? ?? {}).map(
      (key, value) => MapEntry(key, value.toString()),
    );
    return ConditionalNavigationRule(
      values: inputValues,
      resultToStepIdentifierMapper: (results, input) {
        final mapped = _lookupKeys(
          input?.result,
        ).map((key) => inputValues[key]).nonNulls.firstOrNull;
        if (mapped == null) return const NavigateToNextInList();
        if (mapped == FinishSurvey.jsonValue) return const FinishSurvey();
        return NavigateToStep(mapped);
      },
    );
  }

  static Iterable<String> _lookupKeys(Object? result) sync* {
    switch (result) {
      case null:
        return;
      case TextChoice(:final value, :final text, :final id):
        if (value != null) yield value;
        yield text;
        yield id;
      case BooleanResult():
        yield result.name;
      case DateTime():
        yield result.toIso8601String();
      case TimeResult(:final timeOfDay):
        yield '${timeOfDay.hour.toString().padLeft(2, '0')}:'
            '${timeOfDay.minute.toString().padLeft(2, '0')}';
    }
    yield result.toString();
  }

  @override
  NavigationTarget resolve(
    List<StepResult> previousResults,
    StepResult? questionResult,
  ) => resultToStepIdentifierMapper(previousResults, questionResult);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'values': _values,
  };
}
