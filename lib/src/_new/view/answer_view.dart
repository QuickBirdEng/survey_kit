import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/_new/model/answer/multi_select_answer.dart';
import 'package:survey_kit/src/_new/model/answer/option.dart';
import 'package:survey_kit/survey_kit.dart';

class AnswerView extends StatelessWidget {
  const AnswerView({
    super.key,
    required this.answer,
    required this.step,
    required this.stepResult,
  });
  final Answer? answer;

  final Step step;
  final StepResult? stepResult;

  @override
  Widget build(BuildContext context) {
    return _buildAnswerView();
  }

  Widget _buildAnswerView() {
    switch (answer.runtimeType) {
      case MultiSelectAnswer:
        return MultipleChoiceAnswerView(
          questionStep: step,
          result: stepResult as StepResult<List<Option>>?,
        );
      case IntegerAnswerFormat:
        return IntegerAnswerView(
          questionStep: step,
          result: stepResult as StepResult<int>?,
        );

      default:
        throw Exception('Answer type not supported: ${answer.runtimeType}');
    }
  }
}
