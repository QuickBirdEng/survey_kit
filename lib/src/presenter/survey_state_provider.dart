import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/survey_kit.dart';

/// StatefulWidget that manages the survey state
class SurveyStateProviderWidget extends StatefulWidget {
  const SurveyStateProviderWidget({
    super.key,
    required this.taskNavigator,
    required this.onResult,
    required this.child,
    required this.navigatorKey,
    this.stepShell,
  });

  final TaskNavigator taskNavigator;
  final Function(SurveyResult) onResult;
  final StepShell? stepShell;
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  @override
  State<SurveyStateProviderWidget> createState() =>
      _SurveyStateProviderWidgetState();
}

class _SurveyStateProviderWidgetState extends State<SurveyStateProviderWidget> {
  late SurveyState _state;
  late StreamController<SurveyState> _surveyStateStream;
  late Set<StepResult> _results;
  late DateTime _startDate;

  @override
  void initState() {
    super.initState();
    _state = LoadingSurveyState();
    _surveyStateStream = StreamController<SurveyState>.broadcast();
    _results = {};
    _startDate = DateTime.now();
  }

  @override
  void dispose() {
    _surveyStateStream.close();
    super.dispose();
  }

  void _updateState(SurveyState newState) {
    setState(() {
      _state = newState;
    });
    _surveyStateStream.add(_state);
  }

  void onEvent(SurveyEvent event) {
    if (event is StartSurvey) {
      final newState = _handleInitialStep();
      _updateState(newState);
      widget.navigatorKey.currentState?.pushNamed(
        '/',
        arguments: newState,
      );
    } else if (event is NextStep) {
      if (_state is PresentingSurveyState) {
        final newState =
            _handleNextStep(event, _state as PresentingSurveyState);
        _updateState(newState);
        widget.navigatorKey.currentState?.pushNamed(
          '/',
          arguments: newState,
        );
      }
    } else if (event is StepBack) {
      if (_state is PresentingSurveyState) {
        final newState =
            _handleStepBack(event, _state as PresentingSurveyState);
        _updateState(newState);
        widget.navigatorKey.currentState?.pop();
      }
    } else if (event is CloseSurvey) {
      if (_state is PresentingSurveyState) {
        final newState = _handleClose(event, _state as PresentingSurveyState);
        _updateState(newState);
        widget.navigatorKey.currentState?.pop();
      }
    }
  }

  SurveyState _handleInitialStep() {
    final step = widget.taskNavigator.firstStep();
    if (step != null) {
      return PresentingSurveyState(
        currentStep: step,
        questionResults: _results,
        steps: widget.taskNavigator.task.steps,
        result: null,
        currentStepIndex: _currentStepIndex(step),
        stepCount: _countSteps,
      );
    }

    //If not steps are provided we finish the survey
    final taskResult = SurveyResult(
      id: widget.taskNavigator.task.id,
      startTime: _startDate,
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
    final nextStep = widget.taskNavigator.nextStep(
      step: currentState.currentStep,
      previousResults: _results.toList(),
      questionResult: event.questionResult,
    );

    if (nextStep == null) {
      return _handleSurveyFinished(currentState);
    }

    final questionResult = _getResultByStepIdentifier(nextStep.id);

    return PresentingSurveyState(
      currentStep: nextStep,
      result: questionResult,
      steps: widget.taskNavigator.task.steps,
      questionResults: _results,
      currentStepIndex: _currentStepIndex(nextStep),
      stepCount: _countSteps,
    );
  }

  SurveyState _handleStepBack(
    StepBack event,
    PresentingSurveyState currentState,
  ) {
    _addResult(event.questionResult);
    final previousStep =
        widget.taskNavigator.previousInList(currentState.currentStep);

    //If theres no previous step we can't go back further

    if (previousStep != null) {
      final questionResult = _getResultByStepIdentifier(previousStep.id);

      return PresentingSurveyState(
        currentStep: previousStep,
        result: questionResult,
        steps: widget.taskNavigator.task.steps,
        questionResults: _results,
        currentStepIndex: _currentStepIndex(previousStep),
        isPreviousStep: true,
        stepCount: _countSteps,
      );
    }

    return _state;
  }

  StepResult? _getResultByStepIdentifier(String? identifier) {
    return _results.firstWhereOrNull(
      (element) => element.id == identifier,
    );
  }

  SurveyState _handleClose(
    CloseSurvey event,
    PresentingSurveyState currentState,
  ) {
    _addResult(event.questionResult);

    final stepResults = _results.map((e) => e).toList();

    final taskResult = SurveyResult(
      id: widget.taskNavigator.task.id,
      startTime: _startDate,
      endTime: DateTime.now(),
      finishReason: FinishReason.discarded,
      results: stepResults,
    );
    widget.onResult(taskResult);
    return SurveyResultState(
      result: taskResult,
      stepResult: currentState.result,
      currentStep: currentState.currentStep,
    );
  }

  //Currently we are only handling one question per step
  SurveyState _handleSurveyFinished(PresentingSurveyState currentState) {
    final stepResults = _results.map((e) => e).toList();
    final taskResult = SurveyResult(
      id: widget.taskNavigator.task.id,
      startTime: _startDate,
      endTime: DateTime.now(),
      finishReason: FinishReason.completed,
      results: stepResults,
    );

    widget.onResult(taskResult);
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
    _results
      ..removeWhere((StepResult result) => result.id == questionResult.id)
      ..add(
        questionResult,
      );
  }

  int get _countSteps => widget.taskNavigator.countSteps;

  int _currentStepIndex(Step step) {
    return widget.taskNavigator.currentStepIndex(step);
  }

  StepResult? getStepResultById(String id) {
    return _results.firstWhereOrNull((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return SurveyStateProvider(
      state: _state,
      results: _results,
      startDate: _startDate,
      surveyStateStream: _surveyStateStream,
      taskNavigator: widget.taskNavigator,
      onResult: widget.onResult,
      stepShell: widget.stepShell,
      navigatorKey: widget.navigatorKey,
      onEvent: onEvent,
      getStepResultById: getStepResultById,
      child: widget.child,
    );
  }
}

/// InheritedWidget that provides survey state to descendants (immutable)
class SurveyStateProvider extends InheritedWidget {
  const SurveyStateProvider({
    super.key,
    required this.state,
    required this.results,
    required this.startDate,
    required this.surveyStateStream,
    required this.taskNavigator,
    required this.onResult,
    required this.navigatorKey,
    required this.onEvent,
    required this.getStepResultById,
    required super.child,
    this.stepShell,
  });

  final SurveyState state;
  final Set<StepResult> results;
  final DateTime startDate;
  final StreamController<SurveyState> surveyStateStream;
  final TaskNavigator taskNavigator;
  final Function(SurveyResult) onResult;
  final StepShell? stepShell;
  final GlobalKey<NavigatorState> navigatorKey;
  final void Function(SurveyEvent) onEvent;
  final StepResult? Function(String) getStepResultById;

  static SurveyStateProvider of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SurveyStateProvider>();
    assert(result != null, 'No SurveyStateProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SurveyStateProvider oldWidget) =>
      state != oldWidget.state || results != oldWidget.results;

  int get countSteps => taskNavigator.countSteps;

  int currentStepIndex(Step step) {
    return taskNavigator.currentStepIndex(step);
  }
}
