import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surveykit/src/steps/identifier/identifier.dart';
import 'package:surveykit/src/result/question_result.dart';

class TimeQuestionResult extends QuestionResult<TimeOfDay> {
  TimeQuestionResult({
    @required Identifier id,
    @required DateTime startDate,
    @required DateTime endDate,
    @required String valueIdentifier,
    @required TimeOfDay result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );
}
