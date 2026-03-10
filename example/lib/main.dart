import 'dart:convert';

import 'package:flutter/material.dart' hide Step;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/survey_kit_audio.dart' as ska;
import 'package:survey_kit_lottie/survey_kit_lottie.dart';
import 'package:survey_kit_video/survey_kit_video.dart';

void main() => runApp(const MyApp());

// ---------------------------------------------------------------------------
// Survey definition
// ---------------------------------------------------------------------------
final _survey = SurveyFlow(
  id: 'health-survey',
  navigationRules: {
    // Branching: yes → age question, no → skip straight to media section
    'medication': ConditionalNavigationRule(
      resultToStepIdentifierMapper: (_, input) {
        final answer = input?.result as BooleanResult?;
        if (answer == BooleanResult.positive) {
          return const NavigateToStep('age');
        }
        return const NavigateToStep('media-intro');
      },
    ),
  },
  steps: [
    Step(
      content: const [
        TextContent(
          text: 'Welcome to the\nHealth Survey',
          fontSize: 32,
        ),
        TextContent(
          text:
              'Take a few minutes to complete our survey and help us understand your health profile.',
          fontSize: 18,
        ),
      ],
      buttonText: "Let's begin",
    ),
    Step(
      id: 'medication',
      content: const [
        TextContent(text: 'Medication?', fontSize: 22),
        TextContent(text: 'Are you using any medication?'),
      ],
      answerFormat: const BooleanAnswerFormat(
        positiveAnswer: 'Yes',
        negativeAnswer: 'No',
      ),
      buttonText: 'Continue',
    ),
    Step(
      id: 'age',
      content: const [TextContent(text: 'How old are you?')],
      answerFormat: const IntegerAnswerFormat(
        defaultValue: 25,
        hint: 'Please enter your age',
      ),
      buttonText: 'Continue',
    ),
    Step(
      content: const [
        TextContent(text: 'Tell us about you', fontSize: 22),
        TextContent(
          text:
              'Tell us about yourself and why you want to improve your health.',
        ),
      ],
      answerFormat: const TextAnswerFormat(maxLines: 5, hint: 'Your answer'),
      buttonText: 'Continue',
    ),
    Step(
      content: const [TextContent(text: 'Select your body type')],
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
      content: const [TextContent(text: 'Known allergies')],
      answerFormat: MultipleChoiceAnswerFormat(
        choices: [
          TextChoice(id: 'penicillin', value: 'Penicillin', text: 'Penicillin'),
          TextChoice(id: 'latex', value: 'Latex', text: 'Latex'),
          TextChoice(id: 'pet', value: 'Pet', text: 'Pet'),
          TextChoice(id: 'pollen', value: 'Pollen', text: 'Pollen'),
        ],
        otherField: true,
      ),
      buttonText: 'Continue',
    ),
    Step(
      content: const [TextContent(text: 'When did you wake up?')],
      answerFormat: const TimeAnswerFormat(
        defaultValue: TimeOfDay(hour: 8, minute: 0),
      ),
      buttonText: 'Continue',
    ),
    Step(
      content: const [TextContent(text: 'When was your last holiday?')],
      answerFormat: DateAnswerFormat(
        minDate: DateTime(2015),
        maxDate: DateTime(2028, 12, 31),
        defaultDate: DateTime(2021, 6, 25),
      ),
      buttonText: 'Continue',
    ),
    Step(
      id: 'media-intro',
      content: const [
        TextContent(text: 'Thanks! One more section with media examples.'),
      ],
      buttonText: 'Continue',
    ),
    Step(
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
      content: const [TextContent(text: 'Did you enjoy this survey?')],
      answerFormat: SingleChoiceAnswerFormat(
        choices: [
          TextChoice(id: 'yes', value: 'yes', text: 'Yes'),
          TextChoice(id: 'no', value: 'no', text: 'No'),
        ],
      ),
      buttonText: 'Finish',
    ),
    Step(
      content: const [
        TextContent(text: 'Thank You!', fontSize: 32),
        TextContent(
          text:
              'Your feedback is incredibly valuable to us. We will be in touch soon.',
          fontSize: 18,
        ),
      ],
      buttonText: 'Submit Responses',
    ),
  ],
);

// ---------------------------------------------------------------------------
// App
// ---------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFAF29EB), // A deep, premium purple-indigo
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor:
            Colors.transparent, // Let SurveyKit decoration show through
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF4F6AF5)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white.withValues(alpha: 0.9),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFAF29EB), width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            backgroundColor: const Color(0xFFAF29EB),
            foregroundColor: Colors.white,
            elevation: 2,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            side: const BorderSide(color: Color(0xFFAF29EB), width: 1.5),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            foregroundColor: const Color(0xFFAF29EB),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            foregroundColor: const Color(0xFFAF29EB),
          ),
        ),
        textTheme: const TextTheme(
          headlineMedium:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1E2C)),
          bodyLarge: TextStyle(fontSize: 18, color: Color(0xFF4A4A5A)),
        ),
      ),
      localizationsDelegates: const [
        SurveyKitLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SurveyKitLocalizations.supportedLocales,
      home: const SurveyPage(),
    );
  }
}

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  int _session = 0;
  late final SurveyController _controller = SurveyController(
    onNextStep: _onNextStep,
  );

  void _onNextStep(
    BuildContext context,
    StepResult? stepResult,
    void Function() proceed,
  ) {
    final state = SurveyStateProvider.of(context).state;
    if (state is PresentingSurveyState &&
        state.currentStep.id == 'medication' &&
        stepResult?.result == BooleanResult.positive) {
      Navigator.of(context, rootNavigator: true)
          .push<void>(
            MaterialPageRoute<void>(
              builder: (_) => const IntermissionPage(),
            ),
          )
          .then((_) => proceed());
      return;
    }
    proceed();
  }

  @override
  Widget build(BuildContext context) {
    return SurveyKit(
      key: ValueKey<int>(_session),
      task: _survey,
      surveyController: _controller,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE6E9FC), // Soft blue-ish white at top top
            Color(0xFFFDFDFD), // Crisp white at the bottom
          ],
        ),
      ),
      surveyProgressbarConfiguration: SurveyProgressConfiguration(
        backgroundColor: Colors.white,
        progressbarColor: const Color(0xFFAF29EB),
        height: 8,
      ),
      registries: [
        ska.SurveyKitAudio(),
        SurveyKitVideo(),
        SurveyKitLottie(),
      ],
      onResult: (result) => _showResult(context, result),
    );
  }

  Future<void> _showResult(BuildContext context, SurveyResult result) {
    Object? toEncodable(Object? obj) {
      if (obj is Enum) return obj.name;
      final dynamic d = obj;
      try {
        // ignore: avoid_dynamic_calls
        return d.toJson();
      } catch (_) {
        return obj.toString();
      }
    }

    final json = JsonEncoder.withIndent('  ', toEncodable).convert(
      result.toJson(),
    );
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Result (${result.finishReason.name})'),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Text(json, style: const TextStyle(fontFamily: 'monospace')),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (mounted) setState(() => _session++);
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Intermission page (demonstrates async navigation intercept)
// ---------------------------------------------------------------------------
class IntermissionPage extends StatelessWidget {
  const IntermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intermission')),
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
