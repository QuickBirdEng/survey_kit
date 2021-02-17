import 'package:flutter/widgets.dart';
import 'package:surveykit/src/result/question_result.dart';
import 'package:surveykit/src/steps/identifier/step_identifier.dart';

abstract class Step {
  StepIdentifier id;
  final bool isOptional;
  final String buttonText;

  Step({StepIdentifier id, this.isOptional = false, this.buttonText = 'Next'}) {
    if (id == null) {
      this.id = StepIdentifier();
      return;
    }
    this.id = id;
  }

  Widget createView({@required QuestionResult questionResult});
}
