# Unreleased

- **FIX**: Depends on `survey_kit: ^2.0.0-beta4` instead of an exact version.
- **FIX**: `VideoContent.toJson()` includes the `type` key.
- **FIX**: The web player uses `package:web` instead of `universal_html` and
  creates its own `<video>` element per player, so it compiles to Wasm and
  respects per-player settings for repeated URLs.
- **FIX**: The native player reloads when its URL or options change and offers
  a retry when loading fails.

# 2.0.0-beta4

- **CHORE**: Now developed and tested against Flutter 3.47.2 / Dart 3.13.2.
- **BREAKING** **CHORE**: Requires Dart `^3.12.0` / Flutter `>=3.44.0`, which
  is forced by `video_player` 2.14.0. Apps on older Flutter versions must stay
  on 2.0.0-beta3 or raise their SDK.
- **CHORE**: Dependency upgrades — `video_player` 2.14.0, `chewie` 1.15.0,
  `universal_html` 2.3.0, `json_annotation` 4.12.0.

# 2.0.0-beta3

- **FIX**: `SurveyKitVideoPlayer` no longer crashes with a
  `LateInitializationError` when it is disposed before the video finished
  initializing; also guards against `setState` after dispose.
- **FIX**: `SurveyKitVideoPlayer` shows an error placeholder when the video
  fails to load (e.g. HTTP errors) instead of spinning forever with an
  unhandled exception.

# 2.0.0-beta2

- **CHORE**: Bump version to 2.0.0-beta2.

# 2.0.0-beta1

- Initial standalone release of SurveyKit video support.
- Adds `VideoContent` and `SurveyKitVideo` plugin registration.
