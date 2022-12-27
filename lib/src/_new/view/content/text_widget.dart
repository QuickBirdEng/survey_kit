import 'package:flutter/material.dart';
import 'package:survey_kit/src/_new/model/content/text_content.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.textContent,
  });

  final TextContent textContent;

  @override
  Widget build(BuildContext context) {
    return Text(
      textContent.text,
    );
  }
}
