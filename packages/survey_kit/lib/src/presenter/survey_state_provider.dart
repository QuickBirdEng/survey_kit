import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/survey_kit.dart';

/// A [StatefulWidget] that manages the mutable state for the survey.
///
/// This widget holds the survey's state, results, and handles all state transitions
/// through the [onEvent] method. It creates an immutable [SurveyStateProvider]
/// on each rebuild to expose the state to descendant widgets.
///
/// This follows the recommended Flutter pattern of separating mutable state
/// (StatefulWidget) from the immutable state exposure (InheritedWidget).
class SurveyStateProviderWidget extends StatefulWidget {
  /// Creates a [SurveyStateProviderWidget].
  ///
  /// All parameters are required except [stepShell].
  const SurveyStateProviderWidget({
    super.key,
    required this.taskNavigator,
    required this.onResult,
    required this.child,
    required this.navigatorKey,
    this.stepShell,
  });

  /// The navigator that manages the task flow and step transitions.
  final TaskNavigator taskNavigator;

  /// Callback invoked when the survey is completed or closed.
  final void Function(SurveyResult) onResult;

  /// Optional custom shell widget builder for wrapping steps.
  final StepShell? stepShell;

  /// Global key for managing the Navigator state.
  final GlobalKey<NavigatorState> navigatorKey;

  /// The widget below this widget in the tree.
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
  bool _isStepBackPending = false;
  final List<String> _steppedBackFromIds = [];

  @override
  void initState() {
    super.initState();
    _state = const LoadingSurveyState();
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
    if (!_surveyStateStream.isClosed) {
      _surveyStateStream.add(_state);
    }
  }

