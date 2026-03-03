import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_state_provider.dart';

class SurveyController {
  /// Defines what should happen if the next step is called
  /// Default behavior is:

  final Function(
    BuildContext context,
    StepResult? stepResult,
  )? onNextStep;

  /// Defines what should happen if the previous step is called
  /// Default behavior is:

  final Function(
    BuildContext context,
    StepResult? stepResult,
  )? onStepBack;

  /// Defines what should happen if the survey should be closed
  /// Default behavior is:

  final Function(
    StepResult? stepResult,
  )? onCloseSurvey;

  SurveyController({
    this.onNextStep,
    this.onStepBack,
    this.onCloseSurvey,
  });

  GlobalKey<NavigatorState>? _navigatorKey;

  @internal
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @internal
  set navigatorKey(GlobalKey<NavigatorState>? navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  BuildContext _resolveContext(BuildContext? context) {
    final resolvedContext = context ?? _navigatorKey?.currentContext;
    if (resolvedContext == null) {
      throw StateError(
        'SurveyController is not attached to an active SurveyKit context. '
        'Pass a BuildContext explicitly or call this after SurveyKit is built.',
      );
    }
    return resolvedContext;
  }

  /// Triggers "next step" navigation.
  ///
  /// [context] is optional when this controller is attached to [SurveyKit].
  void next({
    BuildContext? context,
    StepResult? stepResult,
  }) {
    final resolvedContext = _resolveContext(context);
    if (onNextStep != null) {
      onNextStep!(resolvedContext, stepResult);
      return;
    }
    SurveyStateProvider.of(resolvedContext).onEvent(
      NextStep(
        stepResult,
      ),
    );
  }

  @Deprecated(
    'Use next(context: ..., stepResult: ...) instead.',
  )
  void nextStep(
    BuildContext context,
    StepResult? stepResult,
  ) {
    next(
      context: context,
      stepResult: stepResult,
    );
  }

  void stepBack({
    BuildContext? context,
    StepResult? stepResult,
  }) {
    final resolvedContext = _resolveContext(context);
    if (onStepBack != null) {
      onStepBack!(resolvedContext, stepResult);
      return;
    }
    SurveyStateProvider.of(resolvedContext).onEvent(
      StepBack(
        stepResult,
      ),
    );
  }

  void closeSurvey({
    StepResult? stepResult,
  }) {
    if (onCloseSurvey != null) {
      onCloseSurvey!(stepResult);
      return;
    }
    final resolvedContext = _resolveContext(null);
    SurveyStateProvider.of(resolvedContext).onEvent(
      CloseSurvey(
        stepResult,
      ),
    );
  }
}
