import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final tResult = CompletionStepResult(
    Identifier(id: 'example1'),
    DateTime(2022, 8, 12, 16, 4),
    DateTime(2022, 8, 12, 16, 14),
  );

  group('serialisation', () {
    test(
      'should work with valid example',
          () async {
        final encodedResult = tResult.toJson();
        final decodedResult = CompletionStepResult.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
