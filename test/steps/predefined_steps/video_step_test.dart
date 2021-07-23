import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/steps/predefined_steps/video_step.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  test('serialization of video step', () {
    final jsonStr = '''
          {
            "stepIdentifier": {
                "id": "11"
            },
            "type": "video",
            "url": "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
            "isAutomaticFullscreen": true,
            "isAutoPlay": true,
            "isLooping": true,
            "allowMuting": false,
            "goToNextPageAfterEnd": true
          }''';
    final jsonVideoStep = VideoStep.fromJson(json.decode(jsonStr));
    final videoStep = VideoStep(
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      stepIdentifier: StepIdentifier(id: "11"),
      isAutomaticFullscreen: true,
      isAutoPlay: true,
      isLooping: true,
      allowMuting: false,
      goToNextPageAfterEnd: true,
    );

    expect(jsonVideoStep, videoStep);
  });
}
