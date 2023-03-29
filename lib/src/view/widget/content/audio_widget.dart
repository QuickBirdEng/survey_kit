import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/audio_content.dart';
import 'package:survey_kit/src/widget/survey_kit_audio_player.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({
    super.key,
    required this.audioContent,
  });

  final AudioContent audioContent;

  @override
  Widget build(BuildContext context) {
    return SurveyKitAudioPlayer(
      audioUrl: audioContent.url,
    );
  }
}
