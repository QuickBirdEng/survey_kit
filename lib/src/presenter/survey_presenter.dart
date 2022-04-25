import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_kit/src/configuration/app_bar_configuration.dart';
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
  final Function(SurveyResult) onResult;

  Set<QuestionResult> results = {};
  late final DateTime startDate;

  SurveyPresenter({
    required this.taskNavigator,
    required this.onResult,
  }) : super(LoadingSurveyState()) {

    on<StartSurvey>((event, emit){
      emit(
        _handleInitialStep()
      );
    });

    on<NextStep>((event, emit){
      if (state is PresentingSurveyState){
        emit(_handleNextStep(event, state as PresentingSurveyState));
      }
    });

    on<StepBack>((event, emit){
      if (state is PresentingSurveyState){
        emit(
          _handleStepBack(event, state as PresentingSurveyState)
        );
      }
    });

    on<CloseSurvey>((event, emit){
      if (state is PresentingSurveyState){
        emit(
          _handleClose(event, state as PresentingSurveyState)
        );
      }
    });

    this.startDate = DateTime.now();
    add(StartSurvey());
  }


  SurveyState _handleInitialStep() {
    Step? step = taskNavigator.firstStep();
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
      results: [],
    );
    return SurveyResultState(
      result: taskResult,
      currentStep: null,
    );
  }

  SurveyState _handleNextStep(
      NextStep event, PresentingSurveyState currentState) {
    _addResult(event.questionResult);
    final Step? nextStep = taskNavigator.nextStep(
        step: currentState.currentStep, questionResult: event.questionResult);

    if (nextStep == null) {
      return _handleSurveyFinished(currentState);
    }

    QuestionResult? questionResult =
        _getResultByStepIdentifier(nextStep.stepIdentifier);

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
      StepBack event, PresentingSurveyState currentState) {
    _addResult(event.questionResult);
    final Step? previousStep =
        taskNavigator.previousInList(currentState.currentStep);

    if (previousStep != null) {
      QuestionResult? questionResult =
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
      CloseSurvey event, PresentingSurveyState currentState) {
    _addResult(event.questionResult);

    List<StepResult> stepResults =
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
    List<StepResult> stepResults =
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
