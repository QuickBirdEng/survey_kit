import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final tResult = ImageQuestionResult(
    id: Identifier(id: 'example1'),
    startDate: DateTime(2023, 7, 4, 10, 41),
    endDate: DateTime(2023, 7, 4, 10, 51),
    valueIdentifier: 'imageInput1',
    result: 'url for the image',
  );

  group('serialisarion', () {
    test('should work with valid example', () async {
      final encodedResult = tResult.toJson();
      final decodedResult = ImageQuestionResult.fromJson(encodedResult);
      expect(tResult, decodedResult);
    });
  });
}
