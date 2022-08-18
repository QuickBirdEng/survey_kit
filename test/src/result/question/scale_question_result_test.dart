import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final tResult = ScaleQuestionResult(
    id: Identifier(id: 'example1'),
    startDate: DateTime(2022, 8, 12, 16, 4),
    endDate: DateTime(2022, 8, 12, 16, 14),
    valueIdentifier: 'scaleInput1',
    result: -123.45,
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tResult.toJson();
        final decodedResult = ScaleQuestionResult.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
