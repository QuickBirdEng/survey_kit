import 'package:flutter/material.dart';

import '../../../../survey_kit.dart';
import '../../../model/content/audio_content.dart';
import '../../../util/ui_utils.dart';
import '../../../widget/link.dart';
import '../../../widget/survey_kit_audio_player.dart';

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
        if (audioContent.externalLink != null) ...[
          smallVerticalSpacer,
          LinkText(
            link: audioContent.externalLink!,
          ),
        ],
        if (audioContent.subtitle != null) ...[
          smallVerticalSpacer,
          SelectableText(
            audioContent.subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
        ],
      ],
    );
  }
}
