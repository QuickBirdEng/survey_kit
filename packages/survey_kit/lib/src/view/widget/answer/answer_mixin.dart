import 'package:flutter/material.dart';
import 'package:survey_kit/src/view/widget/question_answer.dart';

/// A [State] mixin for answer view widgets. Connects the answer view to the
/// surrounding [QuestionAnswer] widget. Call [onChange] whenever the user's
/// selection changes. Call [initValidation] in [initState] to sync the initial
/// state.
mixin AnswerMixin<T extends StatefulWidget, R> on State<T> {
  /// Called when the user's answer changes to [result]. Updates the validity
  /// and result in [QuestionAnswer].
  void onChange(R? result) {
    onValidationChanged = isValid(result);
    onStepResultChanged = result;
  }

  /// Syncs the initial [initialResult] to [QuestionAnswer] after the first
  /// frame. Call this in [initState].
  void initValidation(R? initialResult) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) onChange(initialResult);
    });
  }

  /// Returns whether [result] constitutes a valid answer for this format.
  /// Implement this to drive the Next button enabled state.
  bool isValid(R? result);

  set onValidationChanged(bool isValid) {
    QuestionAnswer.of(context).onValidityChanged(isValid);
  }

  set onStepResultChanged(R? stepResult) {
    QuestionAnswer.of(context).onResultChanged(stepResult);
  }
}
