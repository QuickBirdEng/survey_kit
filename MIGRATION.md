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
12. Rename `textChoices` → `choices` on choice answer formats.
13. Rename `BooleanAnswerFormat.result` → `BooleanAnswerFormat.defaultValue`.
14. Update `SurveyController` override callbacks to accept a `proceed` parameter.
15. Update `QuestionAnswer` usage in custom `stepShell` (if applicable).
16. Coming from 2.0.0-beta4: apply the follow-up changes in section 16.

## 1) Dependencies

```yaml
dependencies:
  survey_kit: ^2.0.0-beta4
  # add only what you use:
  survey_kit_audio: ^2.0.0-beta4
  survey_kit_video: ^2.0.0-beta4
  survey_kit_lottie: ^2.0.0-beta4
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

### After (2.0.0 style)

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

## 8) Prefer `SurveyFlow` over `OrderedTask` / `NavigableTask`

`OrderedTask` and `NavigableTask` still compile but are deprecated wrappers
around `SurveyFlow`. Replace them directly:

```dart
// Before
final task = OrderedTask(id: 'survey', steps: steps);
final branching = NavigableTask(id: 'survey', steps: steps);
branching.addNavigationRule(
  forTriggerStepIdentifier: steps[1].id,
  navigationRule: ConditionalNavigationRule(...),
);

// After
final task = SurveyFlow(id: 'survey', steps: steps);
final branching = SurveyFlow(
  id: 'survey',
  steps: steps,
  navigationRules: {
    steps[1].id: ConditionalNavigationRule(...),
  },
);
```

## 9) Prefer `SurveyDefinition.fromJson` over `Task.fromJson`

`Task` is a deprecated alias for `SurveyDefinition`. Deserialize surveys
through the new entrypoint and type variables as `SurveyDefinition`:

```dart
// Before
final Task task = Task.fromJson(payload);

// After
final SurveyDefinition survey = SurveyDefinition.fromJson(payload);
```

Register JSON converters for custom and plugin types (section 6) before
calling `fromJson`.

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

## 12 & 13) Answer Format Property Renames (Breaking)

### `textChoices` → `choices`

`MultipleChoiceAnswerFormat`, `SingleChoiceAnswerFormat`, and
`MultipleChoiceAutoCompleteAnswerFormat` renamed the `textChoices` parameter
to `choices`. The JSON key is unchanged (`textChoices`), so stored JSON
surveys do not need updating.

```dart
// Before
MultipleChoiceAnswerFormat(
  textChoices: [TextChoice(id: 'a', value: 'a', text: 'Option A')],
)
SingleChoiceAnswerFormat(
  textChoices: [TextChoice(id: 'a', value: 'a', text: 'Option A')],
)

// After
MultipleChoiceAnswerFormat(
  choices: [TextChoice(id: 'a', value: 'a', text: 'Option A')],
)
SingleChoiceAnswerFormat(
  choices: [TextChoice(id: 'a', value: 'a', text: 'Option A')],
)
```

### `BooleanAnswerFormat.result` → `defaultValue`

The pre-selected value on `BooleanAnswerFormat` is renamed from `result` to
`defaultValue` for consistency with other answer formats. The JSON key is
unchanged (`result`).

```dart
// Before
BooleanAnswerFormat(
  positiveAnswer: 'Yes',
  negativeAnswer: 'No',
  result: BooleanResult.positive,
)

// After
BooleanAnswerFormat(
  positiveAnswer: 'Yes',
  negativeAnswer: 'No',
  defaultValue: BooleanResult.positive,
)
```

## 14) `SurveyController` Callbacks — `proceed` Parameter (Breaking)

`onNextStep`, `onStepBack`, and `onCloseSurvey` now receive a `proceed`
callback as their last argument. Call `proceed()` to continue with the default
navigation behaviour. This replaces the previous pattern of manually calling
`SurveyStateProvider.of(context).onEvent(...)`.

```dart
// Before
SurveyController(
  onNextStep: (context, stepResult) {
    // custom logic...
    SurveyStateProvider.of(context).onEvent(NextStep(stepResult));
  },
  onStepBack: (context, stepResult) {
    SurveyStateProvider.of(context).onEvent(StepBack(stepResult));
  },
  onCloseSurvey: (context, stepResult) {
    SurveyStateProvider.of(context).onEvent(CloseSurvey(stepResult));
  },
);

