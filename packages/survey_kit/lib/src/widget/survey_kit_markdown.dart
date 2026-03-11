import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class SurveyKitMarkdown extends StatelessWidget {
  const SurveyKitMarkdown({
    super.key,
    required this.markdown,
  });

  final String markdown;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: markdown,
      selectable: true,
    );
  }
}
