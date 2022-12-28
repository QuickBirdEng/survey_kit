import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer.dart';
import 'package:survey_kit/src/model/answer/option.dart';

part 'single_select_answer.g.dart';

@JsonSerializable()
class SingleSelectAnswer implements Answer {
  static const String type = 'single';

  final List<Option> options;
  final Option? defaultSelection;

  const SingleSelectAnswer({
    required this.options,
    this.defaultSelection,
  });

  factory SingleSelectAnswer.fromJson(Map<String, dynamic> json) =>
      _$SingleSelectAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$SingleSelectAnswerToJson(this);
}
