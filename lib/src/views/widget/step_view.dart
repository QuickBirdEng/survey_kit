import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/steps/step.dart' as surveystep;

class StepView extends StatelessWidget {
  final surveystep.Step step;
  final Widget title;
  final Widget child;
  final SurveyController controller;
  final bool canBack;
  final bool isValid;

  const StepView({
    @required this.step,
    @required this.child,
    @required this.title,
    @required this.controller,
    this.isValid = true,
    this.canBack = true,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: _androidAppBar(context),
        resizeToAvoidBottomInset: false,
        body: _content(context),
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: _iosAppBar(context),
        child: _content(context),
        resizeToAvoidBottomInset: false,
      );
    }
  }

  Widget _androidAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: canBack
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                controller.stepBack();
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
            onPressed: () {
              controller.closeSurvey();
            },
          ),
        ),
      ],
    );
  }

  Widget _iosAppBar(BuildContext context) {
    return CupertinoNavigationBar(
      leading: canBack
          ? CupertinoNavigationBarBackButton(
              color: Theme.of(context).primaryColor,
              previousPageTitle: 'Back',
              onPressed: () {
                controller.stepBack();
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
        onTap: () {
          controller.closeSurvey();
        },
      ),
    );
  }

  Widget _content(BuildContext context) {
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
                        ? () {
                            controller.nextStep();
                          }
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
