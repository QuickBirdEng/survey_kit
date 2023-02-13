import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/video_content.dart';
import 'package:survey_kit/src/widget/survey_kit_video_player.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
    required this.videoContent,
  });

  final VideoContent videoContent;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 100,
        maxHeight: videoContent.height ?? 500,
        maxWidth: videoContent.width ?? double.infinity,
      ),
      child: SurveyKitVideoPlayer(
        videoUrl: videoContent.url,
        autoPlay: videoContent.autoPlay,
        loop: videoContent.loop,
      ),
    );
  }
}
