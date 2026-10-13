import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';

/// A factory function that builds the answer widget for a given [AnswerFormat]
/// and [Step].
typedef AnswerViewBuilder =
    Widget Function(
      AnswerFormat answerFormat,
      Step step,
      StepResult? stepResult,
    );

/// A factory function that builds the display widget for a given [Content].
typedef ContentWidgetBuilder = Widget Function(Content content);

/// Registers an [AnswerViewBuilder] for the answer format type [T] and all of
/// its subtypes.
///
/// Unlike an entry in a `Map<Type, AnswerViewBuilder>`, which only matches
/// formats whose runtime type is exactly the key, a registration also matches
/// subclasses of [T] and generic instantiations such as
/// `MultipleChoiceAnswerFormat<MyChoice>`.
@immutable
class AnswerViewRegistration<T extends AnswerFormat> {
  const AnswerViewRegistration(this.builder);

  final AnswerViewBuilder builder;

  /// The answer format type this registration was created for.
  Type get type => T;

  /// Whether [answerFormat] is a [T].
  bool matches(AnswerFormat answerFormat) => answerFormat is T;
}

/// Registers a [ContentWidgetBuilder] for the content type [T] and all of its
/// subtypes.
///
/// Unlike an entry in a `Map<Type, ContentWidgetBuilder>`, which only matches
/// content whose runtime type is exactly the key, a registration also matches
/// subclasses of [T].
@immutable
class ContentWidgetRegistration<T extends Content> {
  const ContentWidgetRegistration(this.builder);

  final ContentWidgetBuilder builder;

  /// The content type this registration was created for.
  Type get type => T;

  /// Whether [content] is a [T].
  bool matches(Content content) => content is T;
}

@immutable
class _BuilderEntry<V, B extends Function> {
  const _BuilderEntry(this.type, this.matches, this.builder);

  final Type type;
  final bool Function(V value)? matches;
  final B builder;

  @override
  bool operator ==(Object other) =>
      other is _BuilderEntry<V, B> &&
      other.type == type &&
      other.builder == builder;

  @override
  int get hashCode => Object.hash(type, builder);
}

class _BuilderTable<V extends Object, B extends Function> {
  final List<_BuilderEntry<V, B>> _entries = [];
  final Map<Type, _BuilderEntry<V, B>> _exact = {};

  void add(Type type, bool Function(V value)? matches, B builder) {
    final previous = _exact.remove(type);
    if (previous != null) {
      _entries.remove(previous);
    }
    final entry = _BuilderEntry<V, B>(
      type,
      matches ?? previous?.matches,
      builder,
    );
    _entries.add(entry);
    _exact[type] = entry;
  }

  B? lookup(V value) {
    final exact = _exact[value.runtimeType];
    if (exact != null) {
      return exact.builder;
    }
    for (final entry in _entries.reversed) {
      if (entry.matches?.call(value) ?? false) {
        return entry.builder;
      }
    }
    return null;
  }

  bool hasSameEntries(_BuilderTable<V, B> other) =>
      listEquals(_entries, other._entries);
}

/// An [InheritedWidget] that holds the registered answer-view and
/// content-widget builders.
///
/// Builders are resolved by the runtime type of the [AnswerFormat] or
/// [Content] first. If no builder is registered for that exact type, the most
/// recently added [AnswerViewRegistration] or [ContentWidgetRegistration]
/// whose type is a supertype of the value is used.
///
/// [answerViewRegistrations] and [contentWidgetRegistrations] are added first,
/// followed by [initialAnswerViewBuilders] and [initialContentWidgetBuilders].
/// A map entry only matches its exact type, unless it replaces a registration
/// for the same type, in which case it also takes over that registration's
/// subtypes.
class SurveyKitRegistry extends InheritedWidget {
  final _BuilderTable<AnswerFormat, AnswerViewBuilder> _answerViewBuilders =
      _BuilderTable();
  final _BuilderTable<Content, ContentWidgetBuilder> _contentWidgetBuilders =
      _BuilderTable();

  SurveyKitRegistry({
    super.key,
    required super.child,
    Map<Type, AnswerViewBuilder>? initialAnswerViewBuilders,
    Map<Type, ContentWidgetBuilder>? initialContentWidgetBuilders,
    List<AnswerViewRegistration>? answerViewRegistrations,
    List<ContentWidgetRegistration>? contentWidgetRegistrations,
  }) {
    for (final registration
        in answerViewRegistrations ?? const <AnswerViewRegistration>[]) {
      _answerViewBuilders.add(
        registration.type,
        registration.matches,
        registration.builder,
      );
    }
    for (final registration
        in contentWidgetRegistrations ?? const <ContentWidgetRegistration>[]) {
      _contentWidgetBuilders.add(
        registration.type,
        registration.matches,
        registration.builder,
      );
    }
    initialAnswerViewBuilders?.forEach(
      (type, builder) => _answerViewBuilders.add(type, null, builder),
    );
    initialContentWidgetBuilders?.forEach(
      (type, builder) => _contentWidgetBuilders.add(type, null, builder),
    );
  }

  /// Registers a widget builder for the answer format type [T] and its
  /// subtypes.
  @Deprecated(
    'Widgets are immutable and dependents are not notified of changes. Pass '
    'builders via answerViewRegistrations or SurveyKit.answerViewBuilders.',
  )
  void registerAnswerViewBuilder<T extends AnswerFormat>(
    AnswerViewBuilder builder,
  ) {
    _answerViewBuilders.add(T, (answerFormat) => answerFormat is T, builder);
  }

  /// Registers a widget builder for the content type [T] and its subtypes.
  @Deprecated(
    'Widgets are immutable and dependents are not notified of changes. Pass '
    'builders via contentWidgetRegistrations or '
    'SurveyKit.contentWidgetBuilders.',
  )
  void registerContentWidgetBuilder<T extends Content>(
    ContentWidgetBuilder builder,
  ) {
    _contentWidgetBuilders.add(T, (content) => content is T, builder);
  }

  /// Looks up and invokes the builder for [answerFormat]. Returns null if no
  /// builder matches.
  Widget? createAnswerView(
    AnswerFormat answerFormat,
    Step step,
    StepResult? stepResult,
  ) {
    return _answerViewBuilders
        .lookup(answerFormat)
        ?.call(answerFormat, step, stepResult);
  }

  /// Looks up and invokes the builder for [content]. Returns null if no
  /// builder matches.
  Widget? createContentWidget(Content content) {
    return _contentWidgetBuilders.lookup(content)?.call(content);
  }

  /// Returns the nearest [SurveyKitRegistry] in the widget tree, or null if
  /// none is found.
  static SurveyKitRegistry? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SurveyKitRegistry>();
  }

  @override
  bool updateShouldNotify(SurveyKitRegistry oldWidget) =>
      !_answerViewBuilders.hasSameEntries(oldWidget._answerViewBuilders) ||
      !_contentWidgetBuilders.hasSameEntries(oldWidget._contentWidgetBuilders);
}
