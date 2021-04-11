import 'package:survey_kit/src/answer_format/answer_format.dart';

class IntegerAnswerFormat implements AnswerFormat {
  final int? defaultValue;
  final String hint;

  IntegerAnswerFormat({
    this.defaultValue,
    this.hint = '',
  });
}
