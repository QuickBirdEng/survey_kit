import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/markdown_content.dart';
import 'package:survey_kit/src/widget/survey_kit_markdown.dart';

class MarkdownWidget extends StatelessWidget {
  const MarkdownWidget({
    super.key,
    required this.markdownContent,
  });

  final MarkdownContent markdownContent;

  @override
  Widget build(BuildContext context) {
    return SurveyKitMarkdown(
      markdown: markdownContent.text,
    );
  }
}
