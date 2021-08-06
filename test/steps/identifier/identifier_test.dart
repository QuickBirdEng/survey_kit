import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  test('identifier created by json is the same as created by code', () {
    final jsonStr = ''' 
      {
        "id":"123"
      }
    ''';
    final jsonIdentifier = Identifier.fromJson(json.decode(jsonStr));
    final identifier = Identifier(id: '123');

    expect(identifier, jsonIdentifier);
  });
}
