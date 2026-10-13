# Unreleased

- **FIX** (`survey_kit`): Broad correctness pass over answer views, JSON
  serialization and navigation, with several breaking API changes. See
  `packages/survey_kit/CHANGELOG.md` and section 16 of `MIGRATION.md`.
- **CHORE**: Bumped the `.fvmrc` Flutter pin to 3.47.7 and refreshed the
  workspace lockfile to the latest compatible versions. Published constraint
  floors are unchanged.
- **CHORE**: CI now checks formatting and that generated code is up to date,
  and uses `actions/checkout@v6`.
- **CHORE**: CI also builds the example for web with `--wasm`. The publish
  workflow now runs the same format and codegen checks, dry-runs every
  package before publishing any, and skips versions already on pub.dev so a
  failed release can be re-run.
- **CHORE**: Melos scripts moved from the ignored `melos.yaml` into the
  `melos:` section of the root `pubspec.yaml`.
- **FIX** (`survey_kit`): Removed the stale `video_content.g.dart` left over
  from the plugin split. The web platform view registry is now selected with
  `dart.library.js_interop`, so it works when compiled to Wasm.
- **FIX** (plugins): `survey_kit_audio`, `survey_kit_lottie` and
  `survey_kit_video` now depend on `survey_kit: ^2.0.0-beta4` instead of an
  exact version. `toJson()` on `AudioContent`, `VideoContent` and
  `LottieContent` now includes the `type` key, so the output can be read back
  with `Content.fromJson`.
- **FIX** (`survey_kit_audio`): Shows a loading indicator, and an error state
  with retry when the audio fails to load. Replays from the start after
  completion, clamps the seek bar, renders `externalLink` and reloads when the
  URL changes.
- **FIX** (`survey_kit_video`): The web player uses `package:web` instead of
  `universal_html` and no longer reuses a cached platform view for repeated
  URLs, so it works with Wasm builds and respects per-player settings. The
  native player reloads when its URL or options change and offers a retry on
  errors.
- **FIX** (`survey_kit_lottie`): Shows a placeholder while loading and an
  error icon instead of failing silently or showing a developer message.
  `LottieContent.fromJson` throws a `FormatException` when neither `url` nor
  `asset` is set.
- **DOCS**: Fixed the README branching sample (`choices:`), the localization
  setup, the answer format list and image links. `MIGRATION.md` now uses
  `^2.0.0-beta4` and covers sections 8 and 9.
- **CHORE**: The example app adds a JSON-defined survey that uses every
  content type and plugin, and smoke tests for both surveys.

# 2.0.0-beta4

- **CHORE**: Upgraded the toolchain to Flutter 3.47.2 / Dart 3.13.2 (`.fvmrc`
  pin bumped from 3.41.4). CI now derives its Flutter version from `.fvmrc`
  instead of tracking `stable`, and runs `melos` from the workspace lockfile
  rather than a globally activated copy.
- **CHORE**: Upgraded all direct dependencies to their latest versions,
  including `lottie` 3.5.1, `video_player` 2.14.0, `chewie` 1.15.0,
  `flutter_markdown_plus` 1.0.12, `just_audio` 0.10.6, `json_annotation`
  4.12.0, `uuid` 4.6.0, `url_launcher` 6.3.2, `json_serializable` 6.14.1,
  `build_runner` 2.16.0 and `melos` 8.5.0. Declared constraint floors were
  kept at the lowest workable version rather than pinned to the newest, so
  downstream apps with tighter pins can still resolve.
- **CHORE**: SDK floors now reflect what dependencies actually require:
  `survey_kit` and `survey_kit_audio` require Dart `^3.9.0` / Flutter
  `>=3.35.0`; `survey_kit_lottie` and `survey_kit_video` require Dart
  `^3.12.0` / Flutter `>=3.44.0` (forced by `lottie` and `video_player`). The
  previous `flutter: ">=2.0.0"` floor was inaccurate.
- **CHORE**: The example app now uses **Swift Package Manager** for iOS and
  macOS. All plugins in the dependency graph ship Swift packages, so
  CocoaPods has been removed entirely: `Podfile`, `Podfile.lock`, the `Pods`
  integration in both Xcode projects, the `Pods.xcodeproj` workspace
  references and the `Pods-Runner` xcconfig includes are all gone. Minimum
  deployment targets moved to iOS 15.0 and macOS 12.0.
- **CHORE**: Upgraded the example app's Android toolchain to Android Gradle
  Plugin 9.1.0, Kotlin 2.4.0 and Gradle 9.3.1, with Java/Kotlin targets on
  17. Removed the obsolete `android.enableJetifier` flag and the explicit
  `kotlin-android` plugin (the Flutter Gradle Plugin applies it).
- **CHORE**: Replaced the long-ignored `analyzer.strong-mode` options with
  `language: strict-casts`, dropped the deprecated
  `avoid_null_checks_in_equality_operators` lint and the removed
  `missing_return` diagnostic, and the example now includes the root
  `analysis_options.yaml` instead of duplicating it.
- **FIX**: `build_runner` no longer walks the nested example app's plugin
  symlinks (added `packages/survey_kit/build.yaml` to scope its sources),
  which previously made codegen fail. Removed the no-op `@JsonSerializable()`
  annotations from the abstract `AnswerFormat` and `Content` base classes and
  the deprecated `synthetic-package` key from `l10n.yaml`.

# 2.0.0-beta3

- **FIX** (`survey_kit`): `withSeparator` no longer emits a trailing
  separator, which removed the extra spacing below the last item in
  `ContentWidget`.
- **FIX** (`survey_kit`): `ContentWidget.padding` is now actually applied and
  defaults to `EdgeInsets.zero`; unregistered content types are skipped
  instead of rendering empty placeholders.
- **FEAT** (`survey_kit`): Export `SurveyKitRegistry` so custom
  `ContentWidget`/`AnswerView` implementations can look up registered
  builders. `ContentWidget` gained a `spacing` parameter.
- **FIX** (`survey_kit`): `SelectionListTile` paints its background on a
  `Material` instead of a decorated `Container`, so tap ink splashes are
  visible again.
- **FIX** (`survey_kit_video`): No longer crashes with a
  `LateInitializationError` when the player is disposed before the video
  finished initializing; also guards against `setState` after dispose. Shows
  an error placeholder when the video fails to load instead of spinning
  forever.

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
