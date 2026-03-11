// by Antonio Bruno, Giacomo Ignesti and Massimo Martinelli

import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';

part 'double_answer_format.g.dart';

/// Answer format for a decimal number entry. Renders as a text field that
/// accepts floating-point values. The JSON type identifier is `'double'`.
@JsonSerializable()
class DoubleAnswerFormat extends AnswerFormat {
  static const String type = 'double';

  /// Pre-filled value when the question is first shown.
  final double? defaultValue;

  /// Placeholder text shown in the input field.
  final String hint;

  const DoubleAnswerFormat({
    this.defaultValue,
    this.hint = '',
    super.question,
    super.answerType = DoubleAnswerFormat.type,
  }) : super();

  factory DoubleAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$DoubleAnswerFormatFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DoubleAnswerFormatToJson(this);
}
