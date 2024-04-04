import 'package:flutter/material.dart';

import '../../../model/content/section_content.dart';
import '../../../util/ui_utils.dart';
import 'styled_text_widget.dart';

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

extension on Iterable<Widget> {
  Iterable<Widget> separate(Widget separator) {
    return [
      ...expand((element) => [element, separator]),
    ]..removeLast();
  }
}
