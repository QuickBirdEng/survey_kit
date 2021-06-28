import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:survey_kit/src/result/step/completion_step_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/completion_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';

class CompletionView extends StatelessWidget {
  final CompletionStep completionStep;
  final DateTime _startDate = DateTime.now();

  CompletionView({required this.completionStep});

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: completionStep,
      resultFunction: () => CompletionStepResult(
        completionStep.stepIdentifier,
        _startDate,
        DateTime.now(),
      ),
      title: Text(
        completionStep.title,
        style: TextStyle(
          fontSize: 28.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Column(
          children: [
            Text(
              completionStep.text,
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Container(
                width: 150.0,
                height: 150.0,
                child: Lottie.asset(
                  'assets/fancy_checkmark.json',
                  package: 'survey_kit',
                  repeat: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
