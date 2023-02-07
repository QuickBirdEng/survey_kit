import 'package:survey_kit/src/model/result/step_result.dart';

abstract class SurveyEvent {
  const SurveyEvent();
}

class StartSurvey extends SurveyEvent {}

class NextStep extends SurveyEvent {
  final StepResult? questionResult;

  NextStep(this.questionResult);
}

class StepBack extends SurveyEvent {
  final StepResult? questionResult;

  StepBack(this.questionResult);
}

class CloseSurvey extends SurveyEvent {
  final StepResult? questionResult;

  CloseSurvey(this.questionResult);
}
