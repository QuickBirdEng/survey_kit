import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';

/// A factory function that builds the answer widget for a given [AnswerFormat]
/// and [Step].
typedef AnswerViewBuilder = Widget Function(
  AnswerFormat answerFormat,
  Step step,
  StepResult? stepResult,
);

/// A factory function that builds the display widget for a given [Content].
typedef ContentWidgetBuilder = Widget Function(
  Content content,
);

/// An [InheritedWidget] that holds the registered answer-view and
/// content-widget builders. Pass [initialAnswerViewBuilders] and
/// [initialContentWidgetBuilders] to pre-populate the registry at construction
/// time.
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

  /// Registers a widget builder for the answer format type [T].
  void registerAnswerViewBuilder<T extends AnswerFormat>(
    AnswerViewBuilder builder,
  ) {
    _answerViewBuilders[T] = builder;
  }

  /// Registers a widget builder for the content type [T].
  void registerContentWidgetBuilder<T extends Content>(
    ContentWidgetBuilder builder,
  ) {
    _contentWidgetBuilders[T] = builder;
  }

  /// Looks up and invokes the registered builder for [answerFormat]. Returns
  /// null if no builder is registered.
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

  /// Looks up and invokes the registered builder for [content]. Returns null if
  /// no builder is registered.
  Widget? createContentWidget(Content content) {
    final builder = _contentWidgetBuilders[content.runtimeType];
    if (builder != null) {
      return builder(content);
    }
    return null;
  }

  /// Returns the nearest [SurveyKitRegistry] in the widget tree, or null if
  /// none is found.
  static SurveyKitRegistry? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SurveyKitRegistry>();
  }

  @override
  bool updateShouldNotify(SurveyKitRegistry oldWidget) => false;
}
