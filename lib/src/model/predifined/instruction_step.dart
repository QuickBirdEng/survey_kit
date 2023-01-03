import 'package:survey_kit/src/model/content/text_content.dart';
import 'package:survey_kit/src/model/step.dart';

/// It is uppercase to support previous implementions of the InstructionStep
// ignore: non_constant_identifier_names
Step InstructionStep({
  required String title,
  required String text,
}) =>
    Step(
      content: [
        TextContent(
          text: title,
          fontSize: 22,
        ),
        TextContent(
          text: text,
        ),
      ],
    );
