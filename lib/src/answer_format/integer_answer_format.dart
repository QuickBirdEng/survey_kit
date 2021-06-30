import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';

part 'integer_answer_format.g.dart';

@JsonSerializable()
class IntegerAnswerFormat implements AnswerFormat {
  final int? defaultValue;
  final String hint;

  const IntegerAnswerFormat({
    this.defaultValue,
    this.hint = '',
  }) : super();

  factory IntegerAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$IntegerAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$IntegerAnswerFormatToJson(this);
}
