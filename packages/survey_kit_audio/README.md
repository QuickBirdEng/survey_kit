# survey_kit_audio

Audio content plugin for [survey_kit](https://pub.dev/packages/survey_kit) — add audio playback steps to your Flutter surveys.

> **Part of the SurveyKit ecosystem.** See the [survey_kit package](https://pub.dev/packages/survey_kit) for the core library, full documentation, and all available plugins.

---

## Features

- Embed audio players directly inside survey steps
- Support for remote URLs
- Optional auto-play, title, subtitle, and external link
- Drop-in registration via the `SurveyKitPlugin` registry system

---

## Installation

Add both packages to your `pubspec.yaml`:

```yaml
dependencies:
  survey_kit: ^2.0.0-beta1
  survey_kit_audio: ^2.0.0-beta1
```

---

## Register the plugin

Pass `SurveyKitAudio()` to the `registries` parameter of `SurveyKit`:

```dart
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/survey_kit_audio.dart';

SurveyKit(
  task: task,
  onResult: (SurveyResult result) { /* handle result */ },
  registries: [SurveyKitAudio()],
);
```

---

## Usage

### Dart

Add an `AudioContent` to a step's `content` list:

```dart
import 'package:survey_kit_audio/survey_kit_audio.dart';

Step(
  content: [
    TextContent(text: 'Listen to the following audio clip:'),
    AudioContent(
      url: 'https://example.com/audio/clip.mp3',
      title: 'Introduction',
      subtitle: 'Chapter 1',
      autoPlay: false,
      externalLink: 'https://example.com/transcript',
    ),
  ],
);
```

### JSON

```json
{
  "type": "audio",
  "url": "https://example.com/audio/clip.mp3",
  "title": "Introduction",
  "subtitle": "Chapter 1",
  "autoPlay": false,
  "externalLink": "https://example.com/transcript"
}
```

---

## AudioContent properties

| Property | Type | Required | Description |
|---|---|---|---|
| `url` | `String` | ✅ | URL of the audio file to play |
| `autoPlay` | `bool` | | Start playback automatically. Defaults to `false` |
| `title` | `String?` | | Title displayed above the player |
| `subtitle` | `String?` | | Subtitle displayed below the title |
| `externalLink` | `String?` | | URL shown as a tappable link beneath the player |

---

## Related packages

| Package | Description |
|---|---|
| [survey_kit](https://pub.dev/packages/survey_kit) | Core survey library |
| [survey_kit_video](https://pub.dev/packages/survey_kit_video) | Video content plugin |
| [survey_kit_lottie](https://pub.dev/packages/survey_kit_lottie) | Lottie animation plugin |
