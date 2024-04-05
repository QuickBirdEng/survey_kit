import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/survey_kit.dart';

// ignore: must_be_immutable
class QuestionAnswer<R> extends InheritedWidget {
  QuestionAnswer({
    super.key,
    required super.child,
    required this.step,
  });

  DateTime startTime = DateTime.now();

  final Step step;

  final ValueNotifier<bool> isValid = ValueNotifier<bool>(true);
  // ignore: avoid_positional_boolean_parameters, use_setters_to_change_properties
  void setIsValid(bool isValid) {
    this.isValid.value = isValid;
  }

  StepResult<R?>? _stepResult;
  StepResult<R?>? get stepResult => _stepResult;
  void setStepResult(R? result) {
    _stepResult = StepResult<R>(
      id: step.id,
      step: step,
      result: result,
      startTime: startTime,
      endTime: DateTime.now(),
    );
  }

  static QuestionAnswer of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<QuestionAnswer>();
    assert(result != null, 'No QuestionAnswer found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(QuestionAnswer oldWidget) {
    return oldWidget.step != step ||
        oldWidget.isValid != isValid ||
        oldWidget.stepResult != stepResult;
  }
}
