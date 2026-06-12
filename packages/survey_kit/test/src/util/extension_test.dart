import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/util/extension.dart';

void main() {
  group('withSeparator', () {
    test('returns empty iterable for empty input', () {
      expect(<int>[].withSeparator(0), isEmpty);
    });

    test('returns single element without separator', () {
      expect([1].withSeparator(0), [1]);
    });

    test('interleaves separator between elements', () {
      expect([1, 2, 3].withSeparator(0), [1, 0, 2, 0, 3]);
    });

    test('does not add a trailing separator', () {
      expect([1, 2].withSeparator(0).last, 2);
    });
  });
}
