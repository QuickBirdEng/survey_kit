# Migration Guide 1.x -> 2.0.0

Version `2.0.0` introduces a plugin/registry architecture and splits
media features into dedicated packages. Use the checklist below to migrate
safely.

## Migration Checklist

1. Update dependencies.
2. Rename `Task.initalStep` to `Task.initialStep`.
3. Update imports for media plugins (if used).
4. Register media plugins in `SurveyKit`.
5. Migrate custom answer/content rendering to builders.
6. Register JSON converters for custom/media types (if using JSON surveys).
7. Verify localization delegates in your `MaterialApp`.
8. Prefer `SurveyFlow` over legacy `OrderedTask`/`NavigableTask`.
9. Prefer `SurveyDefinition.fromJson` over legacy `Task.fromJson`.
10. Update `onCloseSurvey` callback signature (remove `BuildContext` parameter).
11. Migrate `ConditionalNavigationRule.resultToStepIdentifierMapper` return type from `String?` to `NavigationTarget`.

## 1) Dependencies

```yaml
dependencies:
  survey_kit: 2.0.0-beta1
  # add only what you use:
  survey_kit_audio: 2.0.0-beta1
  survey_kit_video: 2.0.0-beta1
  survey_kit_lottie: 2.0.0-beta1
```

## 2) Task API Rename (Breaking)

The `Task` property name has been corrected:

- Before: `initalStep`
- After: `initialStep`

Notes:
- This is a source-breaking API rename and should be treated as required
  migration work for `2.0.0`.
- JSON deserialization keeps backward compatibility for legacy payloads that
  still contain `initalStep`, while serialization writes `initialStep`.

Example:

```dart
final task = SurveyFlow(
  id: 'example',
  steps: steps,
  initialStep: steps.first,
);
```

## 2b) Unified Task Model

`SurveyFlow` now represents both sequential and branching flows:

- Use `SurveyFlow(..., navigationRules: {})` for linear surveys.
- Add rules for branching behavior.
- Use `SurveyDefinition` as the canonical abstract type.
- `Task` is kept as a deprecated alias for `SurveyDefinition`.
- `OrderedTask` and `NavigableTask` are kept as deprecated wrappers.

Example:

```dart
final task = SurveyFlow(
  id: 'example',
  steps: steps,
  initialStep: steps.first,
  navigationRules: {
    'q1': ConditionalNavigationRule(
      resultToStepIdentifierMapper: (_, input) {
        final answer = input?.result as BooleanResult?;
        if (answer == BooleanResult.positive) return const NavigateToStep('yes_step');
        if (answer == BooleanResult.negative) return const NavigateToStep('no_step');
        return const NavigateToNextInList();
      },
    ),
  },
);
```

JSON entrypoint:

```dart
final survey = SurveyDefinition.fromJson(payload);
```

## 3) Imports

```dart
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/survey_kit_audio.dart';
import 'package:survey_kit_video/survey_kit_video.dart';
import 'package:survey_kit_lottie/survey_kit_lottie.dart';
```

Only import plugin packages you actually use.

## 4) Register Media Plugins

Media content (`AudioContent`, `VideoContent`, `LottieContent`) is no longer
part of the core renderer. Register plugins through `registries`:

```dart
SurveyKit(
  task: task,
  onResult: onResult,
  registries: [
    SurveyKitAudio(),
    SurveyKitVideo(),
    SurveyKitLottie(),
  ],
);
```

## 5) Migrate Custom Answer/Content Rendering

`AnswerFormat` and `Content` should now be pure models. Rendering is registered
via builders.

### Before (1.x style)

```dart
class MyAnswerFormat extends AnswerFormat {
  @override
  Widget createView(Step step, StepResult? result) => MyAnswerView(...);
}
```

### After (2.0.0-beta1 style)

```dart
class MyAnswerFormat extends AnswerFormat {
  // model only (no createView)
}

class MyContent extends Content {
  // model only (no createWidget)
}

SurveyKit(
  task: task,
  onResult: onResult,
  answerViewBuilders: {
    MyAnswerFormat: (format, step, result) => MyAnswerView(...),
  },
  contentWidgetBuilders: {
    MyContent: (content) => MyContentWidget(...),
  },
);
```

You can also provide these through your own `SurveyKitPlugin`.

## 6) JSON Deserialization Registration

`AnswerFormat.fromJson` and `Content.fromJson` are now registry-based. If you
use custom types (or plugin content in JSON), register converters before
deserializing:

```dart
AnswerFormat.registerFromJson(
  'my_custom_answer',
  MyAnswerFormat.fromJson,
);

Content.registerFromJson(
  'my_custom_content',
  MyContent.fromJson,
);

// plugin content types (when used in JSON payloads)
Content.registerFromJson(AudioContent.type, AudioContent.fromJson);
Content.registerFromJson(VideoContent.type, VideoContent.fromJson);
Content.registerFromJson(LottieContent.type, LottieContent.fromJson);
```

## 7) Localization Setup

Ensure your app includes SurveyKit and Flutter localization delegates:

```dart
MaterialApp(
  localizationsDelegates: const [
    SurveyKitLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: SurveyKitLocalizations.supportedLocales,
)
```

## 10) `SurveyController.closeSurvey` — No BuildContext (Breaking)

`closeSurvey` no longer accepts a `BuildContext`. The context is resolved
internally via the navigator key that `SurveyKit` attaches automatically.

### `closeSurvey` call sites

```dart
// Before
surveyController.closeSurvey(context: context);

// After
surveyController.closeSurvey();
```

### `onCloseSurvey` callback

```dart
// Before
SurveyController(
  onCloseSurvey: (BuildContext context, StepResult? result) {
    // ...
  },
);

// After
SurveyController(
  onCloseSurvey: (StepResult? result) {
    // ...
  },
);
```

## 11) `ConditionalNavigationRule` — `NavigationTarget` Return Type (Breaking)

`resultToStepIdentifierMapper` now returns `NavigationTarget` instead of
`String?`. This enables explicitly finishing the survey from within a rule.

| Old return value | New return value |
|---|---|
| `'step_id'` | `NavigateToStep('step_id')` |
| `null` (next in list) | `NavigateToNextInList()` |
| *(not possible)* | `FinishSurvey()` |

### Before

```dart
ConditionalNavigationRule(
  resultToStepIdentifierMapper: (_, input) {
    final answer = input?.result as BooleanResult?;
    if (answer == BooleanResult.positive) return 'yes_step';
    return null;
  },
)
```

### After

```dart
ConditionalNavigationRule(
  resultToStepIdentifierMapper: (_, input) {
    final answer = input?.result as BooleanResult?;
    if (answer == BooleanResult.positive) return const NavigateToStep('yes_step');
    if (answer == BooleanResult.negative) return const FinishSurvey();
    return const NavigateToNextInList();
  },
)
```

### JSON surveys

To finish the survey from a JSON `values` map, use the sentinel value
`'__finish__'` (also available as `FinishSurvey.jsonValue`):

```json
{
  "type": "conditional",
  "values": {
    "skip": "__finish__",
    "continue": "next_step_id"
  }
}
```

## Notes

- Core package remains focused on survey models + default UI.
- Media and advanced extension points are now opt-in.
- For issues, use [GitHub Issues](https://github.com/quickbirdstudios/survey_kit/issues).
