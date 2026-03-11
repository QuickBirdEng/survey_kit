import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/multi_double.dart';

part 'multiple_double_answer_format.g.dart';

/// Answer format for entering multiple decimal values at once, each with its
/// own label. The JSON type identifier is `'multiple_double'`.
@JsonSerializable()
class MultipleDoubleAnswerFormat extends AnswerFormat {
  static const String type = 'multiple_double';

  /// Pre-filled values when the question is first shown.
  final List<MultiDouble>? defaultValues;

  /// Placeholder labels shown next to each input field.
  @JsonKey(defaultValue: <String>[])
  final List<String> hints;

  const MultipleDoubleAnswerFormat({
    this.defaultValues,
    required this.hints,
    super.question,
    super.answerType = MultipleDoubleAnswerFormat.type,
  }) : super();

  factory MultipleDoubleAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$MultipleDoubleAnswerFormatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MultipleDoubleAnswerFormatToJson(this);
}
