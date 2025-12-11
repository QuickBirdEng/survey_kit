import 'package:survey_kit/src/configuration/survey_kit_registry.dart';

abstract class SurveyKitPlugin {
  Map<Type, AnswerViewBuilder> get answerViewBuilders => {};
  Map<Type, ContentWidgetBuilder> get contentWidgetBuilders => {};
}
