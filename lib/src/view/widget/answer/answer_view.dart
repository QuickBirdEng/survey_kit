import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/view/step_view.dart';
import 'package:survey_kit/survey_kit.dart';

class AnswerView extends StatelessWidget {
  const AnswerView({
    super.key,
    required this.answer,
    required this.step,
    required this.stepResult,
  });
  final AnswerFormat? answer;

  final Step step;
  final StepResult? stepResult;

  @override
  Widget build(BuildContext context) {
    Widget? answerView;
    if (answer != null) {
      answerView = answer!.createView(step, stepResult);
    }
    final stepShell =
        step.stepShell ?? SurveyPresenterInherited.of(context).stepShell;

    return QuestionAnswer<dynamic>(
      step: step,
      child: Builder(
        builder: (context) => stepShell != null
            ? stepShell.call(
                step,
                answerView,
                context,
              )
            : StepView(
                step: step,
                answerView: answerView,
              ),
      ),
    );
  }
}
