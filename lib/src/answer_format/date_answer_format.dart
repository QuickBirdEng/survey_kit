import 'package:survey_kit/src/answer_format/answer_format.dart';

class DateAnswerFormat implements AnswerFormat {
  /// Default date which will be preselected on datepicker opening
  final DateTime? defaultDate;

  /// Lowest date which can be selected via the datepicker
  final DateTime? minDate;

  /// Highest date which can be selected via the datepicker
  final DateTime? maxDate;

  DateAnswerFormat({
    this.defaultDate,
    this.minDate,
    this.maxDate,
  })  : assert(minDate == null || maxDate == null || minDate.isBefore(maxDate)),
        assert(defaultDate == null ||
            minDate == null ||
            defaultDate.isAtSameMomentAs(minDate) ||
            defaultDate.isAfter(minDate)),
        assert(defaultDate == null ||
            maxDate == null ||
            defaultDate.isAtSameMomentAs(maxDate) ||
            defaultDate.isBefore(maxDate));
}
