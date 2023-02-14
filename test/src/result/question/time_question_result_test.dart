import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/model/result/time_result.dart';
import 'package:survey_kit/survey_kit.dart';

import 'mock.dart';

void main() {
  final tResult = StepResult(
    id: 'example1',
    startTime: DateTime(2022, 8, 12, 16, 4),
    endTime: DateTime(2022, 8, 12, 16, 14),
    valueIdentifier: 'timeInput1',
    step: sampleStep,
    result: const TimeResult(
      timeOfDay: TimeOfDay(hour: 14, minute: 59),
    ),
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tResult.toJson();
        final decodedResult = StepResult<TimeResult>.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
