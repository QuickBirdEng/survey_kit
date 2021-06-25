import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/task/identifier/task_identifier.dart';
import 'package:survey_kit/src/task/task_not_defined_exception.dart';
import 'package:survey_kit/survey_kit.dart';

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

  factory Task.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type == 'ordered') {
      return OrderedTask.fromJson(json);
    } else if (type == 'navigable') {
      return NavigableTask.fromJson(json);
    }
    throw TaskNotDefinedException();
  }
}
