import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

Map<String, dynamic> _jsonRoundTrip(Map<String, dynamic> json) =>
    jsonDecode(jsonEncode(json)) as Map<String, dynamic>;

const _styled = StyledTextContent(text: 'styled', bold: true, fontSize: 18);

final _allContent = <Content>[
  const TextContent(text: 'text', id: 't1', textAlign: TextAlign.left),
  const MarkdownContent(text: '# markdown', id: 'm1'),
  const ImageContent(url: 'https://example.com/a.png', fit: BoxFit.cover),
  const SectionContent(title: _styled, subtitle: _styled, text: _styled),
  _styled,
];

void main() {
  group('Content JSON', () {
    for (final content in _allContent) {
      test('${content.contentType} round-trips with its type', () {
        final json = _jsonRoundTrip(content.toJson());
        expect(json['type'], content.contentType);

        final decoded = Content.fromJson(json);
        expect(decoded.runtimeType, content.runtimeType);
        expect(decoded.toJson(), content.toJson());
      });
    }

    test('json without type throws a FormatException', () {
      final json = const TextContent(text: 'no type').toJson()..remove('type');
      expect(() => Content.fromJson(json), throwsFormatException);
    });

    test('unknown type throws a FormatException', () {
      expect(
        () => Content.fromJson(const {'type': 'unknown'}),
        throwsFormatException,
      );
    });
  });

  group('Step JSON', () {
    test('round-trips content and answer format', () {
      final step = Step(
        id: 'step',
        content: _allContent,
        answerFormat: SingleChoiceAnswerFormat(
          choices: [TextChoice(id: 'a', text: 'A', value: 'a')],
        ),
      );
      final decoded = Step.fromJson(_jsonRoundTrip(step.toJson()));
      expect(decoded.toJson(), step.toJson());
      expect(decoded.answerFormat, isA<SingleChoiceAnswerFormat<TextChoice>>());
    });
  });

  group('AnswerFormat', () {
    test('built-in formats always serialize their own type', () {
      const formats = <AnswerFormat>[
        BooleanAnswerFormat(positiveAnswer: 'y', negativeAnswer: 'n'),
        IntegerAnswerFormat(),
        DoubleAnswerFormat(),
        TextAnswerFormat(),
        TimeAnswerFormat(),
        ScaleAnswerFormat(
          maximumValue: 10,
          minimumValue: 0,
          defaultValue: 5,
          step: 1,
        ),
        MultipleDoubleAnswerFormat(hints: ['a']),
      ];
      for (final format in formats) {
        final json = _jsonRoundTrip(format.toJson());
        expect(json['type'], format.answerType);
        expect(AnswerFormat.fromJson(json).runtimeType, format.runtimeType);
      }
    });

    test('default text validation rejects whitespace-only input', () {
      final regex = RegExp(const TextAnswerFormat().validationRegEx!);
      expect(regex.hasMatch('answer'), isTrue);
      expect(regex.hasMatch('s'), isTrue);
      expect(regex.hasMatch(''), isFalse);
      expect(regex.hasMatch('   '), isFalse);
    });

    test('text validation default is applied when decoding json', () {
      final decoded =
          AnswerFormat.fromJson(const {'type': 'text'}) as TextAnswerFormat;
      expect(decoded.validationRegEx, TextAnswerFormat.defaultValidationRegEx);
    });
  });

  group('SurveyFlow', () {
    test('round-trips steps, initial step and rules through jsonEncode', () {
      final first = Step(
        id: 'first',
        content: const [TextContent(text: 'first')],
        answerFormat: const BooleanAnswerFormat(
          positiveAnswer: 'yes',
          negativeAnswer: 'no',
        ),
      );
      final second = Step(id: 'second', content: const [_styled]);
      final flow = SurveyFlow(
        id: 'flow',
        steps: [first, second],
        initialStep: first,
        navigationRules: {'first': DirectNavigationRule('second')},
      );

      final decoded = SurveyDefinition.fromJson(_jsonRoundTrip(flow.toJson()));
      expect(decoded.toJson(), flow.toJson());
    });

    test('equal definitions have equal hash codes', () {
      final a = SurveyFlow(
        id: 'x',
        steps: [Step(content: const [])],
      );
      final b = SurveyFlow(id: 'x', steps: const []);
      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });

    test('copies the passed rules and exposes them read-only', () {
      final rules = <String, NavigationRule>{'a': DirectNavigationRule('b')};
      final flow = SurveyFlow(id: 'f', navigationRules: rules);
      rules['c'] = DirectNavigationRule('d');

      expect(flow.navigationRules.keys, ['a']);
      expect(
        () => flow.navigationRules['x'] = DirectNavigationRule('y'),
        throwsUnsupportedError,
      );
    });

    test('addNavigationRule reports whether the rule was added', () {
      final flow = SurveyFlow(id: 'f');
      expect(
        flow.addNavigationRule(
          forTriggerStepIdentifier: 'a',
          navigationRule: DirectNavigationRule('b'),
        ),
        isTrue,
      );
      expect(
        flow.addNavigationRule(
          forTriggerStepIdentifier: 'a',
          navigationRule: DirectNavigationRule('c'),
        ),
        isFalse,
      );
      expect(
        (flow.getRuleByStepIdentifier('a')! as DirectNavigationRule)
            .destinationStepIdentifier,
        'b',
      );
    });

    test('accepts added rules when constructed with a const map', () {
      final task = SurveyFlow(id: 'o', navigationRules: const {});
      expect(
        task.addNavigationRule(
          forTriggerStepIdentifier: 'x',
          navigationRule: DirectNavigationRule('y'),
        ),
        isTrue,
      );
    });
  });
}
