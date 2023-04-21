import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/section_content.dart';
import 'package:survey_kit/src/util/ui_utils.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.sectionContent,
  });

  final SectionContent sectionContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sectionContent.toList
          .map(
            (e) => StyledTextWidget(content: e),
          )
          .separate(verySmallVerticalSpacer)
          .toList(),
    );
  }
}

class StyledTextWidget extends StatelessWidget {
  const StyledTextWidget({
    super.key,
    required this.content,
  });

  final StyledText content;

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

extension on Iterable<Widget> {
  Iterable<Widget> separate(Widget separator) {
    return [
      ...expand((element) => [element, separator]),
    ]..removeLast();
  }
}
