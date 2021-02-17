import 'package:flutter/widgets.dart';
import 'package:surveykit/src/result/result.dart';
import 'package:surveykit/src/steps/identifier/identifier.dart';
import 'package:surveykit/src/result/question_result.dart';

class StepResult extends Result {
  final List<QuestionResult> results;

  StepResult(
      {@required Identifier id,
      @required DateTime startDate,
      @required DateTime endDate,
      @required this.results})
      : super(id: id, startDate: startDate, endDate: endDate);

  factory StepResult.fromQuestion({@required QuestionResult questionResult}) {
    return StepResult(
      id: questionResult.id,
      startDate: questionResult.startDate,
      endDate: questionResult.endDate,
      results: [questionResult],
    );
  }
}
