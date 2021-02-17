import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surveykit/src/presenter/survey_event.dart';
import 'package:surveykit/src/presenter/survey_presenter.dart';
import 'package:surveykit/src/result/question_result.dart';

class SurveyController {
  final QuestionResult Function() resultFunction;
  final BuildContext context;

  SurveyController({
    @required this.resultFunction,
    @required this.context,
  });

  void nextStep() {
    BlocProvider.of<SurveyPresenter>(context).add(
      NextStep(
        resultFunction.call(),
      ),
    );
  }

  void stepBack() {
    BlocProvider.of<SurveyPresenter>(context).add(
      StepBack(
        resultFunction.call(),
      ),
    );
  }

  void closeSurvey() {
    BlocProvider.of<SurveyPresenter>(context).add(
      CloseSurvey(
        resultFunction.call(),
      ),
    );
    Navigator.pop(context);
  }
}
