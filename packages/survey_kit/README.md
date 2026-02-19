# survey_kit

Create beautiful surveys with Flutter, inspired by iOS ResearchKit.

## Installation

```yaml
dependencies:
  survey_kit: 2.0.0-beta1
```

## Basic usage

```dart
SurveyKit(
  task: task,
  onResult: (result) {
    // Handle SurveyResult
  },
);
```

Use `SurveyFlow` as the survey model and `SurveyDefinition.fromJson(...)` for
JSON loading. Legacy `Task`, `FlowTask`, `OrderedTask`, and `NavigableTask`
remain available as deprecated compatibility APIs.

`SurveyController` now supports context-free imperative navigation once it is
passed into `SurveyKit`:
- `controller.next(stepResult: ...)`
- `controller.stepBack()`
- `controller.closeSurvey()`

## Localization setup

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

## Plugin packages

Media and animation support is provided by dedicated plugin packages:

- `survey_kit_audio`
- `survey_kit_video`
- `survey_kit_lottie`

For full examples and migration details, see:
- https://github.com/quickbirdstudios/survey_kit/blob/main/README.md
- https://github.com/quickbirdstudios/survey_kit/blob/main/MIGRATION.md
