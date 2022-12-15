import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  test('ordered task created by json is the same as created via code', () {
    const jsonStr = '''
    {
      "id": "123",
      "type": "ordered"
    }
    ''';
    final Task orderedTask =
        OrderedTask(id: TaskIdentifier(id: '123'), steps: const []);

    final orderedJsonTask =
        OrderedTask.fromJson(json.decode(jsonStr) as Map<String, dynamic>);

    expect(orderedTask, orderedJsonTask);
  });
}
