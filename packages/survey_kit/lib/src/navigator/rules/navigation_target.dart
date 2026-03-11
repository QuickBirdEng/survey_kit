/// The return type of [ConditionalNavigationRule.resultToStepIdentifierMapper].
///
/// Use one of the three subtypes to control what happens after a step:
/// - [NavigateToStep] — jump to a specific step by ID
/// - [NavigateToNextInList] — proceed sequentially to the next step
/// - [FinishSurvey] — end the survey immediately (with [FinishReason.completed])
sealed class NavigationTarget {
  const NavigationTarget();
}

/// Navigate to the step with [stepId].
final class NavigateToStep extends NavigationTarget {
  final String stepId;
  const NavigateToStep(this.stepId);
}

/// Proceed to the next step in the list (sequential fallthrough).
final class NavigateToNextInList extends NavigationTarget {
  const NavigateToNextInList();
}

/// End the survey immediately.
///
/// The survey completes with [FinishReason.completed].
/// In JSON `values` maps, use [FinishSurvey.jsonValue] as the target value.
final class FinishSurvey extends NavigationTarget {
  /// Sentinel used in JSON `values` maps to represent survey completion.
  static const String jsonValue = '__finish__';

  const FinishSurvey();
}
