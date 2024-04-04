import '../content/text_content.dart';
import '../step.dart';

/// It is uppercase to support previous implementions of the InstructionStep
@Deprecated('Create Step from Step.dart')
// ignore: non_constant_identifier_names
Step InstructionStep({
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
      ],
      buttonText: buttonText,
    );
