import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/steps/cms_steps/cms_content_step.dart';
import 'package:survey_kit/src/widget/survey_kit_video_player.dart';

part 'video_cms_step.g.dart';

@JsonSerializable(explicitToJson: true)
class VideoCMSStep extends Content {
  final String videoUrl;

  VideoCMSStep({
    required this.videoUrl,
  });

  @override
  Widget createView() {
    return SurveyKitVideoPlayer(
      videoUrl: videoUrl,
    );
  }

  factory VideoCMSStep.fromJson(Map<String, dynamic> json) =>
      _$VideoCMSStepFromJson(json);
  Map<String, dynamic> toJson() => _$VideoCMSStepToJson(this);
}
