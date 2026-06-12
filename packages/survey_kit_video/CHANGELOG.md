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
