import 'package:survey_kit/survey_kit.dart';

/// It is uppercase to support previous implementions of the QuestionStep
@Deprecated('Create Step from Step.dart')
// ignore: non_constant_identifier_names
Step QuestionStep({
  String? id,
  required String title,
  String text = '',
  required AnswerFormat answerFormat,
  bool isOptional = true,
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
      answerFormat: answerFormat,
      isMandatory: !isOptional,
      buttonText: buttonText,
    );
