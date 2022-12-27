import 'package:flutter/material.dart' hide Step;
import 'package:lottie/lottie.dart';
import 'package:survey_kit/src/_new/model/result/step_result.dart';
import 'package:survey_kit/src/_new/model/step.dart';
import 'package:survey_kit/src/_new/view/content/content_widget.dart';
import 'package:survey_kit/src/_new/view/step_view.dart';

class CompletionView extends StatelessWidget {
  final Step completionStep;
  final DateTime _startDate = DateTime.now();
  final String assetPath;

  CompletionView({
    super.key,
    required this.completionStep,
    this.assetPath = '',
  });

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: completionStep,
      resultFunction: () => StepResult<void>(
        id: completionStep.id,
        startTime: _startDate,
        endTime: DateTime.now(),
        result: null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Column(
          children: [
            ContentWidget(
              content: completionStep.content,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Container(
                width: 150.0,
                height: 150.0,
                child: assetPath.isNotEmpty
                    ? Lottie.asset(
                        assetPath,
                        repeat: false,
                      )
                    : Lottie.asset(
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
