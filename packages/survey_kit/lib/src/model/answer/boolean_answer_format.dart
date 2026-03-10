import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';

part 'boolean_answer_format.g.dart';

@JsonSerializable()
class BooleanAnswerFormat extends AnswerFormat {
  static const String type = 'bool';

  final String positiveAnswer;
  final String negativeAnswer;
  @JsonKey(name: 'result')
  final BooleanResult defaultValue;

  const BooleanAnswerFormat({
    required this.positiveAnswer,
    required this.negativeAnswer,
    this.defaultValue = BooleanResult.none,
    super.question,
    super.answerType = BooleanAnswerFormat.type,
  }) : super();

  factory BooleanAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$BooleanAnswerFormatFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$BooleanAnswerFormatToJson(this);
}

@JsonEnum()
enum BooleanResult { none, positive, negative }
