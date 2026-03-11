import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/util/int_extension.dart';

part 'integer_answer_format.g.dart';

/// Answer format for a whole number entry. Renders as a text field that
/// accepts integer values. The JSON type identifier is `'integer'`.
@JsonSerializable()
class IntegerAnswerFormat extends AnswerFormat {
  static const String type = 'integer';

  /// Pre-filled value when the question is first shown.
  final int? defaultValue;

  /// Placeholder text shown in the input field.
  final String hint;

  /// Minimum accepted value. Defaults to the platform minimum integer.
  final int min;

  /// Maximum accepted value. Defaults to the platform maximum integer.
  final int max;

  const IntegerAnswerFormat({
    this.defaultValue,
    this.hint = '',
    this.min = minInt,
    this.max = maxInt,
    super.question,
    super.answerType = IntegerAnswerFormat.type,
  }) : super();

  factory IntegerAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$IntegerAnswerFormatFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$IntegerAnswerFormatToJson(this);
}
