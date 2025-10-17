import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/styled_text_content.dart';

class StyledTextWidget extends StatelessWidget {
  const StyledTextWidget({
    super.key,
    required this.content,
  });

  final StyledTextContent content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SelectableText(
      content.text,
      style: theme.textTheme.bodyMedium?.copyWith(
        decoration:
            content.underlined ? TextDecoration.underline : TextDecoration.none,
        fontSize: content.fontSize,
        fontWeight: content.bold ? FontWeight.bold : FontWeight.normal,
        fontStyle: content.italic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
