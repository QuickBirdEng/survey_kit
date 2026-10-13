import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_lottie/survey_kit_lottie.dart';

void main() {
  const content = LottieContent(
    id: 'lottie-1',
    asset: 'assets/missing.json',
    repeat: true,
    width: 120,
    height: 80,
  );

  group('LottieContent JSON', () {
    test('round-trips through jsonEncode and jsonDecode', () {
      final decoded =
          jsonDecode(jsonEncode(content.toJson())) as Map<String, dynamic>;
      final restored = LottieContent.fromJson(decoded);

      expect(decoded['type'], LottieContent.type);
      expect(restored.toJson(), content.toJson());
    });

    test('dispatches through Content.fromJson once registered', () {
      Content.registerFromJson(LottieContent.type, LottieContent.fromJson);

      final restored = Content.fromJson(
        jsonDecode(jsonEncode(content.toJson())) as Map<String, dynamic>,
      );

      expect(restored, isA<LottieContent>());
      expect(restored.toJson(), content.toJson());
    });

    test('rejects JSON without url or asset', () {
      expect(
        () => LottieContent.fromJson(const {'type': 'lottie'}),
        throwsFormatException,
      );
    });
  });

  testWidgets('plugin builder shows an error placeholder for a missing asset', (
    tester,
  ) async {
    final builder = SurveyKitLottie().contentWidgetBuilders[LottieContent]!;

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: builder(content))),
    );
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pump();

    expect(find.byType(LottieWidget), findsOneWidget);
    expect(find.byIcon(Icons.broken_image_outlined), findsOneWidget);
    expect(tester.getSize(find.byType(LottieWidget)), const Size(120, 80));
  });
}
