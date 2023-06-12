import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/survey_kit.dart';

// ignore: must_be_immutable
class SurveyStateProvider extends InheritedWidget {
  SurveyStateProvider({
    super.key,
    required this.taskNavigator,
    required this.onResult,
    required super.child,
    required this.navigatorKey,
    this.stepShell,
  })  : _state = LoadingSurveyState(),
        startDate = DateTime.now();

  final TaskNavigator taskNavigator;
  final Function(SurveyResult) onResult;
  final StepShell? stepShell;
  final GlobalKey<NavigatorState> navigatorKey;

  late SurveyState _state;
  SurveyState get state => _state;
  void updateState(SurveyState newState) {
    _state = newState;
    surveyStateStream.add(_state);
  }

  late StreamController<SurveyState> surveyStateStream =
      StreamController<SurveyState>.broadcast();

  static SurveyStateProvider of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SurveyStateProvider>();
    assert(result != null, 'No SurveyPresenterInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SurveyStateProvider oldWidget) =>
      taskNavigator != oldWidget.taskNavigator ||
      onResult != oldWidget.onResult ||
      _state != oldWidget._state;

  Set<StepResult> results = {};
  late final DateTime startDate;

  void onEvent(SurveyEvent event) {
    if (event is StartSurvey) {
      final newState = _handleInitialStep();
      updateState(newState);
      navigatorKey.currentState?.pushNamed(
        '/',
        arguments: newState,
      );
    } else if (event is NextStep) {
      if (state is PresentingSurveyState) {
        final newState = _handleNextStep(event, state as PresentingSurveyState);
        updateState(newState);
        navigatorKey.currentState?.pushNamed(
          '/',
          arguments: newState,
        );
      }
    } else if (event is StepBack) {
      if (state is PresentingSurveyState) {
        final newState = _handleStepBack(event, state as PresentingSurveyState);
        updateState(newState);
        navigatorKey.currentState?.pop();
      }
    } else if (event is CloseSurvey) {
      if (state is PresentingSurveyState) {
        final newState = _handleClose(event, state as PresentingSurveyState);
        updateState(newState);
        navigatorKey.currentState?.pop();
      }
    }
  }

  SurveyState _handleInitialStep() {
    final step = taskNavigator.firstStep();
    if (step != null) {
      return PresentingSurveyState(
        currentStep: step,
        questionResults: results,
        steps: taskNavigator.task.steps,
        result: null,
        currentStepIndex: currentStepIndex(step),
        stepCount: countSteps,
      );
    }

    //If not steps are provided we finish the survey
    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startTime: startDate,
      endTime: DateTime.now(),
      finishReason: FinishReason.completed,
      results: const [],
    );

    return SurveyResultState(
      result: taskResult,
      currentStep: null,
    );
  }

  SurveyState _handleNextStep(
    NextStep event,
    PresentingSurveyState currentState,
  ) {
    _addResult(event.questionResult);
    final nextStep = taskNavigator.nextStep(
      step: currentState.currentStep,
      previousResults: results.toList(),
      questionResult: event.questionResult,
    );

    if (nextStep == null) {
      return _handleSurveyFinished(currentState);
    }

    final questionResult = _getResultByStepIdentifier(nextStep.id);

    return PresentingSurveyState(
      currentStep: nextStep,
      result: questionResult,
      steps: taskNavigator.task.steps,
      questionResults: results,
      currentStepIndex: currentStepIndex(nextStep),
      stepCount: countSteps,
    );
  }

  SurveyState _handleStepBack(
    StepBack event,
    PresentingSurveyState currentState,
  ) {
    _addResult(event.questionResult);
    final previousStep = taskNavigator.previousInList(currentState.currentStep);

    //If theres no previous step we can't go back further

    if (previousStep != null) {
      final questionResult = _getResultByStepIdentifier(previousStep.id);

      return PresentingSurveyState(
        currentStep: previousStep,
        result: questionResult,
        steps: taskNavigator.task.steps,
        questionResults: results,
        currentStepIndex: currentStepIndex(previousStep),
        isPreviousStep: true,
        stepCount: countSteps,
      );
    }

    return state;
  }

  StepResult? _getResultByStepIdentifier(String? identifier) {
    return results.firstWhereOrNull(
      (element) => element.id == identifier,
    );
  }

  SurveyState _handleClose(
    CloseSurvey event,
    PresentingSurveyState currentState,
  ) {
    _addResult(event.questionResult);

    final stepResults = results.map((e) => e).toList();

    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startTime: startDate,
      endTime: DateTime.now(),
      finishReason: FinishReason.discarded,
      results: stepResults,
    );
    onResult(taskResult);
    return SurveyResultState(
      result: taskResult,
      stepResult: currentState.result,
      currentStep: currentState.currentStep,
    );
  }

  //Currently we are only handling one question per step
  SurveyState _handleSurveyFinished(PresentingSurveyState currentState) {
    final stepResults = results.map((e) => e).toList();
    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startTime: startDate,
      endTime: DateTime.now(),
      finishReason: FinishReason.completed,
      results: stepResults,
    );

    onResult(taskResult);
    return SurveyResultState(
      result: taskResult,
      currentStep: currentState.currentStep,
      stepResult: currentState.result,
    );
  }

  void _addResult(StepResult? questionResult) {
    if (questionResult == null) {
      return;
    }
    results
      ..removeWhere((StepResult result) => result.id == questionResult.id)
      ..add(
        questionResult,
      );
  }

  int get countSteps => taskNavigator.countSteps;
  int currentStepIndex(Step step) {
    return taskNavigator.currentStepIndex(step);
  }

  StepResult? getStepResultById(String id) {
    return results.firstWhereOrNull((element) => element.id == id);
  }
}
