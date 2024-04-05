import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/view/widget/content/markdown_widget.dart';

part 'markdown_content.g.dart';

@JsonSerializable()
class MarkdownContent extends Content {
  static const type = 'markdown';

  final String text;

  const MarkdownContent({
    required this.text,
    super.id,
  }) : super(contentType: type);

  factory MarkdownContent.fromJson(Map<String, dynamic> json) =>
      _$MarkdownContentFromJson(json);

  Map<String, dynamic> toJson() => _$MarkdownContentToJson(this);

  @override
  Widget createWidget() {
    return MarkdownWidget(markdownContent: this);
  }
}
