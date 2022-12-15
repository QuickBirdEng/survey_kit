import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/steps/cms_steps/cms_content_step.dart';
import 'package:survey_kit/src/widget/survey_kit_audio_player.dart';

part 'audio_cms_step.g.dart';

@JsonSerializable(explicitToJson: true)
class AudioCMSStep extends Content {
  final String audioUrl;

  AudioCMSStep({
    required this.audioUrl,
  });

  @override
  Widget createView() {
    return SurveyKitAudioPlayer(
      audioUrl: audioUrl,
    );
  }

  factory AudioCMSStep.fromJson(Map<String, dynamic> json) =>
      _$AudioCMSStepFromJson(json);
  Map<String, dynamic> toJson() => _$AudioCMSStepToJson(this);
}
