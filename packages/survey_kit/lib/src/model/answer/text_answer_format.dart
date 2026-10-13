import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';

part 'text_answer_format.g.dart';

/// Answer format for free-text entry. The JSON type identifier is `'text'`.
@JsonSerializable()
class TextAnswerFormat extends AnswerFormat {
  static const String type = 'text';

  /// Maximum number of lines in the text field. Null means unlimited.
  final int? maxLines;
  @JsonKey(defaultValue: '')
  final String hint;

  /// Regular expression by which the text gets validated
  /// default: '^(?!\s*$).+' that checks if the entered text is empty
  /// to allow any type of an answer including an empty one;
  /// set it explicitly to null.
  ///
  @JsonKey(defaultValue: defaultValidationRegEx)
  final String? validationRegEx;

  /// The default [validationRegEx], which rejects empty or whitespace-only
  /// input.
  static const String defaultValidationRegEx = r'^(?!\s*$).+';

  const TextAnswerFormat({
    this.maxLines,
    this.hint = '',
    this.validationRegEx = defaultValidationRegEx,
    super.question,
  }) : super(answerType: TextAnswerFormat.type);

  factory TextAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$TextAnswerFormatFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TextAnswerFormatToJson(this);
}
