# survey_kit_lottie

Lottie content plugin for `survey_kit`.

## Installation

```yaml
dependencies:
  survey_kit: 2.0.0-beta1
  survey_kit_lottie: 2.0.0-beta1
```

## Register plugin

```dart
SurveyKit(
  task: task,
  onResult: (result) {},
  registries: [SurveyKitLottie()],
);
```

## Content type

This package provides `LottieContent` and the matching renderer for SurveyKit's
registry system.
