import 'package:flutter/widgets.dart';
import 'package:surveykit/src/navigator/task_navigator.dart';
import 'package:surveykit/src/result/question_result.dart';
import 'package:surveykit/src/steps/step.dart';
import 'package:surveykit/src/task/task.dart';

class OrderedTaskNavigator extends TaskNavigator {
  OrderedTaskNavigator(Task task) : super(task);

  @override
  Step nextStep({@required Step step, QuestionResult questionResult}) {
    record(step);
    return nextInList(step);
  }

  @override
  Step previousInList(Step step) {
    final currentIndex =
        task.steps.indexWhere((element) => element.id == step.id);
    return (currentIndex - 1 < 0) ? null : task.steps[currentIndex - 1];
  }

  @override
  Step firstStep() {
    final previousStep = peekHistory();
    return previousStep == null ? task.steps.first : nextInList(previousStep);
  }
}
