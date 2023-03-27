import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/video_content.dart';
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
    if (kIsWeb) return WebVideoPlayer(videoContent.url);

    final widget = kIsWeb
        ? WebVideoPlayer(videoContent.url)
        : SurveyKitVideoPlayer(
            videoUrl: videoContent.url,
            autoPlay: videoContent.autoPlay,
            loop: videoContent.loop,
          );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 100,
        maxHeight: videoContent.height ?? 500,
        maxWidth: videoContent.width ?? double.infinity,
      ),
      child: widget,
    );
  }
}
