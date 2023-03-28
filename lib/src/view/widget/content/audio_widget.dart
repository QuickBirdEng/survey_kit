import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/audio_content.dart';
import 'package:survey_kit/src/widget/test_audio.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({
    super.key,
    required this.audioContent,
  });

  final AudioContent audioContent;

  @override
  Widget build(BuildContext context) {
    return JustAudioWidget(
      audioUrl: audioContent.url,
    );
  }
}
