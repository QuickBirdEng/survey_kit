import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/configuration/app_bar_configuration.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/result/step_result.dart';
import 'package:survey_kit/src/result/survey/survey_result.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/steps/step.dart';

class SurveyPresenterInherited extends InheritedWidget {
  SurveyPresenterInherited({
    super.key,
    required this.taskNavigator,
    required this.onResult,
    required super.child,
  })  : _state = LoadingSurveyState(),
        startDate = DateTime.now() {
    //TODO: Do somewhere else
    onEvent(StartSurvey());
  }

  final TaskNavigator taskNavigator;
  final Function(SurveyResult) onResult;

  late SurveyState _state;
  SurveyState get state => _state;
  void updateState(SurveyState newState) {
    _state = newState;
    surveyStateStream.add(_state);
  }

  late StreamController<SurveyState> surveyStateStream =
      StreamController<SurveyState>();

  static SurveyPresenterInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SurveyPresenterInherited>();
    assert(result != null, 'No SurveyPresenterInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SurveyPresenterInherited oldWidget) =>
      taskNavigator != oldWidget.taskNavigator ||
      onResult != oldWidget.onResult ||
      _state != oldWidget._state;

  Set<QuestionResult> results = {};
  late final DateTime startDate;

  void onEvent(SurveyEvent event) {
    if (event is StartSurvey) {
      updateState(_handleInitialStep());
    } else if (event is NextStep) {
      if (state is PresentingSurveyState) {
        updateState(_handleNextStep(event, state as PresentingSurveyState));
      }
    } else if (event is StepBack) {
      if (state is PresentingSurveyState) {
        updateState(_handleStepBack(event, state as PresentingSurveyState));
      }
    } else if (event is CloseSurvey) {
      if (state is PresentingSurveyState) {
        updateState(_handleClose(event, state as PresentingSurveyState));
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
        appBarConfiguration: AppBarConfiguration(
          showProgress: step.showProgress,
          canBack: step.canGoBack,
        ),
      );
    }

    //If not steps are provided we finish the survey
    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startDate: startDate,
      endDate: DateTime.now(),
      finishReason: FinishReason.COMPLETED,
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
      questionResult: event.questionResult,
    );

    if (nextStep == null) {
      return _handleSurveyFinished(currentState);
    }

    final questionResult = _getResultByStepIdentifier(nextStep.stepIdentifier);

    return PresentingSurveyState(
      currentStep: nextStep,
      result: questionResult,
      steps: taskNavigator.task.steps,
      questionResults: results,
      currentStepIndex: currentStepIndex(nextStep),
      stepCount: countSteps,
      appBarConfiguration: AppBarConfiguration(
        showProgress: nextStep.showProgress,
        canBack: nextStep.canGoBack,
      ),
    );
  }

  SurveyState _handleStepBack(
    StepBack event,
    PresentingSurveyState currentState,
  ) {
    _addResult(event.questionResult);
    final previousStep = taskNavigator.previousInList(currentState.currentStep);

    if (previousStep != null) {
      final questionResult =
          _getResultByStepIdentifier(previousStep.stepIdentifier);

      return PresentingSurveyState(
        currentStep: previousStep,
        result: questionResult,
        steps: taskNavigator.task.steps,
        questionResults: results,
        currentStepIndex: currentStepIndex(previousStep),
        appBarConfiguration: AppBarConfiguration(
          showProgress: previousStep.showProgress,
          canBack: previousStep.canGoBack,
        ),
        isPreviousStep: true,
        stepCount: countSteps,
      );
    }

    //If theres no previous step we can't go back further
    return state;
  }

  QuestionResult? _getResultByStepIdentifier(StepIdentifier? identifier) {
    return results.firstWhereOrNull(
      (element) => element.id == identifier,
    );
  }

  SurveyState _handleClose(
    CloseSurvey event,
    PresentingSurveyState currentState,
  ) {
    _addResult(event.questionResult);

    final stepResults =
        results.map((e) => StepResult.fromQuestion(questionResult: e)).toList();

    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startDate: startDate,
      endDate: DateTime.now(),
      finishReason: FinishReason.DISCARDED,
      results: stepResults,
    );
    return SurveyResultState(
      result: taskResult,
      stepResult: currentState.result,
      currentStep: currentState.currentStep,
    );
  }

  //Currently we are only handling one question per step
  SurveyState _handleSurveyFinished(PresentingSurveyState currentState) {
    final stepResults =
        results.map((e) => StepResult.fromQuestion(questionResult: e)).toList();
    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startDate: startDate,
      endDate: DateTime.now(),
      finishReason: FinishReason.COMPLETED,
      results: stepResults,
    );
    return SurveyResultState(
      result: taskResult,
      currentStep: currentState.currentStep,
      stepResult: currentState.result,
    );
  }

  void _addResult(QuestionResult? questionResult) {
    if (questionResult == null) {
      return;
    }
    results
        .removeWhere((QuestionResult result) => result.id == questionResult.id);
    results.add(
      questionResult,
    );
  }

  int get countSteps => taskNavigator.countSteps;
  int currentStepIndex(Step step) {
    return taskNavigator.currentStepIndex(step);
  }
}
