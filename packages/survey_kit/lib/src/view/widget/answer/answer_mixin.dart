import 'package:flutter/material.dart';
import 'package:survey_kit/src/view/widget/question_answer.dart';

mixin AnswerMixin<T extends StatefulWidget, R> on State<T> {
  void onChange(R? result) {
    onValidationChanged = isValid(result);
    onStepResultChanged = result;
  }

  /// Call in [initState] to sync the initial answer state to [QuestionAnswer].
  /// Uses a post-frame callback so the inherited widget is available.
  void initValidation(R? initialResult) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) onChange(initialResult);
    });
  }

  bool isValid(R? result);

  set onValidationChanged(bool isValid) {
    QuestionAnswer.of(context).onValidityChanged(isValid);
  }

  set onStepResultChanged(R? stepResult) {
    QuestionAnswer.of(context).onResultChanged(stepResult);
  }
}
