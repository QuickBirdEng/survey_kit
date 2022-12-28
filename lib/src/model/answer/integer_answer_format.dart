import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer.dart';

part 'integer_answer_format.g.dart';

@JsonSerializable()
class IntegerAnswerFormat implements Answer {
  static const String type = 'integer';

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
