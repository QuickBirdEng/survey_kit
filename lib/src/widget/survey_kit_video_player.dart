import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SurveyKitVideoPlayer extends StatefulWidget {
  const SurveyKitVideoPlayer({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<SurveyKitVideoPlayer> createState() => _SurveyKitVideoPlayerState();
}

class _SurveyKitVideoPlayerState extends State<SurveyKitVideoPlayer> {
  late final VideoPlayerController _controller;
  late final ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: true,
        );
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _chewieController.aspectRatio ?? 16 / 9,
            child: VisibilityDetector(
              key: Key(widget.videoUrl),
              onVisibilityChanged: (info) {
                if (info.visibleFraction == 0) {
                  _controller.pause();
                }
              },
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause().then((value) {
      _chewieController.dispose();
      _controller.dispose();
    });
  }
}
