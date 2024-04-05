import 'package:flutter/material.dart';
import 'package:survey_kit_audio/audio_content.dart';
import 'package:survey_kit_audio/link.dart';
import 'package:survey_kit_audio/survey_kit_audio_player.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({
    super.key,
    required this.audioContent,
  });

  final AudioContent audioContent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (audioContent.title != null) ...[
          SelectableText(
            audioContent.title!,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 12,
          ),
        ],
        SurveyKitAudioPlayer(
          audioUrl: audioContent.url,
        ),
        if (audioContent.externalLink != null) ...[
          const SizedBox(
            height: 12,
          ),
          LinkText(
            link: audioContent.externalLink!,
          ),
        ],
        if (audioContent.subtitle != null) ...[
          const SizedBox(
            height: 12,
          ),
          SelectableText(
            audioContent.subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
        ],
      ],
    );
  }
}
