// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart' hide VideoContent, AudioContent;
import 'package:survey_kit_audio/audio_content.dart';
import 'package:survey_kit_video/survey_kit_video.dart';
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
      navigationRules: {
        'SingleChoice': ConditionalNavigationRule(
          resultToStepIdentifierMapper:
              (List<StepResult> results, StepResult? input) {
            final selectedChoice = input?.result as TextChoice;
            switch (selectedChoice.text) {
              case 'Yes':
                return 'OnlyConent';
              case 'No':
                return 'Completion';
              default:
                return null;
            }
          },
        ),
      },
      steps: [
        // Migrate and just use Step
        InstructionStep(
          id: 'Intro',
          title: 'Welcome to the\nQuickBird\nHealth Survey',
          text: 'Get ready for a bunch of super random questions!',
        ),
        Step(
          id: 'SingleChoice',
          content: const [
            TextContent(
              text: 'Introduction to SurveyKit',
              fontSize: 24,
            ),
            SectionContent(
              title: StyledTextContent(
                text: 'ColorScheme class',
                bold: true,
                fontSize: 24,
              ),
              subtitle: StyledTextContent(
                text:
                    'A set of 30 colors based on the Material spec that can be used to configure the color properties of most components.',
                fontSize: 12,
                italic: true,
                underlined: true,
              ),
              text: StyledTextContent(
                text:
                    'The main accent color groups in the scheme are primary, secondary, and tertiary.Primary colors are used, for key components across the UI, such as the FAB, prominent buttons, and active states. Secondary colors are used for less prominent components in the UI, such as filter chips, while expanding the opportunity for color expression. Tertiary colors are used for contrasting accents that can be used to balance primary and secondary colors or bring heightened attention to an element, such as an input field. The tertiary colors are left for makers to use at their discretion and are intended to support broader color expression in products. The remaining colors of the scheme are comprised of neutral colors used for backgrounds and surfaces, as well as specific colors for errors, dividers and shadows.',
              ),
            ),
            VideoContent(
              title: 'This is an video about a bear',
              url:
                  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
              externalLink:
                  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
              width: 900,
            ),
            AudioContent(
              title: 'This is an audio',
              subtitle: 'The audio is gong',
              externalLink:
                  'https://github.com/QuickBirdEng/survey_kit/raw/main/assets/gong.mp3',
              url:
                  'https://github.com/QuickBirdEng/survey_kit/raw/main/assets/gong.mp3',
            ),
            LottieContent(
              repeat: true,
              url:
                  'https://assets4.lottiefiles.com/packages/lf20_mNvu7WUM7W.json',
            ),
            MarkdownContent(text: 'This is markdown'),
          ],
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(id: '1', value: 'Yes', text: 'Yes'),
              TextChoice(id: '2', value: 'No', text: 'No'),
            ],
            question: 'Did you like the video?',
          ),
        ),
        Step(
          id: 'IntegerAnswer',
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
          id: 'ScaleAnswer',
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
          id: 'MultipleChoice',
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
          id: 'OnlyConent',
          content: const [
            TextContent(
              text: 'Listen carefully!',
              fontSize: 28,
            ),
            AudioContent(
              title: 'This is an audio',
              subtitle: 'This is a good subtitle for the video',
              url:
                  'https://github.com/QuickBirdEng/survey_kit/raw/main/assets/gong.mp3',
            ),
          ],
        ),
        // Migrate and just use Step
        QuestionStep(
          id: 'TextAnswer',
          title: 'Feedback',
          text: 'What did you like about the survey?',
          answerFormat: const TextAnswerFormat(
            hint: 'Feedback',
          ),
          isOptional: true,
        ),
        // Migrate and just use Step
        CompletionStep(
          id: 'Completion',
          title: 'Done!',
          text: 'Thanks for taking the survey, we will contact you soon!',
        ),
      ],
    );

    return Future.value(task);
  }

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson) as Map<String, dynamic>;

    return Task.fromJson(taskMap);
  }

  ThemeData get theme => Theme.of(context).copyWith(
        useMaterial3: true,
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
        log(json.encode(result));
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.cyan,
            Colors.white,
          ],
        ),
      ),
      stepShell: (
        Step step,
        Widget? answerWidget,
        BuildContext context,
      ) {
        final questionAnswer = QuestionAnswer.of(context);
        final surveyConfiguration = SurveyConfiguration.of(context);
        final surveyController = surveyConfiguration.surveyController;
        final mediaQuery = MediaQuery.of(context);

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: ContentWidget(
                                content: step.content,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (answerWidget != null) answerWidget,
                      Container(
                        width: double.infinity,
                        height: 80 + mediaQuery.viewPadding.bottom,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SafeArea(
                            child: OutlinedButton(
                              onPressed: questionAnswer.isValid.value ||
                                      !step.isMandatory
                                  ? () => surveyController.nextStep(
                                        context,
                                        questionAnswer.stepResult,
                                      )
                                  : null,
                              child: const Text('Zur Frage'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
