import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final tResult = InstructionStep(
    text: 'example 1 text here',
    title: 'example 1 title here'
  );

  group('serialisation', () {
    test(
      'should work with valid example',
          () async {
        final encodedResult = tResult.toJson();
        final decodedResult = InstructionStep.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
