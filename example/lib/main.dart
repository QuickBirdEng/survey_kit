import 'dart:convert';

import 'package:flutter/material.dart' hide Step;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/survey_kit_audio.dart' as ska;
import 'package:survey_kit_lottie/survey_kit_lottie.dart';
import 'package:survey_kit_video/survey_kit_video.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        SurveyKitLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SurveyKitLocalizations.supportedLocales,
      home: CombinedSurveyPage(),
    );
  }
}

class CombinedSurveyPage extends StatefulWidget {
  const CombinedSurveyPage({super.key});

  @override
  State<CombinedSurveyPage> createState() => _CombinedSurveyPageState();
}

class _CombinedSurveyPageState extends State<CombinedSurveyPage> {
  late final SurveyFlow _task;
  late final SurveyController _controller;
  int _surveySession = 0;

  @override
  void initState() {
    super.initState();
    _task = _buildTask();
    _controller = SurveyController(
      onNextStep: _onNextStep,
    );
  }

  void _onNextStep(BuildContext context, StepResult? stepResult) {
    final provider = SurveyStateProvider.of(context);
    final state = provider.state;

    if (state is PresentingSurveyState && state.currentStep.id == '3') {
      final selected = stepResult?.result as BooleanResult?;
      if (selected == BooleanResult.positive) {
        Navigator.of(context, rootNavigator: true)
            .push<void>(
          MaterialPageRoute<void>(
            builder: (_) => const IntermissionPage(),
          ),
        )
            .then((_) {
          provider.onEvent(NextStep(stepResult));
        });
        return;
      }
    }

    provider.onEvent(NextStep(stepResult));
  }

