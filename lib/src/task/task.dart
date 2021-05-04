import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/task/identifier/task_identifier.dart';

abstract class Task {
  late final TaskIdentifier id;
  final List<Step> steps;

  Task({
    TaskIdentifier? id,
    this.steps = const [],
  }) {
    if (id == null) {
      id = TaskIdentifier();
      return;
    }
    this.id = id;
  }
}
