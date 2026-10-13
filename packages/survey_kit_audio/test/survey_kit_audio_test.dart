import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/survey_kit_audio.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('com.ryanheise.just_audio.methods'),
          (call) async {
            if (call.method == 'init') {
              throw PlatformException(code: 'unavailable');
            }
            return <String, dynamic>{};
          },
        );
  });

  const content = AudioContent(
    id: 'audio-1',
    url: 'https://example.com/clip.mp3',
    autoPlay: true,
    title: 'Title',
    subtitle: 'Subtitle',
    externalLink: 'https://example.com/transcript',
  );

  group('AudioContent JSON', () {
    test('round-trips through jsonEncode and jsonDecode', () {
      final decoded =
          jsonDecode(jsonEncode(content.toJson())) as Map<String, dynamic>;
      final restored = AudioContent.fromJson(decoded);

      expect(decoded['type'], AudioContent.type);
      expect(restored.toJson(), content.toJson());
    });

    test('dispatches through Content.fromJson once registered', () {
      Content.registerFromJson(AudioContent.type, AudioContent.fromJson);

      final restored = Content.fromJson(
        jsonDecode(jsonEncode(content.toJson())) as Map<String, dynamic>,
      );

      expect(restored, isA<AudioContent>());
      expect(restored.toJson(), content.toJson());
    });

    test('applies defaults for optional fields', () {
      final restored = AudioContent.fromJson(const {
        'type': 'audio',
        'url': 'https://example.com/clip.mp3',
      });

      expect(restored.autoPlay, isFalse);
      expect(restored.title, isNull);
      expect(restored.externalLink, isNull);
    });
  });

  testWidgets('plugin builder renders the audio widget', (tester) async {
    final builder = SurveyKitAudio().contentWidgetBuilders[AudioContent]!;

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: builder(content))),
    );
    await tester.pump();

    expect(find.byType(AudioWidget), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Subtitle'), findsOneWidget);
    expect(
      find.text('https://example.com/transcript', findRichText: true),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows a retry button when the audio fails to load', (
    tester,
  ) async {
    final reportedErrors = captureReportedErrors();
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AudioWidget(audioContent: content)),
      ),
    );
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pump();

    expect(find.byIcon(Icons.refresh), findsOneWidget);
    expect(find.byType(Slider), findsNothing);
    expect(reportedErrors, isNotEmpty);
    expect(
      reportedErrors.map((details) => details.library),
      everyElement('survey_kit_audio'),
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
