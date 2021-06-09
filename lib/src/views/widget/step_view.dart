import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/steps/step.dart' as surveystep;
import 'package:survey_kit/survey_kit.dart';
import 'package:provider/provider.dart';

class StepView extends StatelessWidget {
  final surveystep.Step step;
  final Widget title;
  final Widget child;
  final QuestionResult Function() resultFunction;
  final bool canBack;
  final bool isValid;
  final SurveyController? controller;

  const StepView({
    required this.step,
    required this.child,
    required this.title,
    required this.resultFunction,
    this.controller,
    this.isValid = true,
    this.canBack = true,
  });

  @override
  Widget build(BuildContext context) {
    final surveyController = controller ?? context.read<SurveyController>();
    return PlatformScaffold(
      material: (context, platform) => MaterialScaffoldData(
        appBar: _androidAppBar(surveyController, context),
        resizeToAvoidBottomInset: false,
        body: _content(surveyController, context),
      ),
      cupertino: (context, platform) => CupertinoPageScaffoldData(
        navigationBar: _iosAppBar(surveyController, context),
        body: _content(surveyController, context),
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

  Widget _content(SurveyController surveyController, BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: title,
                ),
                child,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: OutlinedButton(
                    onPressed: isValid
                        ? () =>
                            surveyController.nextStep(context, resultFunction)
                        : null,
                    child: Text(
                      step.buttonText.toUpperCase(),
                      style: TextStyle(
                        color: isValid
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
