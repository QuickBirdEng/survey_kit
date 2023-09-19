import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/result/survey_result.dart';
import 'package:survey_kit/src/model/step.dart';

@immutable
class SurveyState {
  final List<Step> steps;
  final Set<StepResult> questionResults;
  final Step? currentStep;
  final StepResult? result;
  final int currentStepIndex;
  final int stepCount;
  final bool isPreviousStep;
  final SurveyResult? surveyResult;
  final bool isLoading;

  const SurveyState({
    required this.stepCount,
    required this.currentStep,
    required this.steps,
    required this.questionResults,
    this.result,
    this.currentStepIndex = 0,
    this.isPreviousStep = false,
    this.surveyResult,
    this.isLoading = false,
  });

  @override
  bool operator ==(Object other) =>
      other is SurveyState &&
      other.stepCount == stepCount &&
      other.currentStep == currentStep &&
      other.steps == steps &&
      other.questionResults == questionResults &&
      other.result == result &&
      other.currentStepIndex == currentStepIndex &&
      other.isPreviousStep == isPreviousStep &&
      other.surveyResult == surveyResult &&
      other.isLoading == isLoading;
  @override
  int get hashCode =>
      stepCount.hashCode ^
      currentStep.hashCode ^
      steps.hashCode ^
      questionResults.hashCode ^
      result.hashCode ^
      currentStepIndex.hashCode ^
      isPreviousStep.hashCode ^
      surveyResult.hashCode ^
      isLoading.hashCode;

  SurveyState copyWith({
    int? stepCount,
    Step? currentStep,
    List<Step>? steps,
    Set<StepResult>? questionResults,
    StepResult? result,
    int? currentStepIndex,
    bool? isPreviousStep,
    SurveyResult? surveyResult,
    bool? isLoading,
  }) =>
      SurveyState(
        stepCount: stepCount ?? this.stepCount,
        currentStep: currentStep ?? this.currentStep,
        steps: steps ?? this.steps,
        questionResults: questionResults ?? this.questionResults,
        result: result ?? this.result,
        currentStepIndex: currentStepIndex ?? this.currentStepIndex,
        isPreviousStep: isPreviousStep ?? this.isPreviousStep,
        surveyResult: surveyResult ?? this.surveyResult,
        isLoading: isLoading ?? this.isLoading,
      );

  bool get isFirstStep => currentStepIndex == 0;
  double get progress => currentStepIndex / stepCount;
}