  /// Handles survey events and triggers appropriate state transitions.
  ///
  /// Supported events:
  /// - [StartSurvey]: Initializes the survey with the first step
  /// - [NextStep]: Advances to the next step
  /// - [StepBack]: Returns to the previous step
  /// - [CloseSurvey]: Closes the survey and reports results
  void onEvent(SurveyEvent event) {
    if (event is StartSurvey) {
      final newState = _handleInitialStep();
      _updateState(newState);
      if (newState is SurveyResultState) {
        widget.onResult(newState.result);
      }
    } else if (event is NextStep) {
      if (_state is PresentingSurveyState && !_isStepBackPending) {
        final currentState = _state as PresentingSurveyState;
        final newState = _handleNextStep(event, currentState);
        if (newState is PresentingSurveyState) {
          widget.navigatorKey.currentState?.pushNamed('/', arguments: newState);
        }
        _updateState(newState);
      }
    } else if (event is StepBack) {
      if (_state is PresentingSurveyState && !_isStepBackPending) {
        final currentState = _state as PresentingSurveyState;
        final newState = _handleStepBack(event, currentState);

        if (newState is PresentingSurveyState &&
            newState.currentStep.id != currentState.currentStep.id) {
          _isStepBackPending = true;
          (widget.navigatorKey.currentState?.maybePop() ??
                  Future<bool>.value(false))
              .whenComplete(() {
                _isStepBackPending = false;
                if (!mounted || !identical(_state, currentState)) {
                  return;
                }
                _updateState(newState);
              });
          return;
        }
        _updateState(newState);
      }
    } else if (event is CloseSurvey) {
      if (_state is PresentingSurveyState) {
        final newState = _handleClose(event, _state as PresentingSurveyState);
        _updateState(newState);
        widget.navigatorKey.currentState?.maybePop();
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

    // If no steps are provided we finish the survey
    final taskResult = SurveyResult(
      id: widget.taskNavigator.task.id,
      startTime: _startDate,
      endTime: DateTime.now(),
      finishReason: FinishReason.completed,
      results: const [],
    );

    return SurveyResultState(result: taskResult, currentStep: null);
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
    _trackForwardNavigation(nextStep);

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
    final previousStep = widget.taskNavigator.previousInList(
      currentState.currentStep,
    );

    // If there's no previous step we can't go back further
    if (previousStep != null) {
      _steppedBackFromIds.add(currentState.currentStep.id);
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

  void _trackForwardNavigation(Step? nextStep) {
    if (_steppedBackFromIds.isEmpty) {
      return;
    }
    if (nextStep != null && _steppedBackFromIds.last == nextStep.id) {
      _steppedBackFromIds.removeLast();
      return;
    }
    final abandonedIds = _steppedBackFromIds.toSet();
    _results.removeWhere((result) => abandonedIds.contains(result.id));
    _steppedBackFromIds.clear();
  }

  StepResult? _getResultByStepIdentifier(String? identifier) {
    return _results.firstWhereOrNull((element) => element.id == identifier);
  }

  SurveyState _handleClose(
    CloseSurvey event,
    PresentingSurveyState currentState,
  ) {
    _addResult(event.questionResult);
    return _finishSurvey(currentState, FinishReason.discarded);
  }

  SurveyState _handleSurveyFinished(PresentingSurveyState currentState) {
    return _finishSurvey(currentState, FinishReason.completed);
  }

  SurveyResultState _finishSurvey(
    PresentingSurveyState currentState,
    FinishReason finishReason,
  ) {
    final taskResult = SurveyResult(
      id: widget.taskNavigator.task.id,
      startTime: _startDate,
      endTime: DateTime.now(),
      finishReason: finishReason,
      results: _visitedStepResults(currentState.currentStep),
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
      ..add(questionResult);
  }

  List<StepResult> _visitedStepResults(Step currentStep) {
    final orderedIds = <String>{
      ...widget.taskNavigator.visitedStepIds(currentStep: currentStep),
      ..._steppedBackFromIds.reversed,
    };
    final resultsById = {for (final result in _results) result.id: result};
    return [
      for (final id in orderedIds)
        if (resultsById[id] case final result?) result,
    ];
  }

  int get _countSteps => widget.taskNavigator.countSteps;

  int _currentStepIndex(Step step) {
    return widget.taskNavigator.currentStepIndex(step);
  }

  /// Retrieves a step result by its identifier.
  ///
  /// Returns `null` if no result is found with the given [id].
  StepResult? getStepResultById(String id) {
    return _results.firstWhereOrNull((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return SurveyStateProvider(
      state: _state,
      results: UnmodifiableSetView(_results),
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

/// An [InheritedWidget] that provides immutable access to survey state.
///
/// This widget exposes the current survey state, results, and event handling
/// to descendant widgets. It should not be instantiated directly; instead,
/// use [SurveyStateProviderWidget] which manages the mutable state and
/// creates this widget on each rebuild.
///
/// Access this provider using [SurveyStateProvider.of(context)].
class SurveyStateProvider extends InheritedWidget {
  /// Creates a [SurveyStateProvider].
  ///
  /// This constructor should only be called by [SurveyStateProviderWidget].
  const SurveyStateProvider({
    super.key,
    required this.state,
    required this.results,
    required this.startDate,
    required StreamController<SurveyState> surveyStateStream,
    required this.taskNavigator,
    required this.onResult,
    required this.navigatorKey,
    required this.onEvent,
    required this.getStepResultById,
    required super.child,
    this.stepShell,
  }) : _surveyStateStream = surveyStateStream;

  /// The current state of the survey.
  final SurveyState state;

  /// A read-only view of the results collected so far in the survey.
  final Set<StepResult> results;

  /// The date and time when the survey was started.
  final DateTime startDate;

  final StreamController<SurveyState> _surveyStateStream;

  /// Broadcast stream of survey state changes.
  Stream<SurveyState> get stateStream => _surveyStateStream.stream;

  /// The controller backing [stateStream].
  @Deprecated('Use stateStream instead.')
  StreamController<SurveyState> get surveyStateStream => _surveyStateStream;

  /// The navigator that manages the task flow.
  final TaskNavigator taskNavigator;

  /// Callback invoked when the survey is completed or closed.
  final void Function(SurveyResult) onResult;

  /// Optional custom shell widget builder for wrapping steps.
  final StepShell? stepShell;

  /// Global key for managing the Navigator state.
  final GlobalKey<NavigatorState> navigatorKey;

  /// Callback for handling survey events.
  final void Function(SurveyEvent) onEvent;

  /// Function to retrieve a step result by its identifier.
  final StepResult? Function(String) getStepResultById;

  /// Retrieves the [SurveyStateProvider] from the widget tree.
  ///
  /// The [context] must have a [SurveyStateProvider] ancestor.
  /// Throws an assertion error if no provider is found.
  static SurveyStateProvider of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<SurveyStateProvider>();
    assert(result != null, 'No SurveyStateProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SurveyStateProvider oldWidget) =>
      state != oldWidget.state;

  /// Returns the total number of steps in the survey.
  int get countSteps => taskNavigator.countSteps;

  /// Returns the index of the given [step] in the survey.
  int currentStepIndex(Step step) {
    return taskNavigator.currentStepIndex(step);
  }
}
