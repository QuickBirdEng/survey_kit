import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/task/identifier/task_identifier.dart';
import 'package:survey_kit/src/task/task_not_defined_exception.dart';
import 'package:survey_kit/survey_kit.dart';

/// Abstract definition of survey task
///
/// If you want to create a custom task:
///  * Inherit from Task
///  * If you want to use JSON override [fromJson] and add your type
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

  /// Creates a task from a Map. The task needs to have a type definition of
  /// either 'ordered' - [OrderedTask] or 'navigable' - [NavigableTask].
  /// If not it will throw a [TaskNotDefinedException].
  factory Task.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type == 'ordered') {
      return OrderedTask.fromJson(json);
    } else if (type == 'navigable') {
      return NavigableTask.fromJson(json);
    }
    throw TaskNotDefinedException();
  }

  Map<String, dynamic> toJson();
}
