import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/option.dart';

part 'single_choice_answer_format.g.dart';

@JsonSerializable()
class SingleChoiceAnswerFormat implements AnswerFormat {
  static const String type = 'single';

  final List<Option> options;
  final Option? defaultSelection;

  const SingleChoiceAnswerFormat({
    required this.options,
    this.defaultSelection,
  });

  factory SingleChoiceAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$SingleChoiceAnswerFormatFromJson(json);

  Map<String, dynamic> toJson() => _$SingleChoiceAnswerFormatToJson(this);
}
