import 'package:survey_kit/src/model/content/lottie_content.dart';
import 'package:survey_kit/src/model/content/text_content.dart';
import 'package:survey_kit/src/model/step.dart';

/// It is uppercase to support previous implementions of the CompletionnStep
@Deprecated('Create Step from Step.dart')
// ignore: non_constant_identifier_names
Step CompletionStep({
  String? id,
  required String title,
  required String text,
  String? buttonText,
}) =>
    Step(
      id: id,
      content: [
        TextContent(
          text: title,
          fontSize: 22,
        ),
        TextContent(
          text: text,
        ),
        const LottieContent(
          asset: 'assets/fancy_checkmark.json',
        ),
      ],
      buttonText: buttonText,
    );