// After
SurveyController(
  onNextStep: (context, stepResult, proceed) {
    // custom logic...
    proceed();
  },
  onStepBack: (context, stepResult, proceed) {
    proceed();
  },
  onCloseSurvey: (stepResult, proceed) {
    proceed();
  },
);
```

You can delay calling `proceed()` for async flows (e.g. showing a page before
continuing):

```dart
onNextStep: (context, stepResult, proceed) {
  Navigator.of(context).push(...).then((_) => proceed());
},
```

## 15) `QuestionAnswer` — Custom `stepShell` (Breaking)

If you use a custom `stepShell` and access `QuestionAnswer.of(context)`,
the following APIs have changed:

| Before | After |
|---|---|
| `questionAnswer.isValid` (`ValueNotifier<bool>`) | `questionAnswer.isValid` (`bool`) |
| `questionAnswer.setIsValid(value)` | `questionAnswer.onValidityChanged(value)` |
| `questionAnswer.setStepResult(result)` | `questionAnswer.onResultChanged(result)` |

Since `isValid` is now a plain `bool` on an `InheritedWidget`, you no longer
need `ValueListenableBuilder` — the widget rebuilds automatically when validity
changes:

```dart
// Before
stepShell: (step, answerWidget, context) {
  final qa = QuestionAnswer.of(context);
  return ValueListenableBuilder<bool>(
    valueListenable: qa.isValid,
    builder: (context, isValid, _) {
      return OutlinedButton(
        onPressed: isValid ? () => controller.next(...) : null,
        child: Text(step.buttonText ?? 'Next'),
      );
    },
  );
},

// After
stepShell: (step, answerWidget, context) {
  final qa = QuestionAnswer.of(context);
  return OutlinedButton(
    onPressed: qa.isValid ? () => controller.next(...) : null,
    child: Text(step.buttonText ?? 'Next'),
  );
},
```

## 16) Changes after 2.0.0-beta4

### Closing a survey

`closeSurvey` accepts an optional `context` again, and the new `onClose`
callback receives it. `onCloseSurvey` still works but is deprecated.

```dart
// Before
SurveyController(
  onCloseSurvey: (StepResult? result, void Function() proceed) {
    proceed();
  },
);

// After
SurveyController(
  onClose: (BuildContext context, StepResult? result, void Function() proceed) {
    proceed();
  },
);
```

### State stream

```dart
// Before
SurveyStateProvider.of(context).surveyStateStream.stream
// After
SurveyStateProvider.of(context).stateStream
```

### Answer formats

Passing `answerType:` to a built-in answer format is deprecated; each format
sets its own type. Remove the argument unless a subclass needs a custom type
string.

### Navigation rules

`NavigationRule` gained `resolve(previousResults, questionResult)`. Custom
rules should `extend NavigationRule` and override `resolve`. Register custom
rule types for JSON with `NavigationRule.registerFromJson`. Rules pointing at
a missing step now throw a `StateError` naming the step.

`SurveyFlow.navigationRules` is read-only; use `addNavigationRule`.

### Results

- `SurveyResult.results` is ordered by visit. When the user goes back and
  then takes a different path, answers from the abandoned path are dropped.
- `StepResult.toJson` encodes typed values and adds a `resultType` field.
  Custom result types need `StepResult.registerResultCodec` to round-trip.

### Content JSON

Content `toJson` now writes `type`, and `Content.fromJson` throws a
`FormatException` when it is missing or unknown.

### Theming

`textFieldInputDecoration(context, hint: ...)` now takes a `BuildContext`.
`SurveyProgressConfiguration.progressbarColor` (the track) defaults to the
theme's `surfaceContainerHighest` when omitted; `valueProgressbarColor`
defaults to `primary`.

## Notes

- Core package remains focused on survey models + default UI.
- Media and advanced extension points are now opt-in.
- For issues, use [GitHub Issues](https://github.com/QuickBirdEng/survey_kit/issues).
