import 'package:flutter/material.dart' hide Step;
import 'package:provider/provider.dart';
import 'package:survey_kit/src/_new/model/result/step_result.dart';
import 'package:survey_kit/src/_new/model/step.dart';
import 'package:survey_kit/src/survey_configuration.dart';
import 'package:survey_kit/survey_kit.dart';

class StepView extends StatelessWidget {
  final Step step;
  final Widget child;
  final StepResult Function() resultFunction;
  final bool isValid;
  final SurveyController? controller;

  const StepView({
    super.key,
    required this.step,
    required this.child,
    required this.resultFunction,
    this.controller,
    this.isValid = true,
  });

  @override
  Widget build(BuildContext context) {
    final _surveyController =
        controller ?? SurveyConfiguration.of(context).surveyController;

    return _content(_surveyController, context);
  }

  Widget _content(SurveyController surveyController, BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              child,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: OutlinedButton(
                  onPressed: isValid || !step.isMandatory
                      ? () => surveyController.nextStep(context, resultFunction)
                      : null,
                  child: Text(
                    context
                            .read<Map<String, String>?>()?['next']
                            ?.toUpperCase() ??
                        'Next',
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
    );
  }
}
