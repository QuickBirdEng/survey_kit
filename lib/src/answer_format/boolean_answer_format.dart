import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';

part 'boolean_answer_format.g.dart';

@JsonSerializable()
class BooleanAnswerFormat implements AnswerFormat {
  final String positiveAnswer;
  final String negativeAnswer;
  final BooleanResult result;
  final BooleanResult? defaultValue;

  const BooleanAnswerFormat({
    required this.positiveAnswer,
    required this.negativeAnswer,
    this.result = BooleanResult.NONE,
    this.defaultValue,
  }) : super();

  factory BooleanAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$BooleanAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$BooleanAnswerFormatToJson(this);
}

enum BooleanResult { NONE, POSITIVE, NEGATIVE }
