import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/result/survey/survey_result.dart';
import 'package:survey_kit/src/steps/step.dart';

abstract class SurveyState {
  const SurveyState();
}

class LoadingSurveyState extends SurveyState {}

class PresentingSurveyState extends SurveyState {
  final Step currentStep;
  final QuestionResult? result;
  final int currentStepIndex;
  final int stepCount;

  PresentingSurveyState(
    this.currentStep,
    this.result, {
    this.currentStepIndex = 0,
    required this.stepCount,
  });
}

class SurveyResultState extends SurveyState {
  final SurveyResult result;

  SurveyResultState({required this.result});
}
