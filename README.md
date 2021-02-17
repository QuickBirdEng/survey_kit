# SurveyKit: Create beautiful surveys with Flutter (inspired by [iOS ResearchKit Surveys](http://researchkit.org/docs/docs/Survey/CreatingSurveys.html))

Do you want to display a questionnaire to get the opinion of your users? A survey for a medical trial? A series of instructions in a manual-like style? <br/>
SurveyKit is an Flutter library that allows you to create exactly that.

Thematically it is built to provide a feeling of a professional research survey. The library aims to be visually clean, lean and easily configurable.
We aim to keep the functionality close to [iOS ResearchKit Surveys](http://researchkit.org/docs/docs/Survey/CreatingSurveys.html). We also created a SurveyKit version for native Android developers, [check it out here](https://github.com/quickbirdstudios/SurveyKit)

This is an early version and work in progress. Do not hesitate to give feedback, ideas or improvements via an issue.


###### Screenshots

| | | | | | 
| :---: | :---: | :---: | :---: | :---: |
| <img src="example/assets/step_01_ios.png?raw=true" width="200"> | <img src="example/assets/step_02_ios.png?raw=true" width="200"> | <img src="example/assets/step_03_ios.png?raw=true" width="200"> | <img src="example/assets/step_04_ios.png?raw=true" width="200"> | <img src="example/assets/step_05_ios.png?raw=true" width="200"> |
| <img src="example/assets/step_01_android.png?raw=true" width="200"> | <img src="example/assets/step_02_android.png?raw=true" width="200"> | <img src="example/assets/step_03_android.png?raw=true" width="200"> | <img src="example/assets/step_04_android.png?raw=true" width="200"> | <img src="example/assets/step_05_android.png?raw=true" width="200"> |

## 📚 Overview: Creating Research Surveys
- [What SurveyKit does for you](#what-surveykit-does-for-you)
- [What SurveyKit does not (yet) do for you](#what-surveykit-does-not-yet-do-for-you)
- [🏃 Setup](#-🏃-setup)
  - [1. Add the dependecy](#1-add-the-dependecy)
  - [2. Install it](#2-install-it)
  - [3. Import it](#3-import-it)
- [💻 Usage](#-usage)
  - [Create survey steps](#create-survey-steps)
  - [Create a Task](#create-a-task)
  - [Evaluate the results](#evaluate-the-results)
  - [Style](#style)
  - [Start the survey](#start-the-survey)
- [📇 Custom steps](#-custom-steps)
- [🍏vs🤖 : Comparison of Flutter SurveyKit, SurveyKit on Android to ResearchKit on iOS](#-🍏vs🤖-:-comparison-of-flutter-surveykit,-surveykit-on-android-to-researchkit-on-iOS)
- [👤 Author](#-author)
- [❤️ Contributing](#️-contributing)
- [📃 License](#-license)

## What SurveyKit does for you
-   Simplifies the creation of surveys
-   Provides rich animations and transitions out of the box (custom animations planned)
-   Build with a consistent, lean, simple style, to fit research purposes
-   Survey navigation can be linear or based on a decision tree (directed graph)
-   Gathers results and provides them in a convinient manner to the developer for further use
-   Gives you complete freedom on creating your own questions
-   Allows you to customize the style
-   Provides an API and structure that is very similar to [iOS ResearchKit Surveys](http://researchkit.org/docs/docs/Survey/CreatingSurveys.html)

## What SurveyKit does not (yet) do for you
As stated before, this is an early version and a work in progress. We aim to extend this library until it matches the functionality of the [iOS ResearchKit Surveys](http://researchkit.org/docs/docs/Survey/CreatingSurveys.html).

# 🏃 Setup  
To use this plugin, add flutter_surveykit as a dependency in your pubspec.yaml file.

## 1. Add the dependecy
`pubspec.yaml`
```yaml
dependencies:
  surveykit: ^0.1
```

## 2. Install it
```
flutter pub get
```

## 3. Import it
```dart
import 'package:surveykit/survey_kit.dart';
```

# 💻 Usage
## Example
A working example project can be found [HERE](example/)

### Create survey steps
To create a step, create an instance of one of these 3 classes:
#### `InstructionStep`
```dart
InstructionStep(
    title: 'Your journey starts here',
    text: 'Have fun with a quick survey',
    buttonText: 'Start survey',
);
```
The `title` is the general title of the Survey you want to conduct. <br/>
The `text` is, in this case, the introduction text which should give an introduction, about what the survey is about.<br/>
The `buttonText` specifies the text of the button, which will start the survey.
All of these properties have to be resource Ids.

#### `CompletionStep`
```dart
CompletionStep(
    title: 'You are done',
    text: 'You have finished !!!',
    buttonText: 'Submit survey',
);
```
The `title` is the general title of the Survey you want to conduct, same as for the `InstructionStep`. <br/>
The `text` is here should be something motivational: that the survey has been completed successfully. <br/>
The `buttonText` specifies the text of the button, which will end the survey.
All of these properties have to be resource Ids.

#### `QuestionStep`
```dart
QuestionStep(
    title: 'Sample title',
    text: 'Sample text',
    answerFormat: TextAnswerFormat(
        maxLines: 5,
    ),
);
```
The `title` same as for the `InstructionStep` and `CompletionStep`. <br/>
The `text` the actual question you want to ask. Depending on the answer type of this, you should set the next property.<br/>
The `answerFormat` specifies the type of question (the type of answer to the question) you want to ask. Currently there these types supported:
-   `TextAnswerFormat`
-   `IntegerAnswerFormat`
-   `ScaleAnswerFormat`
-   `SingleChoiceAnswerFormat`
-   `MultipleChoiceAnswerFormat`
-   `BooleanAnswerFormat`

All that's left is to collect your steps in a list or add them inline in the widget.
```dart
var steps = [step1, step2, step3, ...]
```

### Create a Task
Next you need a task. Each survey has **exactly one** task. A `Task` is used to define how the user should navigate through your `steps`. <br><br>

#### OrderedTask
```dart
var task = OrderedTask(steps: steps)
```
The `OrderedTask` just presents the questions in order, as they are given.

#### NavigableOrderedTask
````dart
var task = NavigableOrderedTask(steps: steps)
````
The `NavigableOrderedTask` allows you to specify navigation rules.<br>
There are two types of navigation rules:
<br/>
With the `DirectStepNavigationRule` you say that after this step, another specified step should follow.
```dart
task.addNavigationRule(
  forTriggerStepIdentifier: steps[4].id,
  navigationRule: DirectStepNavigationRule(
      destinationStepStepIdentifier: steps[6].id
  ),
);
```
<br><br/>
With the `MultipleDirectionStepNavigationRule` you can specify the next step, depending on the answer of the step.
```dart
task.addNavigationRule(
  forTriggerStepIdentifier: task.steps[6].id,
  navigationRule: ConditionalNavigationRule(
    resultToStepIdentifierMapper: (input) {
      switch (input) {
        case "Yes":
          return task.steps[0].id;
        case "No":
          return task.steps[7].id;
        default:
          return null;
      }
    },
  ),
);

```

### Evaluate the results
When the survey is finished, you get a callback. No matter of the `FinishReason`, you always get all results gathered until now. <br/>
The `SurveyResult` contains a list of `StepResult`s and the `FinishReason`. The `StepResult` contains a list of `QuestionResult`s.
```dart
 SurveyKit(
    onResult: (SurveyResult result) {
      //Read finish reason from result (result.finishReason)
      //and evaluate the results
    },
)
```

### Style
There are already many adaptive elements for Android and IOS implemented. In the future development other parts will be adapted too.
The styling can be adjusted by the build in Flutter theme.

### Start the survey
All that's left is to insert the survey in the widget tree and enjoy.🎉🎊
```dart
Scaffold(
    body: SurveyKit(
         onResult: (SurveyResult result) {
            //Evaluate results
          },
          task: OrderedTask(),
          theme: CustomThemeData(),
    )
);
```


# 📇 Custom steps
At some point, you might wanna define your own custom question steps. 
That could, for example, be a question which prompts the user to pick color values or even sound samples. 
These are not implemented yet but you can easily create them yourself: 

You'll need a `CustomResult` and a `CustomStep`. The Result class tells SurveyKit which data you want to save. 
```dart
class CustomResult extends QuestionResult<String> {
    final String customData;
    final String valueIdentifier;
    final Identifier identifier;
    final DateTime startDate;
    final DateTime endDate;
    final String value; //Custom value
}
```
Next you'll need a CustomStep class. It is recommended to use the `StepView` widget as your foundation. It gives you the AppBar and the next button. 
```dart
class CustomStep extends Step {
  final String title;
  final String text;

  CustomStep({
    @required StepIdentifier id,
    bool isOptional = false,
    String buttonText = 'Next',
    this.title,
    this.text,
  }) : super(isOptional, id, buttonText);

  @override
  Widget createView({@required QuestionResult questionResult}) {
      return StepView(
            step: widget.questionStep,
            controller: SurveyController(
              context: context,
              result: () => CustomResult(
                id: id,
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                valueIdentifier: 'custom'//Identification for NavigableTask,
                result: 'custom_result',
              ),
            ),
            title: Text('Title'),
            child: Container(), //Add your view here
        );
  }
}
```


If you want to create a complete custom view you should use the SurveyController with its three methods:
* nextStep()
* stepBack()
* closeSurvey()

# 🍏vs🤖 : Comparison of Flutter SurveyKit, [SurveyKit on Android](https://github.com/quickbirdstudios/SurveyKit) to [ResearchKit on iOS](http://researchkit.org/docs/docs/Survey/CreatingSurveys.html)
This is an overview of which features [iOS ResearchKit Surveys](http://researchkit.org/docs/docs/Survey/CreatingSurveys.html) provides and which ones are already supported by [SurveyKit on Android](https://github.com/quickbirdstudios/SurveyKit).
The goal is to make all three libraries match in terms of their functionality.

| Steps	                    | iOS ResearchKit        | Android SurveyKit| Flutter SurveyKit| 
| :------------------------ | :---:                  | :---:	       | :---:             | 
| Instruction               | ✅                     | ✅             | ✅                  | 
| Single selection          | ✅                     | ✅             | ✅                  | 
| Multi selection           | ✅                     | ✅             | ✅                  | 
| Boolean answer            | ✅                     | ✅             | ✅                  | 
| Text answer (unlimited)   | ✅                     | ✅             | ✅                  | 
| Text answer (limited)     | ✅                     | ✅             | ✅                  | 
| Text answer (validated)   | ✅                     | ✅             | ✅                  | 
| Scale answer              | ✅                     | ✅             | ✅                  | 
| Numeric answer            | ✅                     | ✅             | ✅                  | 
| Time of day               | ✅                     | ✅             | ✅                  | 
| Date selection            | ✅                     | ✅             | ✅                  |  
| Value picker              | ✅                     | ✅             | ❌                  | 
| Image choice              | ✅                     | ✅             | ❌                  | 
| Email answer              | ✅                     | ✅             | ❌                  | 
| Location answer           | ✅                     | ✅             | ❌                  | 

# 👤 Author
This Flutter library is created with 💙 by [QuickBird Studios](https://quickbirdstudios.com/).

# ❤️ Contributing
Open an issue if you need help, if you found a bug, or if you want to discuss a feature request.

Open a PR if you want to make changes to Flutter SurveyKit.

# 📃 License
Flutter SurveyKit is released under an MIT license. See [License](LICENSE) for more information.
