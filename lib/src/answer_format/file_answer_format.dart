import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';

part 'file_answer_format.g.dart';

@JsonSerializable()
class FileAnswerFormat implements AnswerFormat {
  final String? defaultValue;
  final String hint;

  const FileAnswerFormat({
    this.defaultValue,
    this.hint = '',
  }) : super();

  factory FileAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$FileAnswerFormatFromJson(json);

  Map<String, dynamic> toJson() => _$FileAnswerFormatToJson(this);
}
