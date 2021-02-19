import 'package:survey_kit/src/answer_format/answer_format.dart';

class TextAnswerFormat implements AnswerFormat {
  final int maxLines;
  final String hint;
  final bool Function(String) isValid;

  TextAnswerFormat({
    this.maxLines,
    this.hint = '',
    this.isValid,
  });
}
