import 'package:flutter/material.dart' hide Step;
import 'package:lottie/lottie.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/content/content_widget.dart';
import 'package:survey_kit/src/view/step_view.dart';

class CompletionView extends StatefulWidget {
  final Step completionStep;

  final String assetPath;

  const CompletionView({
    super.key,
    required this.completionStep,
    this.assetPath = '',
  });

  @override
  State<CompletionView> createState() => _CompletionViewState();
}

class _CompletionViewState extends State<CompletionView>
    with MeasureDateStateMixin {
  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.completionStep,
      resultFunction: () => StepResult<void>(
        id: widget.completionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        result: null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Column(
          children: [
            ContentWidget(
              content: widget.completionStep.content,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Container(
                width: 150.0,
                height: 150.0,
                child: widget.assetPath.isNotEmpty
                    ? Lottie.asset(
                        widget.assetPath,
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
