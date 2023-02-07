// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:surveykit_example/app_bar_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<Task>(
              future: getSampleTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final task = snapshot.data!;
                  return SurveyKitView(
                    task: task,
                  );
                }
                return const CircularProgressIndicator.adaptive();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<Task> getSampleTask() {
    final task = NavigableTask(
      steps: [
        // Migrate and just use Step
        InstructionStep(
          title: 'Welcome to the\nQuickBird\nHealth Survey',
          text: 'Get ready for a bunch of super random questions!',
        ),
        Step(
          content: const [
            TextContent(
              text: 'Introduction to SurveyKit',
              fontSize: 24,
            ),
            VideoContent(
              url:
                  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
            ),
            TextContent(
              text: 'Did you like the video? ',
              fontSize: 20,
            ),
          ],
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Yes',
            negativeAnswer: 'No',
          ),
        ),
        Step(
          content: const [
            TextContent(
              text: 'How old are you?',
              fontSize: 18,
            ),
          ],
          answerFormat: const IntegerAnswerFormat(
            hint: 'Age',
          ),
        ),
        Step(
          content: const [
            TextContent(
              text: 'Select your body type',
              fontSize: 18,
            ),
          ],
          answerFormat: const ScaleAnswerFormat(
            maximumValue: 5,
            minimumValue: 1,
            defaultValue: 3,
            step: 1,
          ),
        ),
        Step(
          content: const [
            TextContent(
              text: 'Known allergies',
              fontSize: 22,
            ),
            TextContent(
              text: 'Do you have allergies that we need to be aware of?',
              fontSize: 18,
            ),
          ],
          answerFormat: MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(id: '1', value: 'Penicillin', text: 'Penicillin'),
              TextChoice(id: '2', value: 'Latex', text: 'Latex'),
              TextChoice(id: '3', value: 'Pet', text: 'Pet'),
              TextChoice(id: '4', value: 'Pollen', text: 'Pollen'),
            ],
          ),
        ),
        Step(
          id: '12',
          content: const [
            TextContent(
              text: 'Done?',
              fontSize: 22,
            ),
            TextContent(
              text: 'We are done, do you mind to tell us more about yourself?',
              fontSize: 18,
            ),
          ],
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Yes',
            negativeAnswer: 'No',
          ),
        ),

        QuestionStep(
          id: '13',
          title: 'Medication?',
          text: 'Are you using any medication',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Yes',
            negativeAnswer: 'No',
            result: BooleanResult.positive,
          ),
        ),
        Step(
          content: const [
            TextContent(
              text: 'Listen carefully!',
              fontSize: 28,
            ),
            AudioContent(
              url:
                  'https://github.com/QuickBirdEng/survey_kit/blob/main/assets/gong.mp3?raw=true',
            ),
          ],
        ),
        QuestionStep(
          title: 'When did you wake up?',
          answerFormat: const TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 12,
              minute: 0,
            ),
          ),
        ),
        QuestionStep(
          title: 'When was your last holiday?',
          answerFormat: DateAnswerFormat(
            minDate: DateTime.utc(1970),
            defaultDate: DateTime.now(),
            maxDate: DateTime.now(),
          ),
        ),
        // Migrate and just use Step
        QuestionStep(
          title: 'Feedback',
          text: 'What did you like about the survey?',
          answerFormat: const TextAnswerFormat(
            hint: 'Feedback',
          ),
          isOptional: true,
        ),
        // Migrate and just use Step
        CompletionStep(
          title: 'Done!',
          text: 'Thanks for taking the survey, we will contact you soon!',
        ),
      ],
    );

    task.addNavigationRule(
      forTriggerStepIdentifier: '12',
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case 'Yes':
              return '13';
            case 'No':
              return task.steps.last.id;
            default:
              return null;
          }
        },
      ),
    );

    return Future.value(task);
  }

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson) as Map<String, dynamic>;

    return Task.fromJson(taskMap);
  }

  ThemeData get theme => Theme.of(context).copyWith(
        primaryColor: Colors.cyan,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.cyan,
          ),
          titleTextStyle: TextStyle(
            color: Colors.cyan,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.cyan,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.cyan,
          selectionColor: Colors.cyan,
          selectionHandleColor: Colors.cyan,
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: Colors.cyan,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(150.0, 60.0),
            ),
            side: MaterialStateProperty.resolveWith(
              (Set<MaterialState> state) {
                if (state.contains(MaterialState.disabled)) {
                  return const BorderSide(
                    color: Colors.grey,
                  );
                }
                return const BorderSide(
                  color: Colors.cyan,
                );
              },
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            textStyle: MaterialStateProperty.resolveWith(
              (Set<MaterialState> state) {
                if (state.contains(MaterialState.disabled)) {
                  return Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey,
                      );
                }
                return Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.cyan,
                    );
              },
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.cyan,
                  ),
            ),
          ),
        ),
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
          headlineSmall: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
        )
            .copyWith(
              onPrimary: Colors.white,
            )
            .copyWith(background: Colors.white),
      );
}

class SurveyKitView extends StatelessWidget {
  const SurveyKitView({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return SurveyKit(
      onResult: (SurveyResult result) {
        log(result.finishReason.toString());
        Navigator.pushNamed(context, '/');
      },
      task: task,
      localizations: const {
        'cancel': 'Cancel',
        'next': 'Next',
      },
      surveyProgressbarConfiguration: SurveyProgressConfiguration(
        backgroundColor: Colors.white,
      ),
      appBar: const AppBarExample(),
      // stepShell: (
      //   Step step,
      //   Widget? answerWidget,
      //   BuildContext context,
      // ) {
      //   final questionAnswer = QuestionAnswer.of(context);
      //   final surveyConfiguration = SurveyConfiguration.of(context);
      //   final surveyController = surveyConfiguration.surveyController;

      //   return ColoredBox(
      //     color: Colors.white,
      //     child: Column(
      //       children: [
      //         Expanded(
      //           child: ContentWidget(
      //             content: step.content,
      //           ),
      //         ),
      //         // if (step.answerFormat != null)
      //         //   step.answerFormat!.createView(step, stepResult?.call()),
      //         SafeArea(
      //           child: Container(
      //             width: double.infinity,
      //             height: 80,
      //             color: Colors.white,
      //             child: Padding(
      //               padding: const EdgeInsets.all(16),
      //               child: OutlinedButton(
      //                 onPressed: questionAnswer.isValid || !step.isMandatory
      //                     ? () => surveyController.nextStep(
      //                           context,
      //                           questionAnswer.stepResult,
      //                         )
      //                     : null,
      //                 child: const Text('Zur Frage'),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   );
      // },
    );
  }
}
