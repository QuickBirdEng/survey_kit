<p align="center">
<img src="https://github.com/quickbirdstudios/survey_kit/blob/main/example/assets/surveykit_logo.png?raw=true" width="500">
</p>

# SurveyKit: Create beautiful surveys with Flutter (inspired by [iOS ResearchKit Surveys](https://researchkit.org/docs/docs/Survey/CreatingSurveys.html))

Do you want to display a questionnaire to get the opinion of your users? A survey for a medical trial? A series of instructions in a manual-like style?   
SurveyKit is an Flutter library that allows you to create exactly that.

Thematically it is built to provide a feeling of a professional research survey. The library aims to be visually clean, lean and easily configurable.
We aim to keep the functionality close to [iOS ResearchKit Surveys](https://researchkit.org/docs/docs/Survey/CreatingSurveys.html). We also created a SurveyKit version for native Android developers, [check it out here](https://github.com/quickbirdstudios/SurveyKit)

## What survey_kit does for you
- Linear surveys
- Branching surveys with explicit navigation rules
- Context-free imperative navigation through `SurveyController`
- Extensible answer/content rendering via a registry/plugin model
- Optional media plugins (`audio`, `video`, `lottie`)

## Packages

This repository is a monorepo with:
- `survey_kit` (core)
- `survey_kit_audio`
- `survey_kit_video`
- `survey_kit_lottie`

## Installation

```yaml
dependencies:
  survey_kit: ^2.0.0-beta1
```

Add media packages only when you use them:

```yaml
dependencies:
  survey_kit_audio: ^2.0.0-beta1
  survey_kit_video: ^2.0.0-beta1
  survey_kit_lottie: ^2.0.0-beta1
```

Then run:

```bash
flutter pub get
```

## Localization Setup

```dart
MaterialApp(
  localizationsDelegates: const [
    SurveyKitLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: SurveyKitLocalizations.supportedLocales,
)
```

## Quick Start (Linear Flow)

```dart
import 'package:survey_kit/survey_kit.dart';

final task = SurveyFlow(
  id: 'onboarding',
  steps: [
    Step(
      id: 'intro',
      content: const [
        TextContent(text: 'Welcome to the survey'),
      ],
      buttonText: 'Start',
    ),
    Step(
      id: 'name',
      content: const [
        TextContent(text: 'What is your name?'),
      ],
      answerFormat: const TextAnswerFormat(
        hint: 'Name',
      ),
      buttonText: 'Continue',
    ),
    Step(
      id: 'done',
      content: const [
        TextContent(text: 'Thanks!'),
      ],
      buttonText: 'Finish',
    ),
  ],
);

SurveyKit(
  task: task,
  onResult: (SurveyResult result) {
    // inspect result.finishReason and result.results
  },
);
```

## Branching Flow

`SurveyFlow` is the canonical survey model for both linear and branching flows.
If `navigationRules` is empty, flow is sequential.

```dart
final branchingTask = SurveyFlow(
  id: 'branching',
  steps: [
    Step(
      id: 'route',
      content: const [TextContent(text: 'Do you agree?')],
      answerFormat: SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(id: 'yes', value: 'yes', text: 'Yes'),
          TextChoice(id: 'no', value: 'no', text: 'No'),
        ],
      ),
      buttonText: 'Continue',
    ),
    Step(
      id: 'yes-step',
      content: const [TextContent(text: 'Great')],
      buttonText: 'Next',
    ),
    Step(
      id: 'no-step',
      content: const [TextContent(text: 'Thanks for your feedback')],
      buttonText: 'Next',
    ),
  ],
  navigationRules: {
    'route': ConditionalNavigationRule(
      resultToStepIdentifierMapper: (_, input) {
        final choice = input?.result as TextChoice?;
        if (choice?.id == 'yes') return const NavigateToStep('yes-step');
        if (choice?.id == 'no') return const NavigateToStep('no-step');
        return const NavigateToNextInList();
      },
    ),
  },
);
```

## SurveyController (Imperative Navigation)

When a controller is passed into `SurveyKit`, you can navigate without passing
`BuildContext` manually:

```dart
final controller = SurveyController();

SurveyKit(
  task: task,
  surveyController: controller,
  onResult: (result) {},
);

controller.next();
controller.stepBack();
controller.closeSurvey();
```

You can still override navigation with:
- `onNextStep`
- `onStepBack`
- `onCloseSurvey`

## Media Plugins

Media rendering is split into dedicated packages. Register plugins through
`registries`so you don't need to worry about dependency issues:

```dart
import 'package:survey_kit_audio/survey_kit_audio.dart';
import 'package:survey_kit_video/survey_kit_video.dart';
import 'package:survey_kit_lottie/survey_kit_lottie.dart';

SurveyKit(
  task: task,
  onResult: (result) {},
  registries: [
    SurveyKitAudio(),
    SurveyKitVideo(),
    SurveyKitLottie(),
  ],
);
```

## Custom Answer/Content Rendering

Provide custom builders directly to `SurveyKit`:

```dart
SurveyKit(
  task: task,
  onResult: (result) {},
  answerViewBuilders: {
    MyCustomAnswerFormat: (answerFormat, step, stepResult) =>
        MyCustomAnswerView(
      format: answerFormat as MyCustomAnswerFormat,
      step: step,
      stepResult: stepResult,
    ),
  },
  contentWidgetBuilders: {
    MyCustomContent: (content) => MyCustomContentWidget(
      content as MyCustomContent,
    ),
  },
);
```

For reusable extensions, create a `SurveyKitPlugin` and pass it via
`registries`.

## JSON Support

Load surveys with:

```dart
final survey = SurveyDefinition.fromJson(jsonMap);
```

For custom answer/content types, register JSON factories before deserializing:

```dart
AnswerFormat.registerFromJson('my_answer', MyCustomAnswerFormat.fromJson);
Content.registerFromJson('my_content', MyCustomContent.fromJson);
```

For plugin content in JSON:

```dart
Content.registerFromJson(AudioContent.type, AudioContent.fromJson);
Content.registerFromJson(VideoContent.type, VideoContent.fromJson);
Content.registerFromJson(LottieContent.type, LottieContent.fromJson);
```

## Legacy Compatibility

Legacy APIs remain available as deprecated compatibility layers:
- `Task` (alias for `SurveyDefinition`)
- `OrderedTask`
- `NavigableTask`
- `InstructionStep`, `QuestionStep`, `CompletionStep`

Prefer `SurveyFlow` + `Step` for new code.

## Example App

Run the example app:

```bash
cd example
flutter run
```

## Migration

See [MIGRATION.md](MIGRATION.md) for 1.x to 2.x changes.

# 👤 Author
This Flutter library is created with 💙 by [QuickBird Studios](https://quickbirdstudios.com/).

# ❤️ Contributing
Open an issue if you need help, if you found a bug, or if you want to discuss a feature request.

Open a PR if you want to make changes to SurveyKit.

# 📃 License
SurveyKit is released under an MIT license. See [License](LICENSE) for more information.
