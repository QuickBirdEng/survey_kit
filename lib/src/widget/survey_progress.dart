import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_kit/src/presenter/survey_presenter.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/widget/survey_progress_configuration.dart';

class SurveyProgress extends StatelessWidget {
  const SurveyProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressbarConfiguration =
        context.read<SurveyProgressConfiguration>();
    return BlocBuilder<SurveyPresenter, SurveyState>(builder: (context, state) {
      if (state is PresentingSurveyState) {
        return Padding(
          padding: progressbarConfiguration.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              progressbarConfiguration.showLabel &&
                      progressbarConfiguration.label != null
                  ? progressbarConfiguration.label!(
                      state.currentStepIndex.toString(),
                      state.stepCount.toString())
                  : SizedBox.shrink(),
              ClipRRect(
                borderRadius: progressbarConfiguration.borderRadius ??
                    BorderRadius.circular(14.0),
                child: Container(
                  child: LinearProgressIndicator(
                    value: state.currentStepIndex / state.stepCount,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progressbarConfiguration.valueProgressbarColor ??
                          Theme.of(context).primaryColor,
                    ),
                    backgroundColor: progressbarConfiguration.backgroundColor,
                    color: progressbarConfiguration.progressbarColor,
                    minHeight: progressbarConfiguration.height,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return SizedBox.shrink();
    });
  }
}
