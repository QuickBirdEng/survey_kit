import 'package:flutter/foundation.dart';
import 'package:survey_kit/src/configuration/app_bar_configuration.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/result/survey/survey_result.dart';
import 'package:survey_kit/src/steps/step.dart';

@immutable
abstract class SurveyState {
  const SurveyState();
}

class LoadingSurveyState extends SurveyState {}

class PresentingSurveyState extends SurveyState {
  final AppBarConfiguration appBarConfiguration;
  final List<Step> steps;
  final Set<QuestionResult> questionResults;
  final Step currentStep;
  final QuestionResult? result;
  final int currentStepIndex;
  final int stepCount;
  final bool isPreviousStep;

  const PresentingSurveyState({
    required this.stepCount,
    required this.appBarConfiguration,
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
      other.appBarConfiguration == appBarConfiguration &&
      other.currentStep == currentStep &&
      other.steps == steps &&
      other.questionResults == questionResults &&
      other.result == result &&
      other.currentStepIndex == currentStepIndex &&
      other.isPreviousStep == isPreviousStep;
  @override
  int get hashCode =>
      stepCount.hashCode ^
      appBarConfiguration.hashCode ^
      currentStep.hashCode ^
      steps.hashCode ^
      questionResults.hashCode ^
      result.hashCode ^
      currentStepIndex.hashCode ^
      isPreviousStep.hashCode;
}

class SurveyResultState extends SurveyState {
  final SurveyResult result;
  final Step? currentStep;
  final QuestionResult? stepResult;

  const SurveyResultState({
    required this.result,
    this.stepResult,
    required this.currentStep,
  });
}
