import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit_video/src/link.dart';
import 'package:survey_kit_video/src/video_content.dart';
import 'package:survey_kit_video/src/web_video_player.dart';

import 'survey_kit_video_player.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
    required this.videoContent,
  });

  final VideoContent videoContent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final widget = kIsWeb
        ? WebVideoPlayer(
            videoContent.url,
            autoplay: videoContent.autoPlay,
            loop: videoContent.loop,
          )
        : SurveyKitVideoPlayer(
            videoUrl: videoContent.url,
            autoPlay: videoContent.autoPlay,
            loop: videoContent.loop,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (videoContent.title != null) ...[
          SelectableText(
            videoContent.title!,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 12,
          ),
        ],
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 100,
            maxHeight: videoContent.height ?? 550,
            maxWidth: videoContent.width ?? double.infinity,
          ),
          child: widget,
        ),
        if (videoContent.externalLink != null) ...[
          const SizedBox(
            height: 12,
          ),
          LinkText(link: videoContent.externalLink!),
        ],
        if (videoContent.subtitle != null) ...[
          const SizedBox(
            height: 12,
          ),
          SelectableText(
            videoContent.subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
        ],
      ],
    );
  }
}
