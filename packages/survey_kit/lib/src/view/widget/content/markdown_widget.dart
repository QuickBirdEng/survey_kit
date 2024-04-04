import 'package:flutter/material.dart';

import '../../../model/content/markdown_content.dart';
import '../../../widget/survey_kit_markdown.dart';

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
