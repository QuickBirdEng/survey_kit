import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';

part 'text_answer_format.g.dart';

@JsonSerializable()
class TextAnswerFormat implements AnswerFormat {
  final int? maxLines;
  @JsonKey(defaultValue: '')
  final String hint;

  /// Regular expression by which the text gets validated
  ///  e.g '^(?!\s*$).+' checks if the entered text is empty
  final String? validationRegEx;

  const TextAnswerFormat({
    this.maxLines,
    this.hint = '',
    this.validationRegEx,
  }) : super();

  factory TextAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$TextAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$TextAnswerFormatToJson(this);
}
