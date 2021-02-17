import 'package:flutter/widgets.dart';
import 'package:surveykit/src/steps/identifier/identifier.dart';
import 'package:surveykit/src/result/question_result.dart';

class TextQuestionResult extends QuestionResult<String> {
  TextQuestionResult({
    @required Identifier id,
    @required DateTime startDate,
    @required DateTime endDate,
    @required String valueIdentifier,
    @required String result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );
}
