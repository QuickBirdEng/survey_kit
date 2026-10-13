import 'dart:convert';

import 'package:flutter/material.dart' hide Step;
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/model/answer/multi_double.dart';
import 'package:survey_kit/src/model/result/time_result.dart';
import 'package:survey_kit/survey_kit.dart';

import 'question/mock.dart';

Map<String, dynamic> _jsonRoundTrip(Map<String, dynamic> json) =>
    jsonDecode(jsonEncode(json)) as Map<String, dynamic>;

StepResult<T> _result<T>(T value) => StepResult<T>(
  id: 'example1',
  startTime: DateTime.utc(2022, 8, 12, 16, 4),
  endTime: DateTime.utc(2022, 8, 12, 16, 14),
  valueIdentifier: 'value1',
  step: sampleStep,
  result: value,
);

void _expectRoundTrip<T>(T value) {
  final original = _result<T>(value);
  final decoded = StepResult<T>.fromJson(_jsonRoundTrip(original.toJson()));
  expect(decoded, original);
  expect(decoded.result, isA<T>());
}

@immutable
class _Custom {
  const _Custom(this.label);

  final String label;

  @override
  bool operator ==(Object other) => other is _Custom && other.label == label;

  @override
  int get hashCode => label.hashCode;
}

void main() {
  group('StepResult JSON round-trip through jsonEncode', () {
    test('String', () => _expectRoundTrip<String>('answer'));
    test('int', () => _expectRoundTrip<int>(42));
    test('double', () => _expectRoundTrip<double>(4.0));
    test('bool', () => _expectRoundTrip<bool>(true));
    test('DateTime utc', () => _expectRoundTrip(DateTime.utc(2022, 8, 12)));
    test('DateTime local', () => _expectRoundTrip(DateTime(2022, 8, 12, 9)));
    test(
      'BooleanResult',
      () => _expectRoundTrip<BooleanResult>(BooleanResult.negative),
    );
    test(
      'TimeResult',
      () => _expectRoundTrip(
        const TimeResult(timeOfDay: TimeOfDay(hour: 14, minute: 59)),
      ),
    );
    test(
      'TextChoice',
      () => _expectRoundTrip(
        TextChoice(id: 'choice1', value: 'option2', text: 'option2'),
      ),
    );
    test(
      'List<TextChoice>',
      () => _expectRoundTrip<List<TextChoice>>([
        TextChoice(id: 'c1', text: 'one', value: '1'),
        TextChoice(id: 'c2', text: 'two'),
      ]),
    );
    test(
      'empty List<TextChoice>',
      () => _expectRoundTrip<List<TextChoice>>(<TextChoice>[]),
    );
    test(
      'List<MultiDouble>',
      () => _expectRoundTrip<List<MultiDouble>>(const [
        MultiDouble(text: 'a', value: 1.5),
        MultiDouble(text: 'b', value: 2),
      ]),
    );
    test('null result', () => _expectRoundTrip<String?>(null));

    test('writes resultType discriminator', () {
      final json = _result(BooleanResult.positive).toJson();
      expect(json['resultType'], 'booleanResult');
      expect(json['result'], 'positive');
    });

    test('legacy json without resultType keeps raw value', () {
      final json = _jsonRoundTrip(_result('legacy').toJson())
        ..remove('resultType');
      expect(StepResult<String>.fromJson(json).result, 'legacy');
    });

    test('custom codec registered via registerResultCodec', () {
      StepResult.registerResultCodec(
        StepResultCodec.of<_Custom>(
          type: 'custom',
          encode: (value) => value.label,
          decode: (json) => _Custom(json! as String),
        ),
      );
      _expectRoundTrip(const _Custom('x'));
    });
  });
}
