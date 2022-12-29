import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/util/extension.dart';
import 'package:survey_kit/src/view/content/audio_widget.dart';
import 'package:survey_kit/src/view/content/lottie_widget.dart';
import 'package:survey_kit/src/view/content/markdown_widget.dart';
import 'package:survey_kit/src/view/content/text_widget.dart';
import 'package:survey_kit/src/view/content/video_widget.dart';
import 'package:survey_kit/survey_kit.dart';

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
      children: widget.content
          .map((e) {
            if (e is AudioContent) {
              return AudioWidget(audioContent: e);
            } else if (e is VideoContent) {
              return VideoWidget(videoContent: e);
            } else if (e is MarkdownContent) {
              return MarkdownWidget(markdownContent: e);
            } else if (e is TextContent) {
              return TextWidget(textContent: e);
            } else if (e is LottieContent) {
              return LottieWidget(lottieContent: e);
            }
            throw Exception('Content type not supported: ${e.runtimeType}');
          })
          .withSeparator(
            const _Separator(
              height: 14,
            ),
          )
          .toList(),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
