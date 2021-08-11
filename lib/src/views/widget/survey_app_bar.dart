import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/widget/survey_progress.dart';
import 'package:provider/provider.dart';

class SurveyAppBar extends StatelessWidget {
  final QuestionResult Function() resultFunction;
  final bool canBack;
  final bool showProgress;
  final SurveyController? controller;
  final Widget content;

  const SurveyAppBar({
    required this.resultFunction,
    required this.content,
    this.showProgress = true,
    this.controller,
    this.canBack = true,
  });

  @override
  Widget build(BuildContext context) {
    final surveyController = controller ?? context.read<SurveyController>();
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: canBack
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  surveyController.stepBack(context, resultFunction);
                },
              )
            : Container(),
        trailingActions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () =>
                  surveyController.closeSurvey(context, resultFunction),
            ),
          ),
        ],
      ),
      material: (context, platform) => MaterialScaffoldData(
        appBar: _androidAppBar(surveyController, context),
        resizeToAvoidBottomInset: false,
        body: content,
      ),
      cupertino: (context, platform) => CupertinoPageScaffoldData(
        navigationBar: _iosAppBar(surveyController, context),
        body: content,
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  AppBar _androidAppBar(
      SurveyController surveyController, BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: canBack
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                surveyController.stepBack(context, resultFunction);
              },
            )
          : Container(),
      title: showProgress ? SurveyProgress() : SizedBox.shrink(),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () =>
                surveyController.closeSurvey(context, resultFunction),
          ),
        ),
      ],
    );
  }

  CupertinoNavigationBar _iosAppBar(
      SurveyController surveyController, BuildContext context) {
    return CupertinoNavigationBar(
      leading: canBack
          ? CupertinoNavigationBarBackButton(
              color: Theme.of(context).primaryColor,
              previousPageTitle: 'Back',
              onPressed: () {
                surveyController.stepBack(context, resultFunction);
              },
            )
          : Container(),
      middle: showProgress ? SurveyProgress() : SizedBox.shrink(),
      trailing: GestureDetector(
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        onTap: () => surveyController.closeSurvey(context, resultFunction),
      ),
    );
  }
}
