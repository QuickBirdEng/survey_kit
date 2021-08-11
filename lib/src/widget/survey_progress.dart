import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_kit/src/presenter/survey_presenter.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';

class SurveyProgress extends StatelessWidget {
  const SurveyProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyPresenter, SurveyState>(builder: (context, state) {
      if (state is PresentingSurveyState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: LinearProgressIndicator(
            value: state.currentStepIndex / state.stepCount,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            color: Colors.white,
            minHeight: 6.0,
          ),
        );
      }
      return SizedBox.shrink();
    });
  }
}
