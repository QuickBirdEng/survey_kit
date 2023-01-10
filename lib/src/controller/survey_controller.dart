import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_presenter_inherited.dart';

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
    StepResult Function() resultFunction,
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
    StepResult Function()? resultFunction,
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
    StepResult Function()? resultFunction,
  )? onCloseSurvey;

  SurveyController({
    this.onNextStep,
    this.onStepBack,
    this.onCloseSurvey,
  });

  void nextStep(
    BuildContext context,
    StepResult Function() resultFunction,
  ) {
    if (onNextStep != null) {
      onNextStep!(context, resultFunction);
      return;
    }
    SurveyPresenterInherited.of(context).onEvent(
      NextStep(
        resultFunction.call(),
      ),
    );
  }

  void stepBack({
    required BuildContext context,
    StepResult Function()? resultFunction,
  }) {
    if (onStepBack != null) {
      onStepBack!(context, resultFunction);
      return;
    }
    SurveyPresenterInherited.of(context).onEvent(
      StepBack(
        resultFunction?.call(),
      ),
    );
  }

  void closeSurvey({
    required BuildContext context,
    StepResult Function()? resultFunction,
  }) {
    if (onCloseSurvey != null) {
      onCloseSurvey!(context, resultFunction);
      return;
    }
    SurveyPresenterInherited.of(context).onEvent(
      CloseSurvey(
        resultFunction?.call(),
      ),
    );
  }
}
