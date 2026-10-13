import 'dart:math' as math;

import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/survey_kit.dart';

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
  @override
  Widget build(BuildContext context) {
    final surveyController =
        widget.controller ?? SurveyConfiguration.of(context).surveyController;
    final questionAnswer = QuestionAnswer.of(context);
    final canContinue = questionAnswer.isValid || !widget.step.isMandatory;

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: math.max(0, constraints.maxHeight - 60),
                ),
                child: IntrinsicHeight(
                  child: _StepContent(
                    step: widget.step,
                    answerView: widget.answerView,
                    onNext: canContinue
                        ? () => surveyController.next(
                            context: context,
                            stepResult: questionAnswer.stepResult,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepContent extends StatelessWidget {
  const _StepContent({
    required this.step,
    required this.answerView,
    required this.onNext,
  });

  final Step step;
  final Widget? answerView;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final answerView = this.answerView;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: ContentWidget(content: step.content)),
        if (answerView != null) answerView,
        const SizedBox(height: 32),
        _NextButton(buttonText: step.buttonText, onPressed: onNext),
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.buttonText, required this.onPressed});

  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText ?? SurveyKitLocalizations.of(context)?.next ?? 'Next',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
