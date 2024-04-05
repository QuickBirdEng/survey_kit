import 'package:flutter/foundation.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/result/survey_result.dart';
import 'package:survey_kit/src/model/step.dart';

@immutable
abstract class SurveyState {
  const SurveyState();
}

class LoadingSurveyState extends SurveyState {}

class PresentingSurveyState extends SurveyState {
  final List<Step> steps;
  final Set<StepResult> questionResults;
  final Step currentStep;
  final StepResult? result;
  final int currentStepIndex;
  final int stepCount;
  final bool isPreviousStep;

  const PresentingSurveyState({
    required this.stepCount,
    required this.currentStep,
    required this.steps,
    required this.questionResults,
    this.result,
    this.currentStepIndex = 0,
    this.isPreviousStep = false,
  });

  @override
  bool operator ==(Object other) =>
      other is PresentingSurveyState &&
      other.stepCount == stepCount &&
      other.currentStep == currentStep &&
      other.steps == steps &&
      other.questionResults == questionResults &&
      other.result == result &&
      other.currentStepIndex == currentStepIndex &&
      other.isPreviousStep == isPreviousStep;
  @override
  int get hashCode =>
      stepCount.hashCode ^
      currentStep.hashCode ^
      steps.hashCode ^
      questionResults.hashCode ^
      result.hashCode ^
      currentStepIndex.hashCode ^
      isPreviousStep.hashCode;

  bool get isFirstStep => currentStepIndex == 0;
  double get progress => currentStepIndex / stepCount;
}

class SurveyResultState extends SurveyState {
  final SurveyResult result;
  final Step? currentStep;
  final StepResult? stepResult;

  const SurveyResultState({
    required this.result,
    this.stepResult,
    required this.currentStep,
  });
}
