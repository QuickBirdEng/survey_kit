import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_kit/src/presenter/survey_presenter.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/widget/survey_progress_configuration.dart';

class SurveyProgress extends StatefulWidget {
  const SurveyProgress({Key? key}) : super(key: key);

  @override
  State<SurveyProgress> createState() => _SurveyProgressState();
}

class _SurveyProgressState extends State<SurveyProgress> {
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
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: progressbarConfiguration.height,
                      color: progressbarConfiguration.progressbarColor,
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                          width: (state.currentStepIndex + 1) /
                              state.stepCount *
                              constraints.maxWidth,
                          height: progressbarConfiguration.height,
                          color:
                              progressbarConfiguration.valueProgressbarColor ??
                                  Theme.of(context).primaryColor,
                        );
                      },
                    ),
                  ],
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
