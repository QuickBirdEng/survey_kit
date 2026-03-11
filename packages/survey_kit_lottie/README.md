# survey_kit_lottie

Lottie animation plugin for [survey_kit](https://pub.dev/packages/survey_kit) — display Lottie animations inside Flutter survey steps.

> **Part of the SurveyKit ecosystem.** See the [survey_kit package](https://pub.dev/packages/survey_kit) for the core library, full documentation, and all available plugins.

---

## Features

- Embed Lottie animations directly inside survey steps
- Load from a remote URL **or** a local asset
- Optional repeat/loop support
- Configurable width and height
- Drop-in registration via the `SurveyKitPlugin` registry system

---

## Installation

Add both packages to your `pubspec.yaml`:

```yaml
dependencies:
  survey_kit: ^2.0.0-beta1
  survey_kit_lottie: ^2.0.0-beta1
```

---

## Register the plugin

Pass `SurveyKitLottie()` to the `registries` parameter of `SurveyKit`:

```dart
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_lottie/survey_kit_lottie.dart';

SurveyKit(
  task: task,
  onResult: (SurveyResult result) { /* handle result */ },
  registries: [SurveyKitLottie()],
);
```

---

## Usage

### Dart — from a URL

```dart
import 'package:survey_kit_lottie/survey_kit_lottie.dart';

Step(
  content: [
    TextContent(text: 'Great job! Survey complete.'),
    LottieContent(
      url: 'https://assets.lottiefiles.com/packages/lf20_success.json',
      repeat: false,
      width: 200,
      height: 200,
    ),
  ],
);
```

### Dart — from a local asset

```dart
Step(
  content: [
    LottieContent(
      asset: 'assets/animations/checkmark.json',
      repeat: true,
      width: 150,
      height: 150,
    ),
  ],
);
```

> Make sure the asset is declared in your `pubspec.yaml`:
> ```yaml
> flutter:
>   assets:
>     - assets/animations/checkmark.json
> ```

### JSON

```json
{
  "type": "lottie",
  "url": "https://assets.lottiefiles.com/packages/lf20_success.json",
  "repeat": false,
  "width": 200,
  "height": 200
}
```

```json
{
  "type": "lottie",
  "asset": "assets/animations/checkmark.json",
  "repeat": true,
  "width": 150,
  "height": 150
}
```

---

## LottieContent properties

| Property | Type | Required | Description |
|---|---|---|---|
| `url` | `String?` | ✅ (or `asset`) | Remote URL of the Lottie JSON animation |
| `asset` | `String?` | ✅ (or `url`) | Local asset path of the Lottie JSON animation |
| `repeat` | `bool` | | Loop the animation continuously. Defaults to `false` |
| `width` | `double` | | Animation width in logical pixels. Defaults to `100` |
| `height` | `double` | | Animation height in logical pixels. Defaults to `100` |

> Either `url` or `asset` must be provided — not both.

---

## Related packages

| Package | Description |
|---|---|
| [survey_kit](https://pub.dev/packages/survey_kit) | Core survey library |
| [survey_kit_audio](https://pub.dev/packages/survey_kit_audio) | Audio content plugin |
| [survey_kit_video](https://pub.dev/packages/survey_kit_video) | Video content plugin |
