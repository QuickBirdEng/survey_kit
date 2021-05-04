import 'package:survey_kit/src/answer_format/answer_format.dart';

class DateAnswerFormat implements AnswerFormat {
  final DateTime? defaultDate;
  final DateTime? minDate;
  final DateTime? maxDate;

  DateAnswerFormat({
    this.defaultDate,
    this.minDate,
    this.maxDate,
  });
}
