import 'package:flutter/material.dart' hide Step;
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
  final Widget? answerView;
  final SurveyController? controller;

  const StepView({
    super.key,
    required this.step,
    this.answerView,
    this.controller,
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

    final questionAnswer = QuestionAnswer.of(context);

    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraint.maxHeight - 60),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ContentWidget(
                            content: widget.step.content,
                          ),
                        ),
                        if (widget.answerView != null) widget.answerView!,
                        AnimatedBuilder(
                          animation: questionAnswer.isValid,
                          builder: (context, child) {
                            return OutlinedButton(
                              onPressed: questionAnswer.isValid.value ||
                                      !widget.step.isMandatory
                                  ? () => _surveyController.nextStep(
                                        context,
                                        questionAnswer.stepResult,
                                      )
                                  : null,
                              child: Text(
                                widget.step.buttonText ??
                                    surveyConfiguration.localizations?['next']
                                        ?.toUpperCase() ??
                                    'Next',
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
