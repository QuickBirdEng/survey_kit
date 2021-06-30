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