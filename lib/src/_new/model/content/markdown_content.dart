import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/_new/model/content/content.dart';

part 'markdown_content.g.dart';

@JsonSerializable()
class MarkdownContent extends Content {
  final String text;

  const MarkdownContent({
    required super.id,
    required this.text,
  });

  factory MarkdownContent.fromJson(Map<String, dynamic> json) =>
      _$MarkdownContentFromJson(json);

  Map<String, dynamic> toJson() => _$MarkdownContentToJson(this);
}
