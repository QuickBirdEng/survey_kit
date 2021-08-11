import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/steps/step.dart' as surveystep;
import 'package:survey_kit/src/views/widget/survey_app_bar.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:provider/provider.dart';

class StepView extends StatelessWidget {
  final surveystep.Step step;
  final Widget title;
  final Widget child;
  final QuestionResult Function() resultFunction;
  final bool canBack;
  final bool? showProgress;
  final bool isValid;
  final SurveyController? controller;

  const StepView({
    required this.step,
    required this.child,
    required this.title,
    required this.resultFunction,
    this.showProgress,
    this.controller,
    this.isValid = true,
    this.canBack = true,
  });

  @override
  Widget build(BuildContext context) {
    final _surveyController = controller ?? context.read<SurveyController>();
    final _showProgress = showProgress ?? context.read<bool>();

    return SurveyAppBar(
      content: _content(_surveyController, context),
      resultFunction: resultFunction,
      controller: controller,
      showProgress: _showProgress,
      canBack: canBack,
    );
  }

  Widget _content(SurveyController surveyController, BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: title,
                ),
                child,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: OutlinedButton(
                    onPressed: isValid || step.isOptional
                        ? () =>
                            surveyController.nextStep(context, resultFunction)
                        : null,
                    child: Text(
                      step.buttonText.toUpperCase(),
                      style: TextStyle(
                        color: isValid
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
