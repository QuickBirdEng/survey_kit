import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/survey_kit_audio.dart';
import 'package:survey_kit_lottie/survey_kit_lottie.dart';
import 'package:survey_kit_video/survey_kit_video.dart';
import 'package:surveykit_example/json_survey_page.dart';
import 'package:surveykit_example/main.dart';

void main() {
  setUpAll(registerPluginJsonFactories);

  test('JSON survey asset parses with every content type', () {
    final raw = File(jsonSurveyAsset).readAsStringSync();
    final survey = SurveyDefinition.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );

    final contentTypes = survey.steps
        .expand((step) => step.content)
        .map((content) => content.runtimeType)
        .toSet();

    expect(
      contentTypes,
      containsAll(<Type>[
        TextContent,
        StyledTextContent,
        MarkdownContent,
        SectionContent,
        ImageContent,
        VideoContent,
        AudioContent,
        LottieContent,
      ]),
    );
  });

  testWidgets('opens the Dart survey from the home page', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Health survey (Dart)'), findsOneWidget);
    expect(find.text('Media survey (JSON)'), findsOneWidget);

    await tester.tap(find.text('Health survey (Dart)'));
    await tester.pumpAndSettle();

    expect(find.text("Let's begin"), findsOneWidget);
  });

  testWidgets('opens the JSON survey from the home page', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Media survey (JSON)'));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Loaded from JSON'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
  });
}
