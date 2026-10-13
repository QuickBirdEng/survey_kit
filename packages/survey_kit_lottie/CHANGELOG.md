# Unreleased

- **FIX**: Depends on `survey_kit: ^2.0.0-beta4` instead of an exact version.
- **FIX**: `LottieContent.toJson()` includes the `type` key.
- **FIX**: Shows a placeholder while loading and an error icon when the
  animation cannot be loaded. `LottieContent.fromJson` throws a
  `FormatException` when neither `url` nor `asset` is set.

# 2.0.0-beta4

- **CHORE**: Now developed and tested against Flutter 3.47.2 / Dart 3.13.2.
- **BREAKING** **CHORE**: Requires Dart `^3.12.0` / Flutter `>=3.44.0`, which
  is forced by `lottie` 3.5.1. Apps on older Flutter versions must stay on
  2.0.0-beta3 or raise their SDK.
- **CHORE**: Dependency upgrades — `lottie` 3.5.1, `json_annotation` 4.12.0.

# 2.0.0-beta3

- **CHORE**: Bump version to 2.0.0-beta3.

# 2.0.0-beta2

- **CHORE**: Bump version to 2.0.0-beta2.

# 2.0.0-beta1

- Initial standalone release of SurveyKit Lottie support.
- Adds `LottieContent` and `SurveyKitLottie` plugin registration.
