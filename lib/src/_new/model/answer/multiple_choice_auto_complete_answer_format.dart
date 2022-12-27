import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/_new/model/answer/answer.dart';
import 'package:survey_kit/src/_new/model/answer/option.dart';

part 'multiple_choice_auto_complete_answer_format.g.dart';

@JsonSerializable()
class MultipleChoiceAutoCompleteAnswerFormat implements Answer {
  static const String type = 'multiple_auto_complete';

  final List<Option> textChoices;
  @JsonKey(defaultValue: <Option>[])
  final List<Option> defaultSelection;
  @JsonKey(defaultValue: <Option>[])
  final List<Option> suggestions;
  @JsonKey(defaultValue: false)
  final bool otherField;

  const MultipleChoiceAutoCompleteAnswerFormat({
    required this.textChoices,
    this.defaultSelection = const [],
    this.suggestions = const [],
    this.otherField = false,
  }) : super();

  factory MultipleChoiceAutoCompleteAnswerFormat.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MultipleChoiceAutoCompleteAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MultipleChoiceAutoCompleteAnswerFormatToJson(this);
}
