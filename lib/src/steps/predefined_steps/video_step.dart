import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/views/video_step_view.dart';

part 'video_step.g.dart';

@JsonSerializable()
class VideoStep extends Step {
  @JsonKey(defaultValue: false)
  final bool isAutoPlay;
  @JsonKey(defaultValue: false)
  final bool isAutomaticFullscreen;
  @JsonKey(defaultValue: false)
  final bool goToNextPageAfterEnd;
  @JsonKey(defaultValue: false)
  final bool isLooping;
  @JsonKey(defaultValue: false)
  final bool allowMuting;
  final double? width;
  final double? height;
  final String url;

  VideoStep({
    required this.url,
    this.isAutoPlay = false,
    this.isAutomaticFullscreen = false,
    this.goToNextPageAfterEnd = false,
    this.isLooping = false,
    this.allowMuting = true,
    this.width,
    this.height,
    bool isOptional = false,
    String buttonText = 'Next',
    StepIdentifier? stepIdentifier,
  }) : super(
          isOptional: isOptional,
          buttonText: buttonText,
          stepIdentifier: stepIdentifier,
        );

  factory VideoStep.fromJson(Map<String, dynamic> json) =>
      _$VideoStepFromJson(json);
  Map<String, dynamic> toJson() => _$VideoStepToJson(this);

  @override
  Widget createView({required QuestionResult? questionResult}) {
    return VideoStepView(
      videoStep: this,
      questionResult: questionResult,
    );
  }

  bool operator ==(o) =>
      super == (o) &&
      o is VideoStep &&
      o.isAutoPlay == isAutoPlay &&
      o.allowMuting == allowMuting &&
      o.goToNextPageAfterEnd == goToNextPageAfterEnd &&
      o.height == height &&
      o.width == width &&
      o.isAutomaticFullscreen == isAutomaticFullscreen &&
      o.isLooping == isLooping;
  int get hashCode =>
      super.hashCode ^
      isAutoPlay.hashCode ^
      allowMuting.hashCode ^
      goToNextPageAfterEnd.hashCode ^
      height.hashCode ^
      width.hashCode ^
      isAutomaticFullscreen.hashCode ^
      isLooping.hashCode;
}
