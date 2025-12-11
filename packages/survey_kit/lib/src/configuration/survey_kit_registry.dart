import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/content/content.dart';

typedef AnswerViewBuilder = Widget Function(
  AnswerFormat answerFormat,
  Step step,
  StepResult? stepResult,
);

typedef ContentWidgetBuilder = Widget Function(
  Content content,
);

class SurveyKitRegistry extends InheritedWidget {
  final Map<Type, AnswerViewBuilder> _answerViewBuilders = {};
  final Map<Type, ContentWidgetBuilder> _contentWidgetBuilders = {};

  SurveyKitRegistry({
    super.key,
    required super.child,
    Map<Type, AnswerViewBuilder>? initialAnswerViewBuilders,
    Map<Type, ContentWidgetBuilder>? initialContentWidgetBuilders,
  }) {
    if (initialAnswerViewBuilders != null) {
      _answerViewBuilders.addAll(initialAnswerViewBuilders);
    }
    if (initialContentWidgetBuilders != null) {
      _contentWidgetBuilders.addAll(initialContentWidgetBuilders);
    }
  }

  void registerAnswerViewBuilder<T extends AnswerFormat>(
    AnswerViewBuilder builder,
  ) {
    _answerViewBuilders[T] = builder;
  }

  void registerContentWidgetBuilder<T extends Content>(
    ContentWidgetBuilder builder,
  ) {
    _contentWidgetBuilders[T] = builder;
  }

  Widget? createAnswerView(
    AnswerFormat answerFormat,
    Step step,
    StepResult? stepResult,
  ) {
    final builder = _answerViewBuilders[answerFormat.runtimeType];
    if (builder != null) {
      return builder(answerFormat, step, stepResult);
    }
    return null;
  }

  Widget? createContentWidget(Content content) {
    final builder = _contentWidgetBuilders[content.runtimeType];
    if (builder != null) {
      return builder(content);
    }
    return null;
  }

  static SurveyKitRegistry? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SurveyKitRegistry>();
  }

  @override
  bool updateShouldNotify(SurveyKitRegistry oldWidget) => false;
}
