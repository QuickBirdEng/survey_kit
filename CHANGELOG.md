# 2.0.0-beta2

- **CHORE**: Bump version to 2.0.0-beta2 across all packages.
- **DOC**: Updated README.md with new installation instructions.

# 2.0.0-beta1

## Required Adjustments (1.x -> 2.0.0-beta1)

1. Update dependencies to `survey_kit: 2.0.0-beta1`, and add media plugins only
   if needed: `survey_kit_audio`, `survey_kit_video`, `survey_kit_lottie`.
2. **BREAKING**: Rename `Task.initalStep` to `Task.initialStep`.
3. Update imports for any media plugin package you use.
4. Register media plugins through `SurveyKit(registries: [...])`.
5. Migrate custom `AnswerFormat`/`Content` rendering from model methods to
   `answerViewBuilders` and `contentWidgetBuilders` (or custom `SurveyKitPlugin`).
6. If you deserialize from JSON, register converters for custom and plugin
   types with `AnswerFormat.registerFromJson` and `Content.registerFromJson`.
7. Ensure localization delegates include `SurveyKitLocalizations.delegate` and
   Flutter localization delegates.
8. Prefer `SurveyDefinition.fromJson` over `Task.fromJson`
   (`Task` remains as a deprecated alias).

Full migration guide: [MIGRATION.md](MIGRATION.md)

## Highlights

- **BREAKING**: `ConditionalNavigationRule.resultToStepIdentifierMapper` now
  returns `NavigationTarget` instead of `String?`. Replace `'step_id'` with
  `NavigateToStep('step_id')`, `null` with `NavigateToNextInList()`, and use
  the new `FinishSurvey()` to end the survey early from a rule.
- **BREAKING**: Removed model-level `createView`/`createWidget` coupling and
  moved rendering to registry builders.
- **BREAKING**: Renamed `Task.initalStep` to `Task.initialStep`.
- **BREAKING**: Split media integrations into dedicated packages:
  `survey_kit_audio`, `survey_kit_video`, `survey_kit_lottie`.
- **FEATURE**: Added `SurveyFlow` as the unified task model for linear and
  branching surveys.
- **FEATURE**: Added `SurveyDefinition` as the canonical survey definition base
  type.
- **DEPRECATION**: `OrderedTask` and `NavigableTask` are now legacy wrappers
  around `SurveyFlow`.
- **REMOVED**: `FlowTask` — introduced and immediately deprecated in this
  version, removed before release. Use `SurveyFlow` directly.
- **DEPRECATION**: `Task` is now a legacy alias for `SurveyDefinition`.
- **FEATURE**: Added `SurveyKitRegistry`/`SurveyKitPlugin` and `registries`,
  `answerViewBuilders`, `contentWidgetBuilders`.
- **FEATURE**: Migrated localization generation to Flutter `gen_l10n` with
  `.arb` resources.
- **FIX**: Improved JSON serialization/deserialization consistency, including
  `TimeResult` generation and UTC DateTime handling.
- **TEST**: Improved test stability with deterministic setup.
- **CHORE**: Migrated to Melos monorepo workflow and added CI/publish
  automation.
- **DOCS**: Updated API docs for the registry architecture.

## Navigation/Controller Hardening

1. **FIX**: Hardened survey navigation transitions to avoid loading-route traps
   on empty/completed flows.
2. **FIX**: Stabilized navigation rule serialization/deserialization for JSON
   surveys (`type` handling + legacy compatibility).
3. **FIX**: Survey result emission is now deterministic and ordered by task step
   sequence.
4. **FIX**: Tightened state update propagation and cleaned dead/duplicate view
   artifacts in provider/view wiring.
5. **BREAKING**: Renamed `Task.initalStep` to `Task.initialStep`.
6. **FEATURE**: `SurveyController` now supports context-free imperative
   navigation when attached to `SurveyKit` (`next`, `stepBack`, `closeSurvey`).
7. **BREAKING**: `SurveyController.closeSurvey` no longer accepts a
   `BuildContext` parameter. The context is resolved internally via the
   navigator key. If you supply an `onCloseSurvey` callback, remove the
   `BuildContext` argument from its signature:
   `Function(StepResult?) onCloseSurvey`.
8. **FIX**: `QuestionAnswer.isValid` now initialises to `false` for mandatory
   steps instead of always `true`. Previously, the Next button on a mandatory
   step was enabled before the user had selected any answer.
9. **FIX**: `AnswerMixin.initValidation` added — call it in `initState` to sync
   a pre-filled or default answer into the validation state on first render.
   `SingleChoiceAnswerView` already calls this.
10. **FIX**: `ContentWidget` now correctly respects `center: false` —
    `mainAxisAlignment` was hardcoded to `center` regardless of the parameter.


# 1.0.3

