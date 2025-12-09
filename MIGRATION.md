# Migration Guide 1.0 -> 2.0

With the release of version 2.0.0, we have modularized `survey_kit` to allow for a more lightweight core package. This guide outlines the changes and how to migrate your existing project.

## Breaking Changes

### Modularization of Audio and Video Steps

The audio and video steps have been moved to their own packages: `survey_kit_audio` and `survey_kit_video`. This reduces the size of the core package and allows you to include only the dependencies you need.

#### Action Required:

If you are using `AudioContent` or `VideoContent`, you need to add the respective packages to your `pubspec.yaml`.

```yaml
dependencies:
  survey_kit: ^2.0.0
  # Add these if you use audio or video steps
  survey_kit_audio: ^2.0.0
  survey_kit_video: ^2.0.0
```

### Imports

You will need to update your imports to include the new packages where necessary.

**Before:**
```dart
import 'package:survey_kit/survey_kit.dart';
```

**After:**
```dart
import 'package:survey_kit/survey_kit.dart';
// Add if using audio features
import 'package:survey_kit_audio/survey_kit_audio.dart';
// Add if using video features
import 'package:survey_kit_video/survey_kit_video.dart';
```

## Other Changes

- **Dependencies Updated:** We have updated internal dependencies to be compatible with the latest Flutter versions (3.19.0+).
- **Fixes:** Various bug fixes and improvements in the core logic.

## Summary

1.  Update `survey_kit` to `^2.0.0`.
2.  Add `survey_kit_audio` or `survey_kit_video` if you use those features.
3.  Update imports in your Dart files.

If you encounter any issues during migration, please open an issue on our [GitHub repository](https://github.com/quickbirdstudios/survey_kit/issues).
