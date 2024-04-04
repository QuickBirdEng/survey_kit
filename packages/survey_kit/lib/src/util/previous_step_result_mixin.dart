import 'package:flutter/material.dart';

import '../model/result/step_result.dart';
import '../presenter/survey_state_provider.dart';

mixin PreviousStepResultMixin<T extends StatefulWidget> on State<T> {
  StepResult? stepResultById(String id) {
    final surveyPresenter = SurveyStateProvider.of(context);
    return surveyPresenter.getStepResultById(id);
  }
}
