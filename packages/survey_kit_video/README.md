# survey_kit_video

Video content plugin for [survey_kit](https://pub.dev/packages/survey_kit) — embed video players inside Flutter survey steps.

> **Part of the SurveyKit ecosystem.** See the [survey_kit package](https://pub.dev/packages/survey_kit) for the core library, full documentation, and all available plugins.

---

## Features

- Embed video players directly inside survey steps
- Support for remote URLs on iOS, Android, macOS, and Web
- Optional auto-play, looping, title, subtitle, and external link
- Configurable player dimensions
- Drop-in registration via the `SurveyKitPlugin` registry system

---

## Installation

Add both packages to your `pubspec.yaml`:

```yaml
dependencies:
  survey_kit: ^2.0.0-beta1
  survey_kit_video: ^2.0.0-beta1
```

---

## Register the plugin

Pass `SurveyKitVideo()` to the `registries` parameter of `SurveyKit`:

```dart
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_video/survey_kit_video.dart';

SurveyKit(
  task: task,
  onResult: (SurveyResult result) { /* handle result */ },
  registries: [SurveyKitVideo()],
);
```

---

## Usage

### Dart

Add a `VideoContent` to a step's `content` list:

```dart
import 'package:survey_kit_video/survey_kit_video.dart';

Step(
  content: [
    TextContent(text: 'Watch the following video before answering:'),
    VideoContent(
      url: 'https://example.com/video/intro.mp4',
      title: 'Introduction',
      subtitle: 'Please watch fully before proceeding',
      autoPlay: false,
      loop: false,
      width: 400,
      height: 225,
      externalLink: 'https://example.com/more-info',
    ),
  ],
  answerFormat: SingleChoiceAnswerFormat(
    choices: [
      TextChoice(text: 'Yes, I understood'),
      TextChoice(text: 'Please repeat'),
    ],
  ),
);
```

### JSON

```json
{
  "type": "video",
  "url": "https://example.com/video/intro.mp4",
  "title": "Introduction",
  "subtitle": "Please watch fully before proceeding",
  "autoPlay": false,
  "loop": false,
  "width": 400,
  "height": 225,
  "externalLink": "https://example.com/more-info"
}
```

---

## VideoContent properties

| Property | Type | Required | Description |
|---|---|---|---|
| `url` | `String` | ✅ | URL of the video file to play |
| `autoPlay` | `bool` | | Start playback automatically. Defaults to `false` |
| `loop` | `bool` | | Loop the video continuously. Defaults to `false` |
| `width` | `double?` | | Player width in logical pixels |
| `height` | `double?` | | Player height in logical pixels |
| `title` | `String?` | | Title displayed above the player |
| `subtitle` | `String?` | | Subtitle displayed below the title |
| `externalLink` | `String?` | | URL shown as a tappable link beneath the player |

---

## Related packages

| Package | Description |
|---|---|
| [survey_kit](https://pub.dev/packages/survey_kit) | Core survey library |
| [survey_kit_audio](https://pub.dev/packages/survey_kit_audio) | Audio content plugin |
| [survey_kit_lottie](https://pub.dev/packages/survey_kit_lottie) | Lottie animation plugin |
