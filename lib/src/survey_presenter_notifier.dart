// import 'dart:async';

// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart' hide Step;
// import 'package:survey_kit/src/model/result/step_result.dart';
// import 'package:survey_kit/src/model/result/survey_result.dart';
// import 'package:survey_kit/src/model/step.dart';
// import 'package:survey_kit/src/navigator/task_navigator.dart';
// import 'package:survey_kit/src/presenter/survey_event.dart';
// import 'package:survey_kit/src/presenter/survey_state.dart';

// // ignore: must_be_immutable
// class SurveyPresenterInherited extends ChangeNotifier {
//   SurveyPresenterInherited({
//     required this.taskNavigator,
//     required this.onResult,
//   })  : state = LoadingSurveyState(),
//         startDate = DateTime.now() {
//     onEvent(StartSurvey());
//   }

//   final TaskNavigator taskNavigator;
//   final Function(SurveyResult) onResult;

//   late SurveyState state;

//   late StreamController<SurveyState> surveyStateStream =
//       StreamController<SurveyState>();

//   Set<StepResult> results = {};
//   late final DateTime startDate;

//   void onEvent(SurveyEvent event) {
//     if (event is StartSurvey) {
//       state = _handleInitialStep();
//     } else if (event is NextStep) {
//       if (state is PresentingSurveyState) {
//         state = _handleNextStep(event, state as PresentingSurveyState);
//       }
//     } else if (event is StepBack) {
//       if (state is PresentingSurveyState) {
//         state = _handleStepBack(event, state as PresentingSurveyState);
//       }
//     } else if (event is CloseSurvey) {
//       if (state is PresentingSurveyState) {
//         state = _handleClose(event, state as PresentingSurveyState);
//       }
//     }
//     notifyListeners();
//   }

//   SurveyState _handleInitialStep() {
//     final step = taskNavigator.firstStep();
//     if (step != null) {
//       return PresentingSurveyState(
//         currentStep: step,
//         questionResults: results,
//         steps: taskNavigator.task.steps,
//         result: null,
//         currentStepIndex: currentStepIndex(step),
//         stepCount: countSteps,
//       );
//     }

//     //If not steps are provided we finish the survey
//     final taskResult = SurveyResult(
//       id: taskNavigator.task.id,
//       startTime: startDate,
//       endTime: DateTime.now(),
//       finishReason: FinishReason.completed,
//       results: const [],
//     );
//     return SurveyResultState(
//       result: taskResult,
//       currentStep: null,
//     );
//   }

//   SurveyState _handleNextStep(
//     NextStep event,
//     PresentingSurveyState currentState,
//   ) {
//     _addResult(event.questionResult);
//     final nextStep = taskNavigator.nextStep(
//       step: currentState.currentStep,
//       questionResult: event.questionResult,
//     );

//     if (nextStep == null) {
//       return _handleSurveyFinished(currentState);
//     }

//     final questionResult = _getResultByStepIdentifier(nextStep.id);

//     return PresentingSurveyState(
//       currentStep: nextStep,
//       result: questionResult,
//       steps: taskNavigator.task.steps,
//       questionResults: results,
//       currentStepIndex: currentStepIndex(nextStep),
//       stepCount: countSteps,
//     );
//   }

//   SurveyState _handleStepBack(
//     StepBack event,
//     PresentingSurveyState currentState,
//   ) {
//     _addResult(event.questionResult);
//     final previousStep = taskNavigator.previousInList(currentState.currentStep);

//     if (previousStep != null) {
//       final questionResult = _getResultByStepIdentifier(previousStep.id);

//       return PresentingSurveyState(
//         currentStep: previousStep,
//         result: questionResult,
//         steps: taskNavigator.task.steps,
//         questionResults: results,
//         currentStepIndex: currentStepIndex(previousStep),
//         isPreviousStep: true,
//         stepCount: countSteps,
//       );
//     }

//     //If theres no previous step we can't go back further
//     return state;
//   }

//   StepResult? _getResultByStepIdentifier(String? identifier) {
//     return results.firstWhereOrNull(
//       (element) => element.id == identifier,
//     );
//   }

//   SurveyState _handleClose(
//     CloseSurvey event,
//     PresentingSurveyState currentState,
//   ) {
//     _addResult(event.questionResult);

//     final stepResults = results
//         .map((e) => StepResult<dynamic>.fromQuestion(questionResult: e))
//         .toList();

//     final taskResult = SurveyResult(
//       id: taskNavigator.task.id,
//       startTime: startDate,
//       endTime: DateTime.now(),
//       finishReason: FinishReason.discarded,
//       results: stepResults,
//     );
//     return SurveyResultState(
//       result: taskResult,
//       stepResult: currentState.result,
//       currentStep: currentState.currentStep,
//     );
//   }

//   //Currently we are only handling one question per step
//   SurveyState _handleSurveyFinished(PresentingSurveyState currentState) {
//     final stepResults = results
//         .map((e) => StepResult<dynamic>.fromQuestion(questionResult: e))
//         .toList();
//     final taskResult = SurveyResult(
//       id: taskNavigator.task.id,
//       startTime: startDate,
//       endTime: DateTime.now(),
//       finishReason: FinishReason.completed,
//       results: stepResults,
//     );
//     return SurveyResultState(
//       result: taskResult,
//       currentStep: currentState.currentStep,
//       stepResult: currentState.result,
//     );
//   }

//   void _addResult(StepResult? questionResult) {
//     if (questionResult == null) {
//       return;
//     }
//     results
//       ..removeWhere((StepResult result) => result.id == questionResult.id)
//       ..add(
//         questionResult,
//       );
//   }

//   int get countSteps => taskNavigator.countSteps;
//   int currentStepIndex(Step step) {
//     return taskNavigator.currentStepIndex(step);
//   }
// }
