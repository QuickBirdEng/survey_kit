import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:survey_kit/src/view/widget/question_answer.dart';

mixin AnswerMixin<T extends StatefulWidget, R> on State<T> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      onChange(QuestionAnswer.of(context).stepResult?.result as R?);
    });
  }

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
