import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/video_content.dart';
import 'package:survey_kit/src/util/ui_utils.dart';
import 'package:survey_kit/src/widget/link.dart';
import 'package:survey_kit/src/widget/survey_kit_video_player.dart';
import 'package:survey_kit/src/widget/web_video_player.dart';

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
          Text(
            videoContent.title!,
            style: theme.textTheme.titleLarge,
          ),
          smallVerticalSpacer,
        ],
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 100,
            maxHeight: videoContent.height ?? 550,
            maxWidth: videoContent.width ?? double.infinity,
          ),
          child: widget,
        ),
        if (videoContent.subtitle != null) ...[
          smallVerticalSpacer,
          Text(
            videoContent.subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
        ],
        if (videoContent.externalLink != null) ...[
          smallVerticalSpacer,
          LinkText(link: videoContent.externalLink!)
        ],
      ],
    );
  }
}
