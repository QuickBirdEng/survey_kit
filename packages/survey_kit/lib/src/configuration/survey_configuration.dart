import 'package:flutter/foundation.dart' show mapEquals;
import 'package:flutter/material.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/widget/survey_progress_configuration.dart';

/// An [InheritedWidget] that propagates survey-level configuration down the
/// widget tree. Access with [SurveyConfiguration.of(context)].
class SurveyConfiguration extends InheritedWidget {
  const SurveyConfiguration({
    super.key,
    required this.surveyProgressConfiguration,
    required this.taskNavigator,
    required this.surveyController,
    required this.localizations,
    required this.padding,
    required super.child,
  });

  /// Configuration for the progress bar appearance.
  final SurveyProgressConfiguration surveyProgressConfiguration;

  /// The navigator managing step transitions.
  final TaskNavigator taskNavigator;

  /// The controller for programmatic navigation.
  final SurveyController surveyController;

  /// Optional map of localization key overrides.
  final Map<String, String>? localizations;

  /// Padding applied around step content.
  final EdgeInsets padding;

  /// Returns the nearest [SurveyConfiguration] ancestor. Asserts if none is
  /// found.
  static SurveyConfiguration of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SurveyConfiguration>();
    assert(result != null, 'No SurveyConfiguration found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SurveyConfiguration oldWidget) =>
      surveyProgressConfiguration != oldWidget.surveyProgressConfiguration ||
      taskNavigator != oldWidget.taskNavigator ||
      surveyController != oldWidget.surveyController ||
      !mapEquals(localizations, oldWidget.localizations) ||
      padding != oldWidget.padding;
}
