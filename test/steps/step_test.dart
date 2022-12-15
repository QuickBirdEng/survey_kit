import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/steps/predefined_steps/instruction_step.dart';
import 'package:survey_kit/src/steps/step.dart';

void main() {
  test('instruction step is the same created by json and code', () {
    const jsonStr = r'''
    {
      "stepIdentifier": {
        "id": "1"
      },
      "type": "intro",
      "title": "Welcome to the\nQuickBird Studios\nHealth Survey",
      "text": "Get ready for a bunch of super random questions!",
      "buttonText": "Let's go!"
    }
    ''';
    final jsonStep =
        Step.fromJson(json.decode(jsonStr) as Map<String, dynamic>);
    final step = InstructionStep(
      stepIdentifier: StepIdentifier(id: '1'),
      title: 'Welcome to the\nQuickBird Studios\nHealth Survey',
      text: 'Get ready for a bunch of super random questions!',
      buttonText: "Let's go!",
    );

    expect(step, jsonStep);
  });

  test('throw step not defined exception of type is unvalid', () {
    const jsonStr = r'''
    {
      "stepIdentifier": {
        "id": "1"
      },
      "type": "undefined",
      "title": "Welcome to the\nQuickBird Studios\nHealth Survey",
      "text": "Get ready for a bunch of super random questions!",
      "buttonText": "Let's go!"
    }
    ''';
    expect(
      () => Step.fromJson(json.decode(jsonStr) as Map<String, dynamic>),
      throwsException,
    );
  });
}
