import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';

part 'multiple_choice_auto_complete_answer_format.g.dart';

/// Answer format that allows selecting multiple items from a searchable
/// autocomplete list. The JSON type identifier is `'multiple_auto_complete'`.
@JsonSerializable()
class MultipleChoiceAutoCompleteAnswerFormat extends AnswerFormat {
  static const String type = 'multiple_auto_complete';

  /// The full list of available options to display.
  @JsonKey(name: 'textChoices')
  final List<TextChoice> choices;

  /// Options pre-selected when the step is first shown.
  @JsonKey(defaultValue: <TextChoice>[])
  final List<TextChoice> defaultSelection;

  /// Options shown as quick-pick suggestions before the user starts typing.
  @JsonKey(defaultValue: <TextChoice>[])
  final List<TextChoice> suggestions;

  /// When true, an additional free-text 'Other' field is shown.
  @JsonKey(defaultValue: false)
  final bool otherField;

  const MultipleChoiceAutoCompleteAnswerFormat({
    required this.choices,
    this.defaultSelection = const [],
    this.suggestions = const [],
    this.otherField = false,
    super.question,
    super.answerType = MultipleChoiceAutoCompleteAnswerFormat.type,
  }) : super();

  factory MultipleChoiceAutoCompleteAnswerFormat.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MultipleChoiceAutoCompleteAnswerFormatFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$MultipleChoiceAutoCompleteAnswerFormatToJson(this);
}
