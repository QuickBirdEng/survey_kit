import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/result/step_result.dart';
import 'package:survey_kit/src/result/survey/survey_result.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';

//TO DO: Extract gathering of the results into another class
class SurveyPresenter extends Bloc<SurveyEvent, SurveyState> {
  final TaskNavigator taskNavigator;
  Set<QuestionResult> results = {};
  DateTime startDate;

  SurveyPresenter({
    @required this.taskNavigator,
  }) : super(LoadingSurveyState()) {
    this.startDate = DateTime.now();
    add(StartSurvey());
  }

  @override
  Stream<SurveyState> mapEventToState(SurveyEvent event) async* {
    final currentState = state;
    if (event is StartSurvey) {
      yield _handleInitialStep();
    }

    if (event is NextStep && currentState is PresentingSurveyState) {
      yield _handleNextStep(event, currentState);
    }

    if (event is StepBack && currentState is PresentingSurveyState) {
      yield _handleStepBack(event, currentState);
    }

    if (event is CloseSurvey && currentState is PresentingSurveyState) {
      yield _handleClose(event, currentState);
    }
  }

  SurveyState _handleInitialStep() {
    return PresentingSurveyState(taskNavigator.firstStep(), null);
  }

  SurveyState _handleNextStep(
      NextStep event, PresentingSurveyState currentState) {
    _addResult(event.questionResult);
    final Step nextStep = taskNavigator.nextStep(
        step: currentState.currentStep, questionResult: event.questionResult);

    if (nextStep == null) {
      return _handleSurveyFinished();
    }

    QuestionResult questionResult = _getResultByStepIdentifier(nextStep.id);

    return PresentingSurveyState(
      nextStep,
      questionResult,
    );
  }

  SurveyState _handleStepBack(
      StepBack event, PresentingSurveyState currentState) {
    _addResult(event.questionResult);
    final Step previousStep =
        taskNavigator.previousInList(currentState.currentStep);

    QuestionResult questionResult = _getResultByStepIdentifier(previousStep.id);

    return PresentingSurveyState(previousStep, questionResult);
  }

  QuestionResult _getResultByStepIdentifier(StepIdentifier identifier) {
    return results.firstWhere(
      (element) => element.id == identifier,
      orElse: () => null,
    );
  }

  SurveyState _handleClose(
      CloseSurvey event, PresentingSurveyState currentState) {
    _addResult(event.questionResult);

    List<StepResult> stepResults =
        results.map((e) => StepResult.fromQuestion(questionResult: e)).toList();

    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startDate: startDate ?? DateTime.now(),
      endDate: DateTime.now(),
      finishReason: FinishReason.DISCARDED,
      results: stepResults,
    );
    return SurveyResultState(result: taskResult);
  }

  //Currently we are only handling one question per step
  SurveyState _handleSurveyFinished() {
    List<StepResult> stepResults =
        results.map((e) => StepResult.fromQuestion(questionResult: e)).toList();
    final taskResult = SurveyResult(
      id: taskNavigator.task.id,
      startDate: startDate ?? DateTime.now(),
      endDate: DateTime.now(),
      finishReason: FinishReason.COMPLETED,
      results: stepResults,
    );
    return SurveyResultState(result: taskResult);
  }

  void _addResult(QuestionResult questionResult) {
    results
        .removeWhere((QuestionResult result) => result.id == questionResult.id);
    results.add(
      questionResult,
    );
  }
}
