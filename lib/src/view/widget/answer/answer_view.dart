import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/view/step_view.dart';
import 'package:survey_kit/src/view/widget/content/content_widget.dart';
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
    if (answer == null) {
      return StepView(
        step: step,
        child: ContentWidget(
          content: step.content,
        ),
      );
    }

    return _buildAnswerView();
  }

  Widget _buildAnswerView() {
    if (answer == null) {
      throw Exception('Answer is null');
    }
    return answer!.createView(step, stepResult);
  }
}
