import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';

part 'markdown_content.g.dart';

/// Content that renders a markdown string.
/// The JSON type identifier is `'markdown'`.
@JsonSerializable()
class MarkdownContent extends Content {
  static const type = 'markdown';

  /// The markdown-formatted string to render.
  final String text;

  const MarkdownContent({
    required this.text,
    super.id,
  }) : super(contentType: type);

  factory MarkdownContent.fromJson(Map<String, dynamic> json) =>
      _$MarkdownContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MarkdownContentToJson(this);
}
