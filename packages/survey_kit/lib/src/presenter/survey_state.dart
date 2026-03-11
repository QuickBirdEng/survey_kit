import 'package:flutter/foundation.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/result/survey_result.dart';
import 'package:survey_kit/src/model/step.dart';

/// Base class for all survey states. Observe this via [SurveyStateProvider] to
/// react to survey lifecycle changes.
@immutable
abstract class SurveyState {
  const SurveyState();
}

/// Initial state while the survey is being initialized.
class LoadingSurveyState extends SurveyState {}

/// Active state while a step is being presented to the user.
class PresentingSurveyState extends SurveyState {
  /// All steps in the current survey.
  final List<Step> steps;

  /// Results collected so far, one per answered step.
  final Set<StepResult> questionResults;

  /// The step currently displayed to the user.
  final Step currentStep;

  /// The previously stored result for [currentStep], if the user is revisiting it.
  final StepResult? result;

  /// Zero-based index of [currentStep] in [steps].
  final int currentStepIndex;

  /// Total number of steps in the survey.
  final int stepCount;

  /// True when navigating backwards to this step.
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

  /// True when [currentStepIndex] is 0.
  bool get isFirstStep => currentStepIndex == 0;

  /// Completion fraction in the range [0.0, 1.0].
  double get progress => currentStepIndex / stepCount;
}

/// Terminal state emitted when the survey finishes or is closed. Contains the
/// final [SurveyResult].
class SurveyResultState extends SurveyState {
  /// The aggregated survey result.
  final SurveyResult result;

  /// The last step that was active when the survey ended.
  final Step? currentStep;

  /// The last step result collected before the survey ended.
  final StepResult? stepResult;

  const SurveyResultState({
    required this.result,
    this.stepResult,
    required this.currentStep,
  });
}
