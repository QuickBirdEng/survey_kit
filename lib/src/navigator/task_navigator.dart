import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:surveykit/src/result/question_result.dart';
import 'package:surveykit/src/steps/step.dart';
import 'package:surveykit/src/task/task.dart';

abstract class TaskNavigator {
  final Task task;
  final ListQueue<Step> history = ListQueue();

  TaskNavigator(this.task);

  Step firstStep();
  Step nextStep({@required Step step, QuestionResult questionResult});
  Step previousInList(Step step);

  Step nextInList(Step step) {
    final currentIndex =
        task.steps.indexWhere((element) => element.id == step.id);
    return (currentIndex + 1 > task.steps.length - 1)
        ? null
        : task.steps[currentIndex + 1];
  }

  Step peekHistory() {
    if (history.isEmpty) {
      return null;
    }
    return history.last;
  }

  bool hasPreviousStep() {
    final step = peekHistory();
    return step != null;
  }

  void record(Step step) {
    history.add(step);
  }
}
