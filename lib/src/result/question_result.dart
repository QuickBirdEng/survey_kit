import 'package:flutter/widgets.dart';
import 'package:surveykit/src/result/result.dart';
import 'package:surveykit/src/steps/identifier/identifier.dart';

abstract class QuestionResult<T> extends Result {
  final T result;
  final String valueIdentifier;
  QuestionResult({
    @required Identifier id,
    @required DateTime startDate,
    @required DateTime endDate,
    @required this.valueIdentifier,
    @required this.result,
  }) : super(id: id, startDate: startDate, endDate: endDate);
}
