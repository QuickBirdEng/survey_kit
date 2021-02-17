import 'package:flutter/widgets.dart';
import 'package:surveykit/src/result/question_result.dart';
import 'package:surveykit/src/steps/identifier/identifier.dart';

class DateQuestionResult extends QuestionResult<DateTime> {
  DateQuestionResult({
    @required Identifier id,
    @required DateTime startDate,
    @required DateTime endDate,
    @required String valueIdentifier,
    @required DateTime result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );
}
