import 'dart:collection';

import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/task/survey_definition.dart';

/// Abstract navigator that drives step-by-step progression through a
/// [SurveyDefinition]. Subclasses implement the step resolution logic for
/// ordered and branching flows.
abstract class TaskNavigator {
  /// The survey definition this navigator operates on.
  final SurveyDefinition task;

  /// A stack of steps the user has visited, used to support back-navigation.
  final ListQueue<Step> history = ListQueue();

  TaskNavigator(this.task);

  /// Returns the first step to display, respecting [SurveyDefinition.initialStep]
  /// if set.
  Step? firstStep();

  /// Returns the step to show after [step], given [previousResults] and the
  /// current [questionResult]. Returns null when the survey is finished.
  Step? nextStep({
    required Step step,
    required List<StepResult> previousResults,
    StepResult? questionResult,
  });

  /// Returns the step before [step] for back-navigation purposes.
  Step? previousInList(Step step);

  /// Returns the step immediately after [step] in the ordered list, or null if
  /// [step] is the last.
  Step? nextInList(Step? step) {
    final currentIndex = task.steps.indexWhere(
      (element) => element.id == step?.id,
    );
    return (currentIndex + 1 > task.steps.length - 1)
        ? null
        : task.steps[currentIndex + 1];
  }

  /// Returns the most recently visited step without removing it from history.
  Step? peekHistory() {
    if (history.isEmpty) {
      return null;
    }
    return history.last;
  }

  /// True when there is at least one step in history to go back to.
  bool hasPreviousStep() {
    final step = peekHistory();
    return step != null;
  }

  /// Adds [step] to the navigation history.
  void record(Step step) {
    history.add(step);
  }

  /// Total number of steps in the survey.
  int get countSteps => task.steps.length;

  /// Returns the zero-based index of [step] in the survey's step list.
  int currentStepIndex(Step step) {
    return task.steps.indexOf(step);
  }
}
