import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_video/survey_kit_video.dart';

void main() {
  const content = VideoContent(
    id: 'video-1',
    url: 'https://example.com/clip.mp4',
    autoPlay: true,
    loop: true,
    width: 320,
    height: 180,
    title: 'Title',
    subtitle: 'Subtitle',
    externalLink: 'https://example.com/more',
  );

  group('VideoContent JSON', () {
    test('round-trips through jsonEncode and jsonDecode', () {
      final decoded =
          jsonDecode(jsonEncode(content.toJson())) as Map<String, dynamic>;
      final restored = VideoContent.fromJson(decoded);

      expect(decoded['type'], VideoContent.type);
      expect(restored.toJson(), content.toJson());
    });

    test('dispatches through Content.fromJson once registered', () {
      Content.registerFromJson(VideoContent.type, VideoContent.fromJson);

      final restored = Content.fromJson(
        jsonDecode(jsonEncode(content.toJson())) as Map<String, dynamic>,
      );

      expect(restored, isA<VideoContent>());
      expect(restored.toJson(), content.toJson());
    });

    test('applies defaults for optional fields', () {
      final restored = VideoContent.fromJson(const {
        'type': 'video',
        'url': 'https://example.com/clip.mp4',
      });

      expect(restored.autoPlay, isFalse);
      expect(restored.loop, isFalse);
      expect(restored.width, isNull);
    });
  });

  testWidgets('plugin builder renders the video widget', (tester) async {
    final builder = SurveyKitVideo().contentWidgetBuilders[VideoContent]!;

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: builder(content))),
    );
    await tester.pump();

    expect(find.byType(VideoWidget), findsOneWidget);
    expect(find.byType(SurveyKitVideoPlayer), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Subtitle'), findsOneWidget);
    expect(
      find.text('https://example.com/more', findRichText: true),
      findsOneWidget,
    );
  });

  testWidgets('shows a retry button when the video fails to load', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SurveyKitVideoPlayer(videoUrl: 'https://example.com/clip.mp4'),
        ),
      ),
    );
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pump();

    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });
}
