import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

import 'mock.dart';

void main() {
  final tResult = StepResult(
    id: 'example1',
    startTime: DateTime(2022, 8, 12, 16, 4),
    endTime: DateTime(2022, 8, 12, 16, 14),
    valueIdentifier: 'int1',
    step: sampleStep,
    result: 123,
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tResult.toJson();
        final decodedResult = StepResult<int>.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
