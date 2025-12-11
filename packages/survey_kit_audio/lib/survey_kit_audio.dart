library survey_kit_audio;

import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/src/audio_content.dart';
import 'package:survey_kit_audio/src/audio_widget.dart';

export 'src/audio_content.dart';
export 'src/audio_widget.dart';

class SurveyKitAudio implements SurveyKitPlugin {
  @override
  Map<Type, ContentWidgetBuilder> get contentWidgetBuilders => {
        AudioContent: (content) =>
            AudioWidget(audioContent: content as AudioContent),
      };

  @override
  Map<Type, AnswerViewBuilder> get answerViewBuilders => {};
}
