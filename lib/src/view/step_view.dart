import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/view/widget/content/content_widget.dart';
import 'package:survey_kit/survey_kit.dart';

typedef StepShell = Widget Function({
  required Step step,
  required Widget child,
  StepResult Function()? resultFunction,
  bool isValid,
  SurveyController? controller,
});

class StepView extends StatefulWidget {
  final Step step;
  final Widget? child;
  final StepResult Function()? resultFunction;
  final bool isValid;
  final SurveyController? controller;

  const StepView({
    super.key,
    required this.step,
    this.child,
    this.resultFunction,
    this.controller,
    this.isValid = true,
  });

  @override
  State<StepView> createState() => _StepViewState();
}

class _StepViewState extends State<StepView> {
  final startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final surveyConfiguration = SurveyConfiguration.of(context);
    final _surveyController =
        widget.controller ?? surveyConfiguration.surveyController;

    final stepShell = SurveyPresenterInherited.of(context).stepShell;

    if (stepShell != null) {
      return stepShell.call(
        widget.step,
        widget.child ?? Container(),
        widget.resultFunction,
        widget.isValid,
        _surveyController,
      );
    }

    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ContentWidget(
                content: widget.step.content,
              ),
            ),
            if (widget.child != null)
              Expanded(
                child: widget.child!,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: OutlinedButton(
                onPressed: widget.isValid || !widget.step.isMandatory
                    ? () => _surveyController.nextStep(
                          context,
                          widget.resultFunction ??
                              () {
                                return StepResult<void>(
                                  id: widget.step.id,
                                  result: null,
                                  endTime: DateTime.now(),
                                  startTime: startTime,
                                );
                              },
                        )
                    : null,
                child: Text(
                  widget.step.buttonText ??
                      surveyConfiguration.localizations?['next']
                          ?.toUpperCase() ??
                      'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
