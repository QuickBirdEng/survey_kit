import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

import 'mock.dart';

void main() {
  final tResult = StepResult(
    id: 'example1',
    startTime: DateTime(2022, 8, 12, 16, 4),
    endTime: DateTime(2022, 8, 12, 16, 14),
    valueIdentifier: 'multiChoice1',
    step: sampleStep,
    result: [
      TextChoice(id: 'doubleVal1', value: '123.45', text: '123.45'),
      TextChoice(id: 'doubleVal2', value: '234.56', text: '234.56'),
    ],
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tResult.toJson();
        final decodedResult =
            StepResult<List<TextChoice>>.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
