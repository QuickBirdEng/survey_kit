import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_presenter.dart';
import 'package:survey_kit/src/result/question_result.dart';

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
    QuestionResult Function() resultFunction,
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
    QuestionResult Function()? resultFunction,
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
      onNextStep!(context, resultFunction);
      return;
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
      onStepBack!(context, resultFunction);
      return;
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
      onCloseSurvey!(context, resultFunction);
      return;
    }
    BlocProvider.of<SurveyPresenter>(context).add(
      CloseSurvey(
        resultFunction != null ? resultFunction.call() : null,
      ),
    );
  }
}
