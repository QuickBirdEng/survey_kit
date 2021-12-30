import 'package:flutter/material.dart';
import 'package:survey_kit/src/result/step/instruction_step_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/instruction_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';

class InstructionView extends StatelessWidget {
  final InstructionStep instructionStep;
  final DateTime _startDate = DateTime.now();

  InstructionView({required this.instructionStep});

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: instructionStep,
      title: Text(
        instructionStep.title,
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
      ),
      resultFunction: () => InstructionStepResult(
        instructionStep.stepIdentifier,
        _startDate,
        DateTime.now(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Text(
          instructionStep.text,
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
