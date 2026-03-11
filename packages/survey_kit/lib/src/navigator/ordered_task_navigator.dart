import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/task/survey_definition.dart';

/// A [TaskNavigator] that advances steps strictly in list order. Does not
/// evaluate any navigation rules.
class OrderedTaskNavigator extends TaskNavigator {
  OrderedTaskNavigator(SurveyDefinition task) : super(task);

  @override
  Step? nextStep({
    required Step step,
    required List<StepResult> previousResults,
    StepResult? questionResult,
  }) {
    record(step);
    return nextInList(step);
  }

  @override
  Step? previousInList(Step step) {
    final currentIndex =
        task.steps.indexWhere((element) => element.id == step.id);
    return (currentIndex - 1 < 0) ? null : task.steps[currentIndex - 1];
  }

  @override
  Step? firstStep() {
    final previousStep = peekHistory();
    if (previousStep != null) {
      return nextInList(previousStep);
    }
    if (task.initialStep != null) {
      return task.initialStep;
    }
    if (task.steps.isEmpty) {
      return null;
    }
    return task.steps.first;
  }
}
