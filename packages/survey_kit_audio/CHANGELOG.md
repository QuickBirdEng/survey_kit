# Unreleased

- **FIX**: Depends on `survey_kit: ^2.0.0-beta4` instead of an exact version.
- **FIX**: `AudioContent.toJson()` includes the `type` key.
- **FIX**: Shows a loading indicator, and an error state with retry when the
  audio fails to load. Replays from the start after completion, clamps the
  seek bar, renders `externalLink` and reloads when the URL changes.

# 2.0.0-beta4

- **CHORE**: Now developed and tested against Flutter 3.47.2 / Dart 3.13.2.
  The `environment` constraints are corrected to Dart `^3.9.0` / Flutter
  `>=3.35.0`; the previous `flutter: ">=2.0.0"` floor was inaccurate.
- **CHORE**: Dependency upgrades — `just_audio` 0.10.6, `json_annotation`
  4.12.0.

# 2.0.0-beta3

- **CHORE**: Bump version to 2.0.0-beta3.

# 2.0.0-beta2

- **CHORE**: Bump version to 2.0.0-beta2.

# 2.0.0-beta1

- Initial standalone release of SurveyKit audio support.
- Adds `AudioContent` and `SurveyKitAudio` plugin registration.
