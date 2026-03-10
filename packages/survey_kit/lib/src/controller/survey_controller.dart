import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_state_provider.dart';

class SurveyController {
  /// Called when the next step is requested. Receives the current [stepResult]
  /// and a [proceed] callback. Call [proceed] to continue with the default
  /// navigation. Omitting the call will halt navigation until [proceed] is
  /// invoked (e.g. after an async operation).

  final void Function(
    BuildContext context,
    StepResult? stepResult,
    void Function() proceed,
  )? onNextStep;

  /// Called when the previous step is requested.
  /// Call [proceed] to continue with default back-navigation.

  final void Function(
    BuildContext context,
    StepResult? stepResult,
    void Function() proceed,
  )? onStepBack;

  /// Called when the survey should be closed.
  /// Call [proceed] to continue with default close behaviour.

  final void Function(
    StepResult? stepResult,
    void Function() proceed,
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
    void proceed() => SurveyStateProvider.of(resolvedContext).onEvent(
          NextStep(stepResult),
        );
    if (onNextStep != null) {
      onNextStep!(resolvedContext, stepResult, proceed);
      return;
    }
    proceed();
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
    void proceed() => SurveyStateProvider.of(resolvedContext).onEvent(
          StepBack(stepResult),
        );
    if (onStepBack != null) {
      onStepBack!(resolvedContext, stepResult, proceed);
      return;
    }
    proceed();
  }

  void closeSurvey({
    StepResult? stepResult,
  }) {
    final resolvedContext = _resolveContext(null);
    void proceed() => SurveyStateProvider.of(resolvedContext).onEvent(
          CloseSurvey(stepResult),
        );
    if (onCloseSurvey != null) {
      onCloseSurvey!(stepResult, proceed);
      return;
    }
    proceed();
  }
}
