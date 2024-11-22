import 'package:survey_kit/src/result/result.dart';

abstract class QuestionResult<T> extends Result {
  final T? result;
  final String? valueIdentifier;
  const QuestionResult({
    required super.id,
    required super.startDate,
    required super.endDate,
    required this.valueIdentifier,
    required this.result,
  });
}
