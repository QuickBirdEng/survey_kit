import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/view/step_view.dart';
import 'package:survey_kit/survey_kit.dart';

class AnswerView extends StatefulWidget {
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
  State<AnswerView> createState() => _AnswerViewState();
}

class _AnswerViewState extends State<AnswerView> {
  @override
  Widget build(BuildContext context) {
    Widget? answerView;
    if (widget.answer != null) {
      answerView = widget.answer!.createView(widget.step, widget.stepResult);
    }
    final stepShell =
        widget.step.stepShell ?? SurveyStateProvider.of(context).stepShell;

    return QuestionAnswer<dynamic>(
      step: widget.step,
      child: Builder(
        builder: (context) => stepShell != null
            ? stepShell.call(
                widget.step,
                answerView,
                context,
              )
            : StepView(
                step: widget.step,
                answerView: answerView,
              ),
      ),
    );
  }
}
