import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final tResult = MultipleDoubleQuestionResult(
    id: Identifier(id: 'example1'),
    startDate: DateTime(2022, 8, 12, 16, 4),
    endDate: DateTime(2022, 8, 12, 16, 14),
    valueIdentifier: 'multiDouble1',
    result: [
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
            MultipleDoubleQuestionResult.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
