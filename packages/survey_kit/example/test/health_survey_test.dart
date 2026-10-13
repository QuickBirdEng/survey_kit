import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit_audio/survey_kit_audio.dart';
import 'package:survey_kit_video/survey_kit_video.dart';
import 'package:surveykit_example/main.dart';

const _justAudioChannel = MethodChannel('com.ryanheise.just_audio.methods');

void main() {
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_justAudioChannel, (call) async {
          if (call.method == 'init') {
            throw PlatformException(code: 'unavailable');
          }
          return <String, dynamic>{};
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_justAudioChannel, null);
  });

  testWidgets('completes the Dart health survey and shows the JSON result', (
    tester,
  ) async {
    final reportedErrors = captureReportedErrors();
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    Future<void> settle() async {
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    Future<void> tapButton(String label) async {
      final button = find.widgetWithText(ElevatedButton, label);
      await tester.ensureVisible(button);
      await tester.pump();
      expect(tester.widget<ElevatedButton>(button).enabled, isTrue);
      await tester.tap(button);
      await settle();
    }

    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Health survey (Dart)'));
    await settle();

    await tapButton("Let's begin");

    expect(find.text('Are you using any medication?'), findsOneWidget);
    await tester.tap(find.text('Yes'));
    await tester.pump();
    await tapButton('Continue');

    expect(find.text('Intermission'), findsOneWidget);
    await tester.tap(find.text('Continue Survey'));
    await settle();

    expect(find.text('How old are you?'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '42');
    await tester.pump();
    await tapButton('Continue');

    expect(find.text('Tell us about you'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'I want to feel better.');
    await tester.pump();
    await tapButton('Continue');

    expect(find.text('Select your body type'), findsOneWidget);
    await tapButton('Continue');

    expect(find.text('Known allergies'), findsOneWidget);
    await tester.tap(find.text('Pollen'));
    await tester.pump();
    await tapButton('Continue');

    expect(find.text('When did you wake up?'), findsOneWidget);
    await tapButton('Continue');

    expect(find.text('When was your last holiday?'), findsOneWidget);
    await tapButton('Continue');

    expect(
      find.text('Thanks! One more section with media examples.'),
      findsOneWidget,
    );
    await tapButton('Continue');

    expect(find.byType(VideoWidget), findsOneWidget);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tapButton('Next');

    expect(find.byType(AudioWidget), findsOneWidget);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tapButton('Next');

    expect(find.text('Lottie'), findsOneWidget);
    await tapButton('Next');

    expect(find.text('Did you enjoy this survey?'), findsOneWidget);
    await tester.tap(find.text('Yes'));
    await tester.pump();
    await tapButton('Finish');

    expect(find.text('Thank You!'), findsOneWidget);
    await tapButton('Submit Responses');

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Result (completed)'), findsOneWidget);

    final resultText = tester.widget<Text>(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data?.trimLeft().startsWith('{') ?? false),
        ),
      ),
    );
    final decoded = jsonDecode(resultText.data!) as Map<String, dynamic>;
    expect(decoded, isNotEmpty);
    expect(resultText.data, contains('I want to feel better.'));
    expect(resultText.data, contains('42'));

    await tester.tap(find.text('Restart'));
    await settle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(
      reportedErrors.map((details) => details.library),
      everyElement(isIn(['survey_kit_audio', 'survey_kit_video'])),
    );
  });
}

List<FlutterErrorDetails> captureReportedErrors() {
  final errors = <FlutterErrorDetails>[];
  final previous = FlutterError.onError;
  FlutterError.onError = errors.add;
  addTearDown(() => FlutterError.onError = previous);
  return errors;
}
