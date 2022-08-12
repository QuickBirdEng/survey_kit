import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final tResult = TimeQuestionResult(
    id: Identifier(id: 'example1'),
    startDate: DateTime(2022, 8, 12, 16, 4),
    endDate: DateTime(2022, 8, 12, 16, 14),
    valueIdentifier: 'timeInput1',
    result: TimeOfDay(hour: 14, minute: 59),
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tResult.toJson();
        final decodedResult = TimeQuestionResult.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
