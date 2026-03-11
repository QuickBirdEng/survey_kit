import 'package:survey_kit/src/configuration/survey_kit_registry.dart';

/// Base class for SurveyKit plugins. A plugin registers custom
/// [AnswerViewBuilder]s and [ContentWidgetBuilder]s that extend the survey's
/// built-in rendering capabilities. Pass plugin instances to
/// [SurveyKit.registries].
abstract class SurveyKitPlugin {
  /// Returns a map of [AnswerFormat] type → widget builder for this plugin's
  /// custom answer formats.
  Map<Type, AnswerViewBuilder> get answerViewBuilders => {};

  /// Returns a map of [Content] type → widget builder for this plugin's custom
  /// content types.
  Map<Type, ContentWidgetBuilder> get contentWidgetBuilders => {};
}
