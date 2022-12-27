import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/_new/model/result/step_result.dart';
import 'package:survey_kit/src/_new/model/step.dart';
import 'package:survey_kit/src/_new/view/content/content_widget.dart';
import 'package:survey_kit/src/_new/view/step_view.dart';

class InstructionView extends StatelessWidget {
  final Step instructionStep;
  final DateTime _startDate = DateTime.now();

  InstructionView({
    super.key,
    required this.instructionStep,
  });

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: instructionStep,
      resultFunction: () => StepResult<void>(
        id: instructionStep.id,
        startTime: _startDate,
        endTime: DateTime.now(),
        result: null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: ContentWidget(
          content: instructionStep.content,
        ),
      ),
    );
  }
}
