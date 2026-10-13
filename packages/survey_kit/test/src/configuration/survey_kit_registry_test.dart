import 'package:flutter/material.dart' hide Step;
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/configuration/survey_kit_default_registry.dart';
import 'package:survey_kit/src/view/widget/content/text_widget.dart';
import 'package:survey_kit/survey_kit.dart';

class _CustomTextAnswerFormat extends TextAnswerFormat {
  const _CustomTextAnswerFormat({super.question});
}

class _SpecialTextAnswerFormat extends _CustomTextAnswerFormat {
  const _SpecialTextAnswerFormat();
}

class _CustomChoice extends TextChoice {
  _CustomChoice({required super.text});
}

class _CustomTextContent extends TextContent {
  const _CustomTextContent({required super.text});
}

class _CustomView extends StatelessWidget {
  const _CustomView(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Text(label);
}

SurveyKitRegistry _defaultRegistry({
  Map<Type, AnswerViewBuilder>? answerViewBuilders,
  Map<Type, ContentWidgetBuilder>? contentWidgetBuilders,
  List<AnswerViewRegistration> answerViewRegistrations = const [],
  List<ContentWidgetRegistration> contentWidgetRegistrations = const [],
}) {
  return SurveyKitRegistry(
    answerViewRegistrations: [
      ...getDefaultAnswerViewRegistrations(),
      ...answerViewRegistrations,
    ],
    contentWidgetRegistrations: [
      ...getDefaultContentWidgetRegistrations(),
      ...contentWidgetRegistrations,
    ],
    initialAnswerViewBuilders: answerViewBuilders,
    initialContentWidgetBuilders: contentWidgetBuilders,
    child: const SizedBox(),
  );
}

Widget? _answerView(SurveyKitRegistry registry, AnswerFormat answerFormat) {
  return registry.createAnswerView(
    answerFormat,
    Step(content: const [], answerFormat: answerFormat),
    null,
  );
}

Widget _customAnswerView(String label) => _CustomView(label);

Future<SurveyResult?> _completeSingleStepSurvey(
  WidgetTester tester,
  AnswerFormat answerFormat,
  Future<void> Function() interact,
) async {
  SurveyResult? surveyResult;
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SurveyKit(
          task: SurveyFlow(
            id: 'survey',
            steps: [Step(content: const [], answerFormat: answerFormat)],
          ),
          onResult: (result) => surveyResult = result,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await interact();
  await tester.pumpAndSettle();
  final nextButton = find.widgetWithText(ElevatedButton, 'Next');
  await tester.ensureVisible(nextButton);
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  return surveyResult;
}

void main() {
  group('SurveyKitRegistry answer views', () {
    test('subclass of a built-in format resolves to the built-in view', () {
      final view = _answerView(
        _defaultRegistry(),
        const _CustomTextAnswerFormat(),
      );

      expect(view, isA<TextAnswerView>());
    });

    test('generic format with a custom choice type resolves', () {
      final view = _answerView(
        _defaultRegistry(),
        MultipleChoiceAnswerFormat<_CustomChoice>(
          choices: [_CustomChoice(text: 'A')],
        ),
      );

      expect(view, isA<MultipleChoiceAnswerView>());
    });

    test('generic single choice format with a custom choice type resolves', () {
      final view = _answerView(
        _defaultRegistry(),
        SingleChoiceAnswerFormat<_CustomChoice>(
          choices: [_CustomChoice(text: 'A')],
        ),
      );

      expect(view, isA<SingleChoiceAnswerView>());
    });

    test('exact map entry for a subclass wins over the base builder', () {
      final registry = _defaultRegistry(
        answerViewBuilders: {
          _CustomTextAnswerFormat: (format, step, result) =>
              _customAnswerView('custom'),
        },
      );

      expect(
        _answerView(registry, const _CustomTextAnswerFormat()),
        isA<_CustomView>(),
      );
      expect(
        _answerView(registry, const TextAnswerFormat()),
        isA<TextAnswerView>(),
      );
    });

    test('registration for a subclass wins over the base builder', () {
      final registry = _defaultRegistry(
        answerViewRegistrations: [
          AnswerViewRegistration<_CustomTextAnswerFormat>(
            (format, step, result) => _customAnswerView('custom'),
          ),
        ],
      );

      expect(
        _answerView(registry, const _SpecialTextAnswerFormat()),
        isA<_CustomView>(),
      );
      expect(
        _answerView(registry, const TextAnswerFormat()),
        isA<TextAnswerView>(),
      );
    });

    test('most recent registration wins for overlapping types', () {
      final registry = _defaultRegistry(
        answerViewRegistrations: [
          AnswerViewRegistration<_CustomTextAnswerFormat>(
            (format, step, result) => _customAnswerView('first'),
          ),
          AnswerViewRegistration<TextAnswerFormat>(
            (format, step, result) => _customAnswerView('second'),
          ),
        ],
      );

      final view = _answerView(registry, const _SpecialTextAnswerFormat());

      expect((view! as _CustomView).label, 'second');
    });

    test('exact runtime type match wins over a later subtype match', () {
      final registry = _defaultRegistry(
        answerViewRegistrations: [
          AnswerViewRegistration<AnswerFormat>(
            (format, step, result) => _customAnswerView('fallback'),
          ),
        ],
      );

      expect(
        _answerView(registry, const TextAnswerFormat()),
        isA<TextAnswerView>(),
      );
      expect(
        (_answerView(registry, const _CustomTextAnswerFormat())! as _CustomView)
            .label,
        'fallback',
      );
    });

    test('map entry replacing a default also covers its subclasses', () {
      final registry = _defaultRegistry(
        answerViewBuilders: {
          TextAnswerFormat: (format, step, result) =>
              _customAnswerView('override'),
        },
      );

      expect(
        _answerView(registry, const _CustomTextAnswerFormat()),
        isA<_CustomView>(),
      );
      expect(
        _answerView(registry, const TextAnswerFormat()),
        isA<_CustomView>(),
      );
    });

    test('map entry for an unknown type only matches that exact type', () {
      final registry = SurveyKitRegistry(
        initialAnswerViewBuilders: {
          _CustomTextAnswerFormat: (format, step, result) =>
              _customAnswerView('custom'),
        },
        child: const SizedBox(),
      );

      expect(
        _answerView(registry, const _CustomTextAnswerFormat()),
        isA<_CustomView>(),
      );
      expect(_answerView(registry, const _SpecialTextAnswerFormat()), isNull);
    });

    test('deprecated register method matches subtypes', () {
      final registry = SurveyKitRegistry(child: const SizedBox())
        ..registerAnswerViewBuilder<TextAnswerFormat>(
          (format, step, result) => _customAnswerView('legacy'),
        );

      expect(
        _answerView(registry, const _CustomTextAnswerFormat()),
        isA<_CustomView>(),
      );
    });
  });

  group('SurveyKitRegistry content widgets', () {
    test('content subclass resolves to the built-in widget', () {
      final widget = _defaultRegistry().createContentWidget(
        const _CustomTextContent(text: 'Hello'),
      );

      expect(widget, isA<TextWidget>());
    });

    test('map override for a default content type covers subclasses', () {
      final registry = _defaultRegistry(
        contentWidgetBuilders: {
          TextContent: (content) => const _CustomView('content'),
        },
      );

      expect(
        registry.createContentWidget(const _CustomTextContent(text: 'Hello')),
        isA<_CustomView>(),
      );
    });

    test('content registration for a subclass wins over the base', () {
      final registry = _defaultRegistry(
        contentWidgetRegistrations: [
          ContentWidgetRegistration<_CustomTextContent>(
            (content) => const _CustomView('content'),
          ),
        ],
      );

      expect(
        registry.createContentWidget(const _CustomTextContent(text: 'Hello')),
        isA<_CustomView>(),
      );
      expect(
        registry.createContentWidget(const TextContent(text: 'Hello')),
        isA<TextWidget>(),
      );
    });
  });

  group('SurveyKit', () {
    testWidgets('renders built-in views for subclassed formats and content', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SurveyKit(
              task: SurveyFlow(
                id: 'survey',
                steps: [
                  Step(
                    content: const [_CustomTextContent(text: 'Custom content')],
                    answerFormat: const _CustomTextAnswerFormat(
                      question: 'Custom question',
                    ),
                  ),
                ],
              ),
              onResult: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TextAnswerView), findsOneWidget);
      expect(find.text('Custom content'), findsOneWidget);
      expect(find.textContaining('No view for'), findsNothing);
    });

    testWidgets('user registrations win over default builders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SurveyKit(
              task: SurveyFlow(
                id: 'survey',
                steps: [
                  Step(
                    content: const [],
                    answerFormat: const _SpecialTextAnswerFormat(),
                  ),
                ],
              ),
              onResult: (_) {},
              answerViewRegistrations: [
                AnswerViewRegistration<_CustomTextAnswerFormat>(
                  (format, step, result) => _customAnswerView('user view'),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('user view'), findsOneWidget);
      expect(find.byType(TextAnswerView), findsNothing);
    });

    testWidgets('multiple choice with a custom choice type is answerable', (
      tester,
    ) async {
      final apple = _CustomChoice(text: 'Apple');
      final result = await _completeSingleStepSurvey(
        tester,
        MultipleChoiceAnswerFormat<_CustomChoice>(
          choices: [
            apple,
            _CustomChoice(text: 'Pear'),
          ],
          otherField: true,
        ),
        () async {
          await tester.tap(find.text('Apple'));
          await tester.pump();
          await tester.enterText(find.byType(TextFormField), 'Kiwi');
        },
      );

      expect(tester.takeException(), isNull);
      final choices = result!.results.single.result as List<TextChoice>;
      expect(choices.first, apple);
      expect(choices.map((choice) => choice.text), ['Apple', 'Kiwi']);
    });

    testWidgets('single choice with a custom choice type is answerable', (
      tester,
    ) async {
      final pear = _CustomChoice(text: 'Pear');
      final result = await _completeSingleStepSurvey(
        tester,
        SingleChoiceAnswerFormat<_CustomChoice>(
          choices: [
            _CustomChoice(text: 'Apple'),
            pear,
          ],
        ),
        () => tester.tap(find.text('Pear')),
      );

      expect(tester.takeException(), isNull);
      expect(result!.results.single.result, pear);
    });
  });
}
