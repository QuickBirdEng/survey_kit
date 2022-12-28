import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer.dart';
import 'package:survey_kit/src/model/answer/option.dart';

part 'multi_select_answer.g.dart';

@JsonSerializable()
class MultiSelectAnswer implements Answer {
  static const String type = 'multi';

  final List<Option> options;
  final Option? defaultSelection;
  @JsonKey(defaultValue: false)
  final bool otherField;

  const MultiSelectAnswer({
    required this.options,
    this.otherField = false,
    this.defaultSelection,
  });

  factory MultiSelectAnswer.fromJson(Map<String, dynamic> json) =>
      _$MultiSelectAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$MultiSelectAnswerToJson(this);
}
