# survey_kit_audio

Audio content plugin for `survey_kit`.

## Installation

```yaml
dependencies:
  survey_kit: 2.0.0-beta1
  survey_kit_audio: 2.0.0-beta1
```

## Register plugin

```dart
SurveyKit(
  task: task,
  onResult: (result) {},
  registries: [SurveyKitAudio()],
);
```

## Content type

This package provides `AudioContent` and the matching renderer for SurveyKit's
registry system.
