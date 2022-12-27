import 'package:flutter/material.dart';
import 'package:survey_kit/src/_new/model/content/audio_content.dart';
import 'package:survey_kit/src/_new/model/content/content.dart';
import 'package:survey_kit/src/_new/model/content/markdown_content.dart';
import 'package:survey_kit/src/_new/model/content/text_content.dart';
import 'package:survey_kit/src/_new/model/content/video_content.dart';
import 'package:survey_kit/src/_new/view/content/audio_widget.dart';
import 'package:survey_kit/src/_new/view/content/markdown_widget.dart';
import 'package:survey_kit/src/_new/view/content/text_widget.dart';
import 'package:survey_kit/src/_new/view/content/video_widget.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({
    super.key,
    required this.content,
  });

  final List<Content> content;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.content.map((e) {
        if (e is AudioContent) {
          return AudioWidget(audioContent: e);
        } else if (e is VideoContent) {
          return VideoWidget(videoContent: e);
        } else if (e is MarkdownContent) {
          return MarkdownWidget(markdownContent: e);
        } else if (e is TextContent) {
          return TextWidget(textContent: e);
        }
        throw Exception('Content type not supported: ${e.runtimeType}');
      }).toList(),
    );
  }
}
