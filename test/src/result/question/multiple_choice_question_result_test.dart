import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final tResult = StepResult(
    id: 'example1',
    startTime: DateTime(2022, 8, 12, 16, 4),
    endTime: DateTime(2022, 8, 12, 16, 14),
    valueIdentifier: 'multiChoice1',
    result: const [
      Option(id: 'doubleVal1', value: '123.45'),
      Option(id: 'doubleVal2', value: '234.56'),
    ],
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tResult.toJson();
        final decodedResult = StepResult<List<Option>>.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
