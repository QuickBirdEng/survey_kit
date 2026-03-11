import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';

part 'scale_answer_format.g.dart';

/// Answer format that presents a slider for picking a value in a range.
/// The JSON type identifier is `'scale'`.
@JsonSerializable()
class ScaleAnswerFormat extends AnswerFormat {
  static const String type = 'scale';

  /// The highest value on the scale.
  final double maximumValue;

  /// The lowest value on the scale.
  final double minimumValue;

  /// The initial slider position.
  final double defaultValue;

  /// The increment between selectable values.
  final double step;

  /// Label shown at the high end of the scale.
  final String maximumValueDescription;

  /// Label shown at the low end of the scale.
  final String minimumValueDescription;

  const ScaleAnswerFormat({
    required this.maximumValue,
    required this.minimumValue,
    required this.defaultValue,
    required this.step,
    this.maximumValueDescription = '',
    this.minimumValueDescription = '',
    super.question,
    super.answerType = ScaleAnswerFormat.type,
  }) : super();

  factory ScaleAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$ScaleAnswerFormatFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ScaleAnswerFormatToJson(this);
}
