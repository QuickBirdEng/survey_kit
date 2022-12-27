import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/_new/model/answer/answer.dart';
import 'package:survey_kit/src/_new/model/answer/multi_select_answer.dart';
import 'package:survey_kit/src/_new/model/answer/option.dart';
import 'package:survey_kit/src/_new/model/result/step_result.dart';
import 'package:survey_kit/src/_new/model/step.dart';
import 'package:survey_kit/src/_new/view/multiple_choice_answer_view.dart';
import 'package:survey_kit/src/_new/view/step_view.dart';

class AnswerView extends StatelessWidget {
  const AnswerView({
    super.key,
    required this.answer,
    required this.step,
    required this.stepResult,
  });
  final Answer answer;

  final Step step;
  final StepResult? stepResult;

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: step,
      resultFunction: () {
        //TODO: implement resultFunction
        return StepResult<String>(
          id: '1',
          result: 'result',
          startTime: DateTime.now(),
          endTime: DateTime.now(),
        );
      },
      child: _buildAnswerView(),
    );
  }

  Widget _buildAnswerView() {
    switch (answer.runtimeType) {
      case MultiSelectAnswer:
        return MultipleChoiceAnswerView(
          questionStep: step,
          result: stepResult as StepResult<List<Option>>?,
        );

      default:
        throw Exception('Answer type not supported: ${answer.runtimeType}');
    }
  }
}
