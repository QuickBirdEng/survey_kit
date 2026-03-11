import 'package:flutter/widgets.dart';
import 'package:survey_kit/survey_kit.dart';

@immutable
class QuestionAnswer extends InheritedWidget {
  const QuestionAnswer({
    super.key,
    required super.child,
    required this.step,
    required this.isValid,
    required this.stepResult,
    required this.onValidityChanged,
    required this.onResultChanged,
  });

  final Step step;
  final bool isValid;
  final StepResult? stepResult;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool) onValidityChanged;
  final void Function(dynamic) onResultChanged;

  static QuestionAnswer of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<QuestionAnswer>();
    assert(result != null, 'No QuestionAnswer found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(QuestionAnswer oldWidget) {
    return oldWidget.isValid != isValid ||
        oldWidget.stepResult != stepResult ||
        oldWidget.step != step;
  }
}
