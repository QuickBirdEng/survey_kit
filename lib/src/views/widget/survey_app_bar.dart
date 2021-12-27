import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:survey_kit/src/configuration/app_bar_configuration.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/widget/survey_progress.dart';
import 'package:provider/provider.dart';

class SurveyAppBar extends StatelessWidget {
  final AppBarConfiguration appBarConfiguration;
  final SurveyController? controller;

  const SurveyAppBar({
    required this.appBarConfiguration,
    this.controller,
  });

  @override
  PlatformAppBar build(BuildContext context) {
    final _showProgress =
        appBarConfiguration.showProgress ?? context.read<bool>();
    final _canGoBack = appBarConfiguration.canBack ?? true;

    final surveyController = controller ?? context.read<SurveyController>();
    return PlatformAppBar(
      leading: _canGoBack
          ? appBarConfiguration.leading ??
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  surveyController.stepBack(
                    context: context,
                  );
                },
              )
          : Container(),
      title: _showProgress ? SurveyProgress() : SizedBox.shrink(),
      trailingActions: [
        TextButton(
          child: appBarConfiguration.trailing ??
              Text(
                context.read<Map<String, String>?>()?['cancel'] ?? 'Cancel',
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
