import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SurveyKitVideoPlayer extends StatefulWidget {
  const SurveyKitVideoPlayer({
    super.key,
    required this.videoUrl,
    this.loop = false,
    this.autoPlay = false,
  });

  final String videoUrl;
  final bool loop;
  final bool autoPlay;

  @override
  State<SurveyKitVideoPlayer> createState() => _SurveyKitVideoPlayerState();
}

class _SurveyKitVideoPlayerState extends State<SurveyKitVideoPlayer> {
  final Key _visibilityKey = UniqueKey();
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant SurveyKitVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl ||
        oldWidget.loop != widget.loop ||
        oldWidget.autoPlay != widget.autoPlay) {
      _disposeControllers();
      _initialize();
    }
  }

  Future<void> _initialize() async {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    _controller = controller;
    _hasError = false;
    try {
      await controller.initialize();
    } catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'survey_kit_video',
          context: ErrorDescription('while initializing video'),
        ),
      );
      if (mounted && controller == _controller) {
        setState(() => _hasError = true);
      }
      return;
    }
    if (!mounted || controller != _controller) {
      return;
    }
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: widget.autoPlay,
        looping: widget.loop,
      );
    });
  }

  void _retry() {
    setState(_disposeControllers);
    _initialize();
  }

  void _disposeControllers() {
    _chewieController?.dispose();
    _chewieController = null;
    _controller?.dispose();
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.videocam_off_outlined, size: 48),
              IconButton(icon: const Icon(Icons.refresh), onPressed: _retry),
            ],
          ),
        ),
      );
    }

    final chewieController = _chewieController;
    if (chewieController == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    return AspectRatio(
      aspectRatio: chewieController.aspectRatio ?? 16 / 9,
      child: VisibilityDetector(
        key: _visibilityKey,
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 0 && mounted) {
            _controller?.pause();
          }
        },
        child: Chewie(controller: chewieController),
      ),
    );
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }
}
