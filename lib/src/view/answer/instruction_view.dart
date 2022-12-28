import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/content/content_widget.dart';
import 'package:survey_kit/src/view/step_view.dart';

class InstructionView extends StatefulWidget {
  final Step instructionStep;

  const InstructionView({
    super.key,
    required this.instructionStep,
  });

  @override
  State<InstructionView> createState() => _InstructionViewState();
}

class _InstructionViewState extends State<InstructionView>
    with MeasureDateStateMixin {
  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.instructionStep,
      resultFunction: () => StepResult<void>(
        id: widget.instructionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        result: null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: ContentWidget(
          content: widget.instructionStep.content,
        ),
      ),
    );
  }
}
