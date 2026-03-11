# survey_kit_video

Video content plugin for `survey_kit`.

## Installation

```yaml
dependencies:
  survey_kit: 2.0.0-beta1
  survey_kit_video: 2.0.0-beta1
```

## Register plugin

```dart
SurveyKit(
  task: task,
  onResult: (result) {},
  registries: [SurveyKitVideo()],
);
```

## Content type

This package provides `VideoContent` and the matching renderer for SurveyKit's
registry system.
