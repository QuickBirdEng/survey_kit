import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_state_provider.dart';

class SurveyController {
  /// Defines what should happen if the next step is called
  /// Default behavior is:
  /// ```dart
  /// BlocProvider.of<SurveyPresenter>(context).add(
  ///    NextStep(
  ///      resultFunction.call(),
  ///    ),
  /// );
  /// ```
  final Function(
    BuildContext context,
    StepResult? stepResult,
  )? onNextStep;

  /// Defines what should happen if the previous step is called
  /// Default behavior is:
  /// ```dart
  /// BlocProvider.of<SurveyPresenter>(context).add(
  ///    StepBack(
  ///      resultFunction.call(),
  ///    ),
  /// );
  /// ```
  final Function(
    BuildContext context,
    StepResult? stepResult,
  )? onStepBack;

  /// Defines what should happen if the survey should be closed
  /// Default behavior is:
  /// ```dart
  /// BlocProvider.of<SurveyPresenter>(context).add(
  ///    CloseSurvey(
  ///      resultFunction.call(),
  ///    ),
  /// );
  /// ```
  final Function(
    BuildContext context,
    StepResult? stepResult,
  )? onCloseSurvey;

  SurveyController({
    this.onNextStep,
    this.onStepBack,
    this.onCloseSurvey,
  });

  void nextStep(
    BuildContext context,
    StepResult? stepResult,
  ) {
    if (onNextStep != null) {
      onNextStep!(context, stepResult);
      return;
    }
    SurveyStateProvider.of(context).onEvent(
      NextStep(
        stepResult,
      ),
    );
  }

  void stepBack({
    required BuildContext context,
    StepResult? stepResult,
  }) {
    if (onStepBack != null) {
      onStepBack!(context, stepResult);
      return;
    }
    SurveyStateProvider.of(context).onEvent(
      StepBack(
        stepResult,
      ),
    );
  }

  void closeSurvey({
    required BuildContext context,
    StepResult? stepResult,
  }) {
    if (onCloseSurvey != null) {
      onCloseSurvey!(context, stepResult);
      return;
    }
    SurveyStateProvider.of(context).onEvent(
      CloseSurvey(
        stepResult,
      ),
    );
  }
}
