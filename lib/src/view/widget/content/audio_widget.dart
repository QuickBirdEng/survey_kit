import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/audio_content.dart';
import 'package:survey_kit/src/util/ui_utils.dart';
import 'package:survey_kit/src/widget/link.dart';
import 'package:survey_kit/src/widget/survey_kit_audio_player.dart';
import 'package:survey_kit/survey_kit.dart';

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
          smallVerticalSpacer,
        ],
        SurveyKitAudioPlayer(
          audioUrl: audioContent.url,
        ),
        if (audioContent.subtitle != null) ...[
          smallVerticalSpacer,
          SelectableText(
            audioContent.subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
        ],
        if (audioContent.externalLink != null) ...[
          smallVerticalSpacer,
          LinkText(
            link: audioContent.externalLink!,
          )
        ],
      ],
    );
  }
}
