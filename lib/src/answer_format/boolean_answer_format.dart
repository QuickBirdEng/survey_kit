import 'package:survey_kit/src/answer_format/answer_format.dart';

class BooleanAnswerFormat implements AnswerFormat {
  final String positiveAnswer;
  final String negativeAnswer;
  final BooleanResult result;

  BooleanAnswerFormat({
    required this.positiveAnswer,
    required this.negativeAnswer,
    this.result = BooleanResult.NONE,
  });
}

enum BooleanResult { NONE, POSITIVE, NEGATIVE }
