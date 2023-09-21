import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:provider/provider.dart';
import 'package:survey_kit/survey_kit.dart';

// ignore: must_be_immutable
class SurveyStateProvider extends ChangeNotifier {
  SurveyStateProvider({
    required this.taskNavigator,
    required this.onResult,
    required this.navigatorKey,
    this.stepShell,
  }) : startDate = DateTime.now();

  final TaskNavigator taskNavigator;
  final Function(SurveyResult) onResult;
  final StepShell? stepShell;
  final GlobalKey<NavigatorState> navigatorKey;

  SurveyState? _state;
  SurveyState? get state => _state;
  void updateState(SurveyState newState) {
    _state = newState;
    notifyListeners();
  }

  static SurveyState? of(BuildContext context) {
    return Provider.of<SurveyStateProvider>(context, listen: false).state;
  }

  Set<StepResult> results = {};
  late final DateTime startDate;

  void onEvent(SurveyEvent event) {
    if (event is StartSurvey) {
      final newState = _handleInitialStep();
      updateState(newState);

      return;
    }
    if (state != null) {
      if (event is NextStep) {
        final newState = _handleNextStep(event, state!);
        updateState(newState);
        navigatorKey.currentState?.pushNamed(
          '/${newState.currentStep?.id}',
          arguments: newState,
        );
        return;
      } else if (event is StepBack) {
        final newState = handleStepBack(event, state!);
        updateState(newState);
        navigatorKey.currentState?.pop();
        return;
      } else if (event is CloseSurvey) {
        final newState = _handleClose(event, state!);
        updateState(newState);
        navigatorKey.currentState?.pop();
        return;
      }
    }
  }

  SurveyState _handleInitialStep() {
    final step = taskNavigator.firstStep();
    assert(step != null, 'No steps provided');
    if (step != null) {
      return SurveyState(
        currentStep: step,
        questionResults: results,
        steps: taskNavigator.task.steps,
        result: null,
        currentStepIndex: currentStepIndex(step),
        stepCount: countSteps,
      );
    }

    throw Exception('No steps provided');
  }

  SurveyState _handleNextStep(
    NextStep event,
    SurveyState currentState,
  ) {
    _addResult(event.questionResult);
    final nextStep = taskNavigator.nextStep(
      step: currentState.currentStep!,
      previousResults: results.toList(),
      questionResult: event.questionResult,
    );

    if (nextStep == null) {
      return _handleSurveyFinished(currentState);
    }

    final questionResult = _getResultByStepIdentifier(nextStep.id);

    return SurveyState(
      currentStep: nextStep,
      result: questionResult,
      steps: taskNavigator.task.steps,
      questionResults: results,
      currentStepIndex: currentStepIndex(nextStep),
      stepCount: countSteps,
    );
  }

  SurveyState handleStepBack(
    StepBack event,
    SurveyState currentState,
  ) {
    _addResult(event.questionResult);
    final previousStep =
        taskNavigator.previousInList(currentState.currentStep!);

    //If theres no previous step we can't go back further

    if (previousStep != null) {
      final questionResult = _getResultByStepIdentifier(previousStep.id);

      return state!.copyWith(
        currentStep: previousStep,
        result: questionResult,
        steps: taskNavigator.task.steps,
        questionResults: results,
        currentStepIndex: currentStepIndex(previousStep),
        stepCount: countSteps,
      );
    }

    return state!;
  }

  StepResult? _getResultByStepIdentifier(String? identifier) {
    return results.firstWhereOrNull(
      (element) => element.id == identifier,
    );
  }

  SurveyState _handleClose(
    CloseSurvey event,
    SurveyState currentState,
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
    return state!.copyWith(surveyResult: taskResult);
  }

  //Currently we are only handling one question per step
  SurveyState _handleSurveyFinished(SurveyState currentState) {
    final stepResults = results.map((e) => e).toList();
    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startTime: startDate,
      endTime: DateTime.now(),
      finishReason: FinishReason.completed,
      results: stepResults,
    );

    onResult(taskResult);
    return state!.copyWith(
      surveyResult: taskResult,
      currentStep: currentState.currentStep,
      result: currentState.result,
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

extension SurveyStateExt on BuildContext {
  SurveyStateProvider get surveyStateProvider =>
      Provider.of<SurveyStateProvider>(this, listen: false);
}
