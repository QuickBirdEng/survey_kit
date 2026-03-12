# 2.0.0-beta2

- **CHORE**: Bump version to 2.0.0-beta2.

# 2.0.0-beta1

## Required adjustments

1. Update dependencies to `survey_kit: 2.0.0-beta1`.
2. **BREAKING**: Rename `Task.initalStep` to `Task.initialStep`.
3. Add plugin packages only when needed:
   `survey_kit_audio`, `survey_kit_video`, `survey_kit_lottie`.
4. Register plugin packages through `SurveyKit(registries: [...])`.
5. Migrate custom answer/content rendering to registry builders:
   `answerViewBuilders` and `contentWidgetBuilders`.
6. Register JSON converters for custom/plugin types when deserializing:
   `AnswerFormat.registerFromJson` and `Content.registerFromJson`.
7. Ensure app localization delegates include `SurveyKitLocalizations.delegate`.
8. Prefer `SurveyDefinition.fromJson` over `Task.fromJson`
   (`Task` remains as a deprecated alias).

Full guide:
https://github.com/quickbirdstudios/survey_kit/blob/main/MIGRATION.md

## Highlights

- **BREAKING**: Introduced registry/plugin-based rendering and removed direct model/view coupling (`createView`/`createWidget` pattern).
- **BREAKING**: Renamed `Task.initalStep` to `Task.initialStep`.
- **BREAKING**: Moved media integrations to dedicated packages (`survey_kit_audio`, `survey_kit_video`, `survey_kit_lottie`).
- **FEATURE**: Added `SurveyFlow` as the unified task model for linear and branching surveys.
- **FEATURE**: Added `SurveyDefinition` as the canonical survey definition base type.
- **DEPRECATION**: `OrderedTask` and `NavigableTask` are now legacy wrappers around `SurveyFlow`.
- **REMOVED**: `FlowTask` — introduced and immediately deprecated in this version, removed before release. Use `SurveyFlow` directly.
- **DEPRECATION**: `Task` is now a legacy alias for `SurveyDefinition`.
- **FEATURE**: Added `SurveyKitRegistry` / `SurveyKitPlugin` extension points.
- **FEATURE**: Migrated localization to Flutter `gen_l10n` and `.arb` files.
- **CHORE**: Migrated to monorepo workflow and updated CI/publish automation.

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

# 1.0.3

- Refactored `SurveyStateProvider` to avoid reinstantiation on rebuilds.
