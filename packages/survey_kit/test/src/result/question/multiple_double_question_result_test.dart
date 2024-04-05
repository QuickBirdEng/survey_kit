import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/model/answer/multi_double.dart';
import 'package:survey_kit/survey_kit.dart';

import 'mock.dart';

void main() {
  final tResult = StepResult(
    id: 'example1',
    startTime: DateTime(2022, 8, 12, 16, 4),
    endTime: DateTime(2022, 8, 12, 16, 14),
    valueIdentifier: 'multiDouble1',
    step: sampleStep,
    result: const [
      MultiDouble(text: 'doubleVal1', value: 123.45),
      MultiDouble(text: 'doubleVal2', value: 234.56),
    ],
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tResult.toJson();
        final decodedResult =
            StepResult<List<MultiDouble>>.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
