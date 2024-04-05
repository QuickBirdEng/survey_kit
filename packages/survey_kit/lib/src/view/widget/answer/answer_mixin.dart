import 'package:flutter/material.dart';
import 'package:survey_kit/src/view/widget/question_answer.dart';

mixin AnswerMixin<T extends StatefulWidget, R> on State<T> {
  void onChange(R? result) {
    onValidationChanged = isValid(result);
    onStepResultChanged = result;
  }

  bool isValid(R? result);

  set onValidationChanged(bool isValid) {
    QuestionAnswer.of(context).setIsValid(isValid);
  }

  set onStepResultChanged(R? stepResult) {
    QuestionAnswer.of(context).setStepResult(stepResult);
  }
}
