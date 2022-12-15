import 'package:flutter/material.dart';
import 'package:survey_kit/src/configuration/app_bar_configuration.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/survey_configuration.dart';
import 'package:survey_kit/src/widget/survey_progress.dart';

class SurveyAppBar extends StatelessWidget {
  final AppBarConfiguration appBarConfiguration;
  final SurveyController? controller;

  const SurveyAppBar({
    super.key,
    required this.appBarConfiguration,
    this.controller,
  });

  @override
  AppBar build(BuildContext context) {
    final _showProgress = appBarConfiguration.showProgress ??
        SurveyConfiguration.of(context).showProgress;
    final _canGoBack = appBarConfiguration.canBack ?? true;

    final surveyController =
        controller ?? SurveyConfiguration.of(context).surveyController;
    return AppBar(
      elevation: 0,
      leading: _canGoBack
          ? appBarConfiguration.leading ??
              BackButton(
                onPressed: () {
                  surveyController.stepBack(
                    context: context,
                  );
                },
              )
          : Container(),
      title: _showProgress ? const SurveyProgress() : const SizedBox.shrink(),
      actions: [
        TextButton(
          child: appBarConfiguration.trailing ??
              Text(
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
