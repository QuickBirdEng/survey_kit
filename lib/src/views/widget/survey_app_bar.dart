import 'package:flutter/material.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/survey_configuration.dart';
import 'package:survey_kit/src/widget/survey_progress.dart';

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
    return AppBar(
      elevation: 0,
      leading: BackButton(
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
