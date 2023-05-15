import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_presenter.dart';
import 'package:survey_kit/src/result/question_result.dart';

class SurveyController {
  /// Defines what should happen if the next step is called
  ///
  /// If the function returns `true`, the default behavior will still be executed after it.
  ///
  /// Parameters:
  /// - [context]: The build context of the widget triggering the next step.
  /// - [resultFunction]: A function that returns a [QuestionResult] object.
  ///
  /// Returns:
  /// - `true` if the default behavior should still be executed after this function, `false` otherwise.
  final bool Function(
    BuildContext context,
    QuestionResult Function() resultFunction,
  )? onNextStep;

  /// Defines what should happen if the previus step is called
  ///
  /// If the function returns `true`, the default behavior will still be executed after it.
  ///
  /// Parameters:
  /// - [context]: The build context of the widget triggering the next step.
  /// - [resultFunction]: A function that returns a [QuestionResult] object.
  ///
  /// Returns:
  /// - `true` if the default behavior should still be executed after this function, `false` otherwise.
  final bool Function(
    BuildContext context,
    QuestionResult Function()? resultFunction,
  )? onStepBack;

  /// Defines what should happen if the survey should be closed
  ///
  /// If the function returns `true`, the default behavior will still be executed after it.
  ///
  /// Parameters:
  /// - [context]: The build context of the widget triggering the next step.
  /// - [resultFunction]: A function that returns a [QuestionResult] object.
  ///
  /// Returns:
  /// - `true` if the default behavior should still be executed after this function, `false` otherwise.
  final bool Function(
    BuildContext context,
    QuestionResult Function()? resultFunction,
  )? onCloseSurvey;

  SurveyController({
    this.onNextStep,
    this.onStepBack,
    this.onCloseSurvey,
  });

  void nextStep(
    BuildContext context,
    QuestionResult Function() resultFunction,
  ) {
    if (onNextStep != null) {
      if (!onNextStep!(context, resultFunction)) return;
    }
    BlocProvider.of<SurveyPresenter>(context).add(
      NextStep(
        resultFunction.call(),
      ),
    );
  }

  void stepBack({
    required BuildContext context,
    QuestionResult Function()? resultFunction,
  }) {
    if (onStepBack != null) {
      if (!onStepBack!(context, resultFunction)) return;
    }
    BlocProvider.of<SurveyPresenter>(context).add(
      StepBack(
        resultFunction != null ? resultFunction.call() : null,
      ),
    );
  }

  void closeSurvey({
    required BuildContext context,
    QuestionResult Function()? resultFunction,
  }) {
    if (onCloseSurvey != null) {
      if (!onCloseSurvey!(context, resultFunction)) return;
    }
    BlocProvider.of<SurveyPresenter>(context).add(
      CloseSurvey(
        resultFunction != null ? resultFunction.call() : null,
      ),
    );
  }
}
