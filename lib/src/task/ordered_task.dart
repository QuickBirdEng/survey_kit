import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/task/task.dart';
import 'package:survey_kit/src/task/identifier/task_identifier.dart';

class OrderedTask extends Task {
  OrderedTask({
    required TaskIdentifier id,
    required List<Step> steps,
  }) : super(id: id, steps: steps);

  factory OrderedTask.fromJson(Map<String, dynamic> json) => OrderedTask(
        id: TaskIdentifier.fromJson(json),
        steps: (json['steps'] as List<Map<String, dynamic>>)
            .map((step) => Step.fromJson(step))
            .toList(),
      );
}
