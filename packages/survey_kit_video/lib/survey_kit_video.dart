library survery_kit_video;

import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_video/src/video_content.dart';
import 'package:survey_kit_video/src/video_widget.dart';

export 'src/survey_kit_video_player.dart';
export 'src/video_content.dart';
export 'src/video_widget.dart';
export 'src/web_video_player.dart';

class SurveyKitVideo implements SurveyKitPlugin {
  @override
  Map<Type, ContentWidgetBuilder> get contentWidgetBuilders => {
        VideoContent: (content) =>
            VideoWidget(videoContent: content as VideoContent),
      };

  @override
  Map<Type, AnswerViewBuilder> get answerViewBuilders => {};
}
