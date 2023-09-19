import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_kit/survey_kit.dart';

class SurveyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SurveyController? controller;

  const SurveyAppBar({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final surveyController =
        controller ?? SurveyConfiguration.of(context).surveyController;
    final state =
        Provider.of<SurveyStateProvider>(context, listen: false).state;

    final cancelButton = TextButton(
      child: Text(
        SurveyConfiguration.of(context).localizations?['cancel'] ?? 'Cancel',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () => surveyController.closeSurvey(
        context: context,
      ),
    );

    final backButton = BackButton(
      color: Colors.red,
      onPressed: () {
        surveyController.stepBack(
          context: context,
        );
      },
    );

    return AppBar(
      elevation: 0,
      leading:
          state?.isFirstStep ?? true ? const SizedBox.shrink() : backButton,
      title: const SurveyProgress(),
      actions: [
        cancelButton,
      ],
    );
  }

  @override
  Size get preferredSize => const Size(
        double.infinity,
        40,
      );
}