- CHORE: Removed depracted lint `package_api_docs`
- FIX: Refactored SurveyStateProvider to follow proper InheritedWidget pattern - separated mutable state into StatefulWidget wrapper to prevent reinstantiation on rebuilds
- FIX: Fixed SurveyStateProvider state persistence by using SurveyStateProviderWidget (StatefulWidget) with immutable SurveyStateProvider (InheritedWidget)

# 1.0.2

- INFO: Update use `dart:ui_web`instead if `dart:ui`

# 1.0.1

- CHORE: Upgrade dependencies to latest Flutter Version 3.35.2

# 1.0.0-dev.10

- BREAKING: Removed image_picker for to avoid permission issues (Will be readded with 1.0.0 as separate package)

# 1.0.0-dev.9

- CHORE: Expose backgroundColor param for SurveyPage

# 1.0.0-dev.8

- INFO: Support AGP 8.x, bump compileSdk to 34

# 1.0.0-dev.7

- INFO: Updated dependencies to latest Flutter Version 3.24.5

# 1.0.0-dev.6

- INFO: Revert intl dependency to 0.18.1 because of Flutter incompatibility issues

# 1.0.0-dev.5

- INFO: Updated dependencies to latest Flutter Version 3.19.5

# 1.0.0-dev.4

- INFO: Revert intl dependency to 0.18.0

# 1.0.0-dev.3

- INFO: Update dependencies

# 1.0.0-dev.2

- BREAKING: `resultToStepIdentifierMapper` now also returns the previous results
  - (StepResult? result) -> (List<StepResult> results, StepResult? result)
- BUGFIX: Fixed a bug where `resultToStepIdentifierMapper` was not called when the result was null

# 1.0.0-dev.1

- INFO: We we completly reworked how survey_kit works and want to get it to a stable release version 1.0
- BREAKING: Enum BooleanResult is now lowercase
- BREAKING: Enum FinishReason is now lowercase
- BREAKING: Id's are now simple Strings
- BREAKING: TextChoice is not const anymore
- BREAKING: SurveyResult: Every Step has now one Result with a generic parameter instead of different objects
- BREAKING: Return typoe of the boolean step is now a TimeResult objects which wraps TimeOfDay
- FEATURE: survey_kit is now more dynamic and every content can be used before the question
  - VideoContent
  - AudioContent
  - MarkdownContent
  - TextContent
  - LottieContent
- FEATURE: MeasureDateStateMixin to measure when the user entered and left a step
- FEATURE: PreviousStepResultMixin: If one of your steps depends on a previous step just implement this mixin and you can access the previous result
- CHORE: Updated dependecies

HOW TO MIGRATE:

- JSON
- Code-Definition

# 0.1.2

- INFO: Update dependencies (Flutter 3.7.0)

# 0.1.1

- INFO: Update dependencies (Flutter 3.0.2)

# 0.1.0

- INFO: Updated dependencies

# 0.0.21

- BREAKING: Adapated text styles to to TextThemes - You can find a complete list in the README.md

# 0.0.20

- BREAKING: Value identifier for Single-/Multiplechoice answers is now the value
- BREAKING: You now have to close the survey yourself when finished in onResult
- BREAKING: Remove video player step for now because of dependency issues (If you rely on it use https://github.com/quickbirdstudios/survey_kit.git)

- FEATURE: Progressbar
- FEATURE: Transition between questions
- FEATURE: Localization of text

- BUGFIX: isOptional Flag works now as expected
- BUGFIX: Textinput does not spit text in half anymore
- BUGFIX: Text in Single-/Multiplechoice answers does now break the same if selected or unselected

- INFO: Updated dependencies

# 0.0.12

- FEATURE: Video-Step

- BUGFIX: isOptional Parameter works now as expected
- BUGFIX: DefaultSelection in SingleChoiceAnswer now works as expected
- BUGFIX: Use of TimePicker source

# 0.0.11

- BREAKING: 'TextAnswerFormat' 'isValid' Function is now just a regular expression
- BREAKING: Renamed Step 'id' to 'stepIdentifier' to make it more clearer for JSON use

- FEATURE: Survey can now be created via JSON
- FEATURE: Added documentation to the task definition

- BUGFIX: Survey - Navigator is not popped twice
- BUGFIX: Overflowing of text on ListTile
- BUGFIX: Added keys to different TextChoice to avoid falsly reapiting answers

# 0.0.10

- BREAKING: Migrated to null-safety
- BREAKING: Upgrade Dart SDK constraints to >=2.12.0-0 <3.0.0
- BREAKING: Expose SurveyController to add the possiblity to override the navigation (StepBack, NextStep and CloseSurvey)
- Flutter SurveyKit can now also be used with Web, MacOS, Linux and Windows (Not optimized)
- Updated platform dependend widgets to flutter_platform_widgets

# 0.0.2 - 0.0.8

- README updates
- Added additional licence information

# 0.0.1

Initial Version of the library.

- Includes the ability to create a surveys with prebuild and customs step.