  SurveyFlow _buildTask() {
    return SurveyFlow(
      id: 'combined-demo',
      navigationRules: <String, NavigationRule>{
        '1': DirectNavigationRule('3'),
        '3': ConditionalNavigationRule(
          resultToStepIdentifierMapper: (_, input) {
            final selected = input?.result as BooleanResult?;
            if (selected == BooleanResult.positive) {
              return const NavigateToStep('2');
            }
            if (selected == BooleanResult.negative) {
              return const NavigateToStep('6');
            }
            return const NavigateToNextInList();
          },
        ),
        '2': DirectNavigationRule('4'),
      },
      steps: [
        Step(
          id: '1',
          content: const [
            TextContent(
              text: 'Welcome to the\nQuickBird Studios\nHealth Survey',
              fontSize: 24,
            ),
            TextContent(
              text: 'Get ready for a bunch of super random questions!',
            ),
          ],
          buttonText: "Let's go!",
        ),
        Step(
          id: '3',
          content: const [
            TextContent(
              text: 'Medication?',
              fontSize: 22,
            ),
            TextContent(
              text: 'Are you using any medication',
            ),
          ],
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Yes',
            negativeAnswer: 'No',
          ),
          buttonText: 'Continue',
        ),
        Step(
          id: '2',
          content: const [
            TextContent(text: 'How old are you?'),
          ],
          answerFormat: const IntegerAnswerFormat(
            defaultValue: 25,
            hint: 'Please enter your age',
          ),
          buttonText: 'Continue',
        ),
        Step(
          id: '4',
          content: const [
            TextContent(
              text: 'Tell us about you',
              fontSize: 22,
            ),
            TextContent(
              text:
                  'Tell us about yourself and why you want to improve your health.',
            ),
          ],
          answerFormat: const TextAnswerFormat(
            maxLines: 5,
            hint: 'Your answer',
          ),
          buttonText: 'Continue',
        ),
        Step(
          id: '11',
          content: const [
            TextContent(text: 'Select your body type'),
          ],
          answerFormat: const ScaleAnswerFormat(
            maximumValue: 5.0,
            minimumValue: 1.0,
            defaultValue: 3.0,
            step: 1.0,
            minimumValueDescription: '1',
            maximumValueDescription: '5',
          ),
          buttonText: 'Continue',
        ),
        Step(
          id: '12',
          content: const [
            TextContent(text: 'Known allergies'),
          ],
          answerFormat: MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(
                id: 'penicillin',
                value: 'Penicillin',
                text: 'Penicillin',
              ),
              TextChoice(id: 'latex', value: 'Latex', text: 'Latex'),
              TextChoice(id: 'pet', value: 'Pet', text: 'Pet'),
              TextChoice(id: 'pollen', value: 'Pollen', text: 'Pollen'),
            ],
            otherField: true,
          ),
          buttonText: 'Continue',
        ),
        Step(
          id: '13',
          content: const [
            TextContent(text: 'When did you wake up?'),
          ],
          answerFormat: const TimeAnswerFormat(
            defaultValue: TimeOfDay(hour: 12, minute: 0),
          ),
          buttonText: 'Continue',
        ),
        Step(
          id: '14',
          content: const [
            TextContent(text: 'When was your last holiday?'),
          ],
          answerFormat: DateAnswerFormat(
            minDate: DateTime(2015, 6, 25),
            maxDate: DateTime(2028, 12, 31),
            defaultDate: DateTime(2021, 6, 25),
          ),
          buttonText: 'Continue',
        ),
        Step(
          id: '5',
          content: const [
            TextContent(text: 'Thanks, one more section with media examples.'),
          ],
          buttonText: 'Continue',
        ),
        Step(
          id: '6',
          content: const [
            TextContent(text: 'Video'),
            VideoContent(
              title: 'Big Buck Bunny',
              url:
                  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
            ),
          ],
          buttonText: 'Next',
        ),
        Step(
          id: '7',
          content: const [
            TextContent(text: 'Audio'),
            ska.AudioContent(
              title: 'Gong',
              subtitle: 'Sample audio',
              url:
                  'https://github.com/QuickBirdEng/survey_kit/raw/main/assets/gong.mp3',
            ),
          ],
          buttonText: 'Next',
        ),
        Step(
          id: '8',
          content: const [
            TextContent(text: 'Lottie'),
            LottieContent(
              asset: 'assets/fancy_checkmark.json',
              repeat: true,
              width: 180,
              height: 180,
            ),
          ],
          buttonText: 'Next',
        ),
        Step(
          id: '9',
          content: const [
            TextContent(text: 'Did you enjoy this survey?'),
          ],
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(id: 'yes', value: 'yes', text: 'Yes'),
              TextChoice(id: 'no', value: 'no', text: 'No'),
            ],
          ),
          buttonText: 'Finish',
        ),
        Step(
          id: '10',
          content: const [
            TextContent(
              text: 'Done!',
              fontSize: 24,
            ),
            TextContent(
              text: 'Thanks for taking the survey, we will contact you soon!',
            ),
          ],
          buttonText: 'Submit survey',
        ),
      ],
    );
  }

  List<Color> _adaptiveBackgroundForStep(String stepId) {
    switch (stepId) {
      case '1':
      case '2':
      case '4':
        return [Colors.cyan.shade300, Colors.cyan.shade50];
      case '3':
      case '11':
      case '12':
        return [Colors.indigo.shade300, Colors.blue.shade100];
      case '13':
      case '14':
      case '5':
        return [Colors.lightBlue.shade300, Colors.blue.shade100];
      case '6':
        return [Colors.deepPurple.shade200, Colors.indigo.shade100];
      case '7':
        return [Colors.orange.shade300, Colors.yellow.shade100];
      case '8':
        return [Colors.teal.shade300, Colors.green.shade100];
      case '9':
      case '10':
        return [Colors.red.shade200, Colors.orange.shade100];
      default:
        return [Colors.cyan.shade300, Colors.white];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SurveyKit(
      key: ValueKey<int>(_surveySession),
      task: _task,
      surveyController: _controller,
      registries: [
        ska.SurveyKitAudio(),
        SurveyKitVideo(),
        SurveyKitLottie(),
      ],
      onResult: (result) => _showResultDialog(context, result),
      surveyProgressbarConfiguration: SurveyProgressConfiguration(
        backgroundColor: Colors.white,
      ),
      stepShell: (step, answerWidget, context) {
        final questionAnswer = QuestionAnswer.of(context);
        final surveyController =
            SurveyConfiguration.of(context).surveyController;
        final mediaQuery = MediaQuery.of(context);

        final surveyBody = LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
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
                            child: ValueListenableBuilder<bool>(
                              valueListenable: questionAnswer.isValid,
                              builder: (context, isValid, child) {
                                return OutlinedButton(
                                  onPressed: isValid || !step.isMandatory
                                      ? () => surveyController.next(
                                            stepResult:
                                                questionAnswer.stepResult,
                                          )
                                      : null,
                                  child: Text(step.buttonText ?? 'Next'),
                                );
                              },
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

        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: _adaptiveBackgroundForStep(step.id),
            ),
          ),
          child: surveyBody,
        );
      },
    );
  }

  Future<void> _showResultDialog(BuildContext context, SurveyResult result) {
    final encoded = const JsonEncoder.withIndent(
      '  ',
    ).convert(_normalizeJsonValue(result.toJson()));
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Result (${result.finishReason.name})'),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Text(
              encoded,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              if (!mounted) {
                return;
              }
              setState(() {
                _surveySession += 1;
              });
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  Object? _normalizeJsonValue(Object? value) {
    if (value == null || value is String || value is num || value is bool) {
      return value;
    }
    if (value is Enum) {
      return value.name;
    }
    if (value is Map) {
      return value.map(
        (key, mapValue) =>
            MapEntry(key.toString(), _normalizeJsonValue(mapValue)),
      );
    }
    if (value is Iterable) {
      return value.map(_normalizeJsonValue).toList();
    }

    final dynamic dynamicValue = value;
    try {
      // ignore: avoid_dynamic_calls
      return _normalizeJsonValue(dynamicValue.toJson());
    } catch (_) {
      return value.toString();
    }
  }
}

class IntermissionPage extends StatelessWidget {
  const IntermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intermission'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Medication answer was "Yes". Continue to age question.',
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Continue Survey'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
