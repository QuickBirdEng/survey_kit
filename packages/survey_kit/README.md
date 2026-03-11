<p align="center">
<img src="https://github.com/quickbirdstudios/survey_kit/blob/main/example/assets/surveykit_logo.png?raw=true" width="500">
</p>

# SurveyKit: Create beautiful surveys with Flutter (inspired by [iOS ResearchKit Surveys](https://researchkit.org/docs/docs/Survey/CreatingSurveys.html))

Do you want to display a questionnaire to get the opinion of your users? A survey for a medical trial? A series of instructions in a manual-like style?
SurveyKit is a Flutter library that allows you to create exactly that.

Thematically it is built to provide a feeling of a professional research survey. The library aims to be visually clean, lean and easily configurable.
We aim to keep the functionality close to [iOS ResearchKit Surveys](https://researchkit.org/docs/docs/Survey/CreatingSurveys.html). We also created a SurveyKit version for native Android developers, [check it out here](https://github.com/quickbirdstudios/SurveyKit)

# Examples
###### Flow
<p align="center">
<img src="https://github.com/quickbirdstudios/survey_kit/blob/main/example/assets/survey-kit-demo.gif?raw=true" width="350">
</p>


## 📚 Overview
- [What SurveyKit does for you](#what-surveykit-does-for-you)
- [🏃 Setup](#-setup)
- [💻 Usage](#-usage)
  - [Create steps](#create-steps)
  - [Create a survey](#create-a-survey)
  - [Branching surveys](#branching-surveys)
  - [Evaluate the results](#evaluate-the-results)
  - [Style](#style)
  - [Localization](#localization)
- [🔌 Plugin packages](#-plugin-packages)
- [📇 Custom rendering](#-custom-rendering)
- [🤖 JSON support](#-json-support)
- [👤 Author](#-author)
- [❤️ Contributing](#️-contributing)
- [📃 License](#-license)

## What SurveyKit does for you
- Simplifies the creation of surveys
- Provides rich animations and transitions out of the box
- Built with a consistent, lean, simple style to fit research purposes
- Survey navigation can be linear or based on a decision tree (directed graph)
- Gathers results and provides them in a convenient manner for further use
- Extensible answer and content rendering via a registry/plugin model
- Optional media plugins (`audio`, `video`, `lottie`)
- Gives you complete freedom on creating your own question types
- Provides an API and structure inspired by [iOS ResearchKit Surveys](https://researchkit.org/docs/docs/Survey/CreatingSurveys.html)

# 🏃 Setup

## 1. Add the dependency
`pubspec.yaml`
```yaml
dependencies:
  survey_kit: ^2.0.0-beta1
```

Add media packages only when you need them:
```yaml
dependencies:
  survey_kit_audio: ^2.0.0-beta1
  survey_kit_video: ^2.0.0-beta1
  survey_kit_lottie: ^2.0.0-beta1
```

## 2. Install it
```
flutter pub get
```

## 3. Import it
```dart
import 'package:survey_kit/survey_kit.dart';
```

# 💻 Usage

## Create steps
To build a survey, create a list of `Step` objects. Each step can have a title, body content, and an answer format:

```dart
final steps = [
  Step(
    id: 'intro',
    content: const [TextContent(text: 'Welcome to the survey')],
    buttonText: 'Start survey',
  ),
  Step(
    id: 'name',
    content: const [TextContent(text: 'What is your name?')],
    answerFormat: const TextAnswerFormat(hint: 'Your name'),
    buttonText: 'Continue',
  ),
  Step(
    id: 'age',
    content: const [TextContent(text: 'How old are you?')],
    answerFormat: const IntegerAnswerFormat(hint: 'Your age'),
    buttonText: 'Continue',
  ),
  Step(
    id: 'done',
    content: const [TextContent(text: 'Thanks for completing the survey!')],
    buttonText: 'Submit survey',
  ),
];
```

The following answer formats are supported:
- `TextAnswerFormat`
- `IntegerAnswerFormat`
- `ScaleAnswerFormat`
- `SingleChoiceAnswerFormat`
- `MultipleChoiceAnswerFormat`
- `BooleanAnswerFormat`

## Create a survey
Pass your steps to `SurveyFlow` and render it with the `SurveyKit` widget:

```dart
final task = SurveyFlow(id: 'my_survey', steps: steps);

SurveyKit(
  task: task,
  onResult: (SurveyResult result) {
    // inspect result.finishReason and result.results
  },
);
```

## Branching surveys
When `navigationRules` is empty, the flow is sequential. Use `ConditionalNavigationRule` to build decision trees:

```dart
final task = SurveyFlow(
  id: 'branching',
  steps: [
    Step(
      id: 'medication',
      content: const [TextContent(text: 'Are you using any medication?')],
      answerFormat: SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(id: 'yes', value: 'yes', text: 'Yes'),
          TextChoice(id: 'no', value: 'no', text: 'No'),
        ],
      ),
      buttonText: 'Continue',
    ),
    Step(id: 'yes-step', content: const [TextContent(text: 'Please list your medication.')], buttonText: 'Next'),
    Step(id: 'no-step', content: const [TextContent(text: 'Great, no medication needed.')], buttonText: 'Next'),
    Step(id: 'done', content: const [TextContent(text: 'Done!')], buttonText: 'Submit survey'),
  ],
  navigationRules: {
    'medication': ConditionalNavigationRule(
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

## Evaluate the results
When the survey finishes you receive a `SurveyResult` containing a list of `StepResult`s and the `FinishReason`:

```dart
SurveyKit(
  task: task,
  onResult: (SurveyResult result) {
    // result.finishReason — completed, discarded, etc.
    // result.results — list of StepResult
    final jsonResult = result.toJson();
  },
);
```

## Style
Styling is done through Flutter's standard theming. SurveyKit adapts to your `ThemeData` automatically.

## Localization
Add `SurveyKitLocalizations.delegate` to your app's localization delegates:

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

# 🔌 Plugin packages

Media and animation support is provided by dedicated packages. Register them via `registries`:

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

# 📇 Custom rendering

Provide custom builders directly to `SurveyKit` for one-off answer or content types:

```dart
SurveyKit(
  task: task,
  onResult: (result) {},
  answerViewBuilders: {
    MyAnswerFormat: (format, step, stepResult) => MyAnswerView(
      format: format as MyAnswerFormat,
    ),
  },
  contentWidgetBuilders: {
    MyContent: (content) => MyContentWidget(content as MyContent),
  },
);
```

For reusable extensions, implement `SurveyKitPlugin` and pass it via `registries`.

# 🤖 JSON support

Load a survey from JSON:

```dart
final survey = SurveyDefinition.fromJson(jsonMap);
```

For custom or plugin types, register JSON factories before deserializing:

```dart
AnswerFormat.registerFromJson('my_answer', MyAnswerFormat.fromJson);
Content.registerFromJson('my_content', MyContent.fromJson);

// Plugin types
Content.registerFromJson(AudioContent.type, AudioContent.fromJson);
Content.registerFromJson(VideoContent.type, VideoContent.fromJson);
Content.registerFromJson(LottieContent.type, LottieContent.fromJson);
```

# 👤 Author
This Flutter library is created with 💙 by [QuickBird Studios](https://quickbirdstudios.com/).

# ❤️ Contributing
Open an issue if you need help, if you found a bug, or if you want to discuss a feature request.

Open a PR if you want to make changes to SurveyKit.

# 📃 License
SurveyKit is released under an MIT license. See [License](LICENSE) for more information.