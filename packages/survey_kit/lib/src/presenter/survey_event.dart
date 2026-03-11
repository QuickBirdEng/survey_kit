import 'package:survey_kit/src/model/result/step_result.dart';

/// Base class for all events dispatched to [SurveyStateProvider.onEvent].
abstract class SurveyEvent {
  const SurveyEvent();
}

/// Starts the survey and transitions from [LoadingSurveyState] to
/// [PresentingSurveyState].
class StartSurvey extends SurveyEvent {}

/// Advances the survey to the next step, recording [questionResult] for the
/// current step.
class NextStep extends SurveyEvent {
  /// The result collected on the current step. May be null for display-only steps.
  final StepResult? questionResult;

  NextStep(this.questionResult);
}

/// Returns to the previous step, recording [questionResult] for the current step.
class StepBack extends SurveyEvent {
  /// The result collected on the current step before going back.
  final StepResult? questionResult;

  StepBack(this.questionResult);
}

/// Closes the survey with [FinishReason.discarded], recording [questionResult]
/// for the current step.
class CloseSurvey extends SurveyEvent {
  /// The result collected on the current step before closing.
  final StepResult? questionResult;

  CloseSurvey(this.questionResult);
}
