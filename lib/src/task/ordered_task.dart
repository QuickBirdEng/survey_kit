import 'package:flutter/widgets.dart';
import 'package:surveykit/src/steps/step.dart';
import 'package:surveykit/src/task/task.dart';
import 'package:surveykit/src/task/identifier/task_identifier.dart';

class OrderedTask extends Task {
  OrderedTask({
    @required TaskIdentifier id,
    @required List<Step> steps,
  }) : super(id: id, steps: steps);
}
