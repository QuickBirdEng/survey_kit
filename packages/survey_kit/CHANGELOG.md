# 2.0.0-beta4

- **CHORE**: Now developed and tested against Flutter 3.47.2 / Dart 3.13.2.
  The `environment` constraints are corrected to what dependencies actually
  require: Dart `^3.9.0` / Flutter `>=3.35.0`. The previous
  `flutter: ">=2.0.0"` floor was inaccurate.
- **CHORE**: Dependency upgrades — `json_annotation` 4.12.0, `url_launcher`
  6.3.2, `uuid` 4.6.0, `flutter_markdown_plus` 1.0.12. Declared constraint
  floors are kept at the lowest workable version rather than pinned to the
  newest, so apps with tighter pins can still resolve.
- **FIX**: Code generation no longer fails. `build_runner` was walking the
  nested example app's plugin symlinks; a `build.yaml` now scopes its sources
  to `lib/` and `test/`.
- **FIX**: Removed the no-op `@JsonSerializable()` annotations from the
  abstract `AnswerFormat` and `Content` base classes. They had no `part`
  directive, so they generated nothing and only produced build warnings. No
  API change.
- **FIX**: Dropped the deprecated `synthetic-package` key from `l10n.yaml`.
  Generated localizations are unchanged.

# 2.0.0-beta3

- **FIX**: `withSeparator` no longer emits a trailing separator, which removed
  the extra spacing below the last item in `ContentWidget`.
- **FIX**: `ContentWidget.padding` is now actually applied. It previously had
  no effect; the default changed from `EdgeInsets.all(16)` to
  `EdgeInsets.zero` to match the previous rendering.
- **FIX**: `ContentWidget` now skips content types without a registered
  builder instead of rendering empty placeholders (which produced stray
  separators).
- **FEAT**: Export `SurveyKitRegistry` so custom `ContentWidget`/`AnswerView`
  implementations can look up registered builders via
  `SurveyKitRegistry.of(context)`.
- **FEAT**: `ContentWidget` gained a `spacing` parameter to control the gap
  between content items (defaults to the previous value of 14).
- **FIX**: `SelectionListTile` now paints its background on a `Material`
  instead of a decorated `Container`, so tap ink splashes are visible again
  (newer Flutter versions report this as a framework error).

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
