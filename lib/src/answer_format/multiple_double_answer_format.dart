import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';
import 'package:survey_kit/src/answer_format/multi_double.dart';

part 'multiple_double_answer_format.g.dart';

@JsonSerializable()
class MultipleDoubleAnswerFormat implements AnswerFormat {
  final List<MultiDouble> multiDouble;
  @JsonKey(defaultValue: const [])
  final List<MultiDouble> defaultValues;

  const MultipleDoubleAnswerFormat({
    required this.multiDouble,
    this.defaultValues = const [],
  }) : super();

  factory MultipleDoubleAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$DoubleAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$DoubleAnswerFormatToJson(this);
}
