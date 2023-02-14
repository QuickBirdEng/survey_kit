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
  DateTime endTime = DateTime.now();

  final Step step;

  bool isValid = true;

  StepResult<R?>? _stepResult;
  StepResult<R?>? get stepResult => _stepResult;
  void setStepResult(R? result) {
    _stepResult = StepResult<R>(
      id: step.id,
      result: result,
      startTime: startTime,
      endTime: endTime,
      valueIdentifier: result.toString(),
    );
  }

  static QuestionAnswer of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<QuestionAnswer>();
    assert(result != null, 'No QuestionAnswer found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(QuestionAnswer oldWidget) => false;
}
