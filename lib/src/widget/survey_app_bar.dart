import 'package:flutter/material.dart';
import 'package:survey_kit/src/configuration/survey_configuration.dart';
import 'package:survey_kit/src/survey_presenter_inherited.dart';
import 'package:survey_kit/survey_kit.dart';

class SurveyAppBar extends StatelessWidget {
  final SurveyController? controller;

  const SurveyAppBar({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final surveyController =
        controller ?? SurveyConfiguration.of(context).surveyController;
    final surveyPresenter = SurveyPresenterInherited.of(context);

    return AppBar(
      elevation: 0,
      leading: StreamBuilder<SurveyState>(
        stream: surveyPresenter.surveyStateStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }

          final state = snapshot.data!;

          return (state as PresentingSurveyState).isFirstStep
              ? const SizedBox.shrink()
              : BackButton(
                  onPressed: () {
                    surveyController.stepBack(
                      context: context,
                    );
                  },
                );
        },
      ),
      title: const SurveyProgress(),
      actions: [
        TextButton(
          child: Text(
            SurveyConfiguration.of(context).localizations?['cancel'] ??
                'Cancel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () => surveyController.closeSurvey(
            context: context,
          ),
        ),
      ],
    );
  }
}
