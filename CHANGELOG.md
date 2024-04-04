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