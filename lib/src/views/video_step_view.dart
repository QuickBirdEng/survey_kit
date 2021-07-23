import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/result/step/video_step_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/video_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class VideoStepView extends StatefulWidget {
  final QuestionResult? questionResult;
  final VideoStep videoStep;

  const VideoStepView({
    Key? key,
    required this.videoStep,
    this.questionResult,
  }) : super(key: key);

  @override
  _VideoStepViewState createState() => _VideoStepViewState();
}

class _VideoStepViewState extends State<VideoStepView> {
  final DateTime _startDate = DateTime.now();

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    final videoStep = widget.videoStep;

    _videoPlayerController =
        VideoPlayerController.network(widget.videoStep.url);
    await _videoPlayerController?.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: videoStep.isAutoPlay,
        looping: videoStep.isLooping,
        fullScreenByDefault: videoStep.isAutomaticFullscreen,
        allowMuting: videoStep.allowMuting,
      );

      //It should go automaticly to the next step after the video is finished
      if (videoStep.goToNextPageAfterEnd)
        _chewieController?.videoPlayerController
            .addListener(() => _videoHasEndedListener());
    });
  }

  void _videoHasEndedListener() {
    if (_videoPlayerController!.value.position ==
        _videoPlayerController!.value.duration) {
      final surveyController = context.read<SurveyController>();

      _chewieController?.exitFullScreen();
      final end = DateTime.now();
      final videoResult = VideoResult(
          leftVideoAt:
              Duration(milliseconds: end.millisecond - _startDate.millisecond),
          stayedInVideo: end);
      WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {
            surveyController.nextStep(
              context,
              () {
                return VideoStepResult(
                  id: widget.videoStep.stepIdentifier,
                  startDate: _startDate,
                  endDate: DateTime.now(),
                  videoResult: videoResult,
                );
              },
            );
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      if (widget.videoStep.isAutomaticFullscreen &&
          !(_chewieController?.isFullScreen ?? false)) {
        _chewieController?.enterFullScreen();
      }
      return StepView(
        resultFunction: () {
          final end = DateTime.now();
          final videoResult = VideoResult(
            leftVideoAt: Duration(
                milliseconds: end.millisecond - _startDate.millisecond),
            stayedInVideo: end,
          );

          return VideoStepResult(
            id: widget.videoStep.stepIdentifier,
            startDate: _startDate,
            endDate: DateTime.now(),
            videoResult: videoResult,
          );
        },
        step: widget.videoStep,
        title: SizedBox.shrink(),
        child: Container(
          width: widget.videoStep.width ?? MediaQuery.of(context).size.width,
          height: widget.videoStep.height ??
              MediaQuery.of(context).size.width / (16 / 9),
          child: Chewie(
            controller: _chewieController!,
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
