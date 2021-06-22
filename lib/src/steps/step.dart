import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';

abstract class Step {
  final StepIdentifier id;
  final bool isOptional;
  final String buttonText;

  Step({StepIdentifier? id, this.isOptional = false, this.buttonText = 'Next'})
      : id = id ?? StepIdentifier();

  Widget createView({required QuestionResult? questionResult});
}
