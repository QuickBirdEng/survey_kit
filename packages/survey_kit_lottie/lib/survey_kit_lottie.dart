library survey_kit_lottie;

import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_lottie/src/model/content/lottie_content.dart';
import 'package:survey_kit_lottie/src/view/widget/content/lottie_widget.dart';

export 'src/model/content/lottie_content.dart';
export 'src/view/widget/content/lottie_widget.dart';

class SurveyKitLottie implements SurveyKitPlugin {
  @override
  Map<Type, ContentWidgetBuilder> get contentWidgetBuilders => {
    LottieContent: (content) =>
        LottieWidget(lottieContent: content as LottieContent),
  };

  @override
  Map<Type, AnswerViewBuilder> get answerViewBuilders => {};
}
