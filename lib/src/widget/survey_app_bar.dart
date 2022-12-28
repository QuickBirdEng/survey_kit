import 'package:flutter/material.dart';
import 'package:survey_kit/src/survey_configuration.dart';
import 'package:survey_kit/src/survey_presenter_inherited.dart';
import 'package:survey_kit/survey_kit.dart';

class SurveyAppBar extends StatelessWidget {
  final SurveyController? controller;

  const SurveyAppBar({
    super.key,
    this.controller,
  });

  @override
  AppBar build(BuildContext context) {
    final surveyController =
        controller ?? SurveyConfiguration.of(context).surveyController;
    final surveyState = SurveyPresenterInherited.of(context).state;
    final isFirstStep =
        surveyState is PresentingSurveyState && surveyState.isFirstStep;
    return AppBar(
      elevation: 0,
      leading: isFirstStep
          ? null
          : BackButton(
              onPressed: () {
                surveyController.stepBack(
                  context: context,
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
