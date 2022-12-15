import 'package:flutter/material.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/widget/survey_progress_configuration.dart';

class SurveyConfiguration extends InheritedWidget {
  const SurveyConfiguration({
    super.key,
    required this.surveyProgressConfiguration,
    required this.showProgress,
    required this.taskNavigator,
    required this.surveyController,
    required this.localizations,
    required super.child,
  });

  final SurveyProgressConfiguration surveyProgressConfiguration;
  final bool showProgress;
  final TaskNavigator taskNavigator;
  final SurveyController surveyController;
  final Map<String, String>? localizations;

  static SurveyConfiguration of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SurveyConfiguration>();
    assert(result != null, 'No SurveyConfiguration found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SurveyConfiguration old) =>
      surveyProgressConfiguration != old.surveyProgressConfiguration &&
      showProgress != old.showProgress;
}
