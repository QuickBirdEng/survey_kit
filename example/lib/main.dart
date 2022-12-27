import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';

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
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<Task>(
              future: getJsonTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final task = snapshot.data!;
                  return SurveyKit(
                    onResult: (SurveyResult result) {
                      log(result.finishReason.toString());
                      Navigator.pushNamed(context, '/');
                    },
                    task: task,
                    showProgress: true,
                    localizations: const {
                      'cancel': 'Cancel',
                      'next': 'Next',
                    },
                    themeData: Theme.of(context).copyWith(
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
                                return Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Colors.grey,
                                    );
                              }
                              return Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
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
                    ),
                    surveyProgressbarConfiguration: SurveyProgressConfiguration(
                      backgroundColor: Colors.white,
                    ),
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

  Future<Task> newSampleTask() {
    final task = NavigableTask(
      id: 't',
      steps: const [
        Step(
          id: '1',
          title: 'First Step',
          content: [
            TextContent(id: '1', text: 'Text'),
            MarkdownContent(id: '1', text: 'Text'),
            VideoContent(
              id: '1',
              url:
                  'https://admin.mamly.de:1337/uploads/was_ist_coaching_c85aa48fc0.m4v',
            ),
          ],
        ),
      ],
    );

    return Future.value(task);
  }

  // Future<Task> getSampleTask() {
  //   final task = NavigableTask(
  //     id: TaskIdentifier(),
  //     steps: [
  //       InstructionStep(
  //         title: 'Welcome to the\nQuickBird Studios\nHealth Survey',
  //         text: 'Get ready for a bunch of super random questions!',
  //         buttonText: "Let's go!",
  //       ),
  //       QuestionStep(
  //         title: 'How old are you?',
  //         answerFormat: const IntegerAnswerFormat(
  //           defaultValue: 25,
  //           hint: 'Please enter your age',
  //         ),
  //         isOptional: true,
  //       ),
  //       QuestionStep(
  //         title: 'Medication?',
  //         text: 'Are you using any medication',
  //         answerFormat: const BooleanAnswerFormat(
  //           positiveAnswer: 'Yes',
  //           negativeAnswer: 'No',
  //           result: BooleanResult.positive,
  //         ),
  //       ),
  //       QuestionStep(
  //         title: 'Tell us about you',
  //         text:
  //             'Tell us about yourself and why you want to improve your health.',
  //         answerFormat: const TextAnswerFormat(
  //           maxLines: 5,
  //           validationRegEx: r'^(?!s*$).+',
  //         ),
  //       ),
  //       QuestionStep(
  //         title: 'Select your body type',
  //         answerFormat: const ScaleAnswerFormat(
  //           step: 1,
  //           minimumValue: 1,
  //           maximumValue: 5,
  //           defaultValue: 3,
  //           minimumValueDescription: '1',
  //           maximumValueDescription: '5',
  //         ),
  //       ),
  //       QuestionStep(
  //         title: 'Known allergies',
  //         text: 'Do you have any allergies that we should be aware of?',
  //         isOptional: false,
  //         answerFormat: const MultipleChoiceAnswerFormat(
  //           textChoices: [
  //             TextChoice(text: 'Penicillin', value: 'Penicillin'),
  //             TextChoice(text: 'Latex', value: 'Latex'),
  //             TextChoice(text: 'Pet', value: 'Pet'),
  //             TextChoice(text: 'Pollen', value: 'Pollen'),
  //           ],
  //         ),
  //       ),
  //       QuestionStep(
  //         title: 'Done?',
  //         text: 'We are done, do you mind to tell us more about yourself?',
  //         isOptional: true,
  //         answerFormat: const SingleChoiceAnswerFormat(
  //           textChoices: [
  //             TextChoice(text: 'Yes', value: 'Yes'),
  //             TextChoice(text: 'No', value: 'No'),
  //           ],
  //           defaultSelection: TextChoice(text: 'No', value: 'No'),
  //         ),
  //       ),
  //       QuestionStep(
  //         title: 'When did you wake up?',
  //         answerFormat: const TimeAnswerFormat(
  //           defaultValue: TimeOfDay(
  //             hour: 12,
  //             minute: 0,
  //           ),
  //         ),
  //       ),
  //       QuestionStep(
  //         title: 'When was your last holiday?',
  //         answerFormat: DateAnswerFormat(
  //           minDate: DateTime.utc(1970),
  //           defaultDate: DateTime.now(),
  //           maxDate: DateTime.now(),
  //         ),
  //       ),
  //       CompletionStep(
  //         stepIdentifier: StepIdentifier(id: '321'),
  //         text: 'Thanks for taking the survey, we will contact you soon!',
  //         title: 'Done!',
  //         buttonText: 'Submit survey',
  //       ),
  //     ],
  //   );
  //   task.addNavigationRule(
  //     forTriggerStepIdentifier: task.steps[6].stepIdentifier,
  //     navigationRule: ConditionalNavigationRule(
  //       resultToStepIdentifierMapper: (input) {
  //         switch (input) {
  //           case 'Yes':
  //             return task.steps[0].stepIdentifier;
  //           case 'No':
  //             return task.steps[7].stepIdentifier;
  //           default:
  //             return null;
  //         }
  //       },
  //     ),
  //   );
  //   return Future.value(task);
  // }

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson) as Map<String, dynamic>;

    return Task.fromJson(taskMap);
  }
}
