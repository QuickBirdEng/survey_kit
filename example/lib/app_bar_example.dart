import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';

class AppBarExample extends StatelessWidget implements PreferredSizeWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final surveyController = SurveyConfiguration.of(context).surveyController;

    final cancelButton = IconButton(
      icon: const Icon(Icons.close),
      onPressed: () => surveyController.closeSurvey(
        context: context,
      ),
    );

    final backButton = BackButton(
      onPressed: () {
        surveyController.stepBack(
          context: context,
        );
      },
    );

    final state = SurveyStateProvider.of(context);

    final leading =
        state?.isFirstStep ?? true ? const SizedBox.shrink() : backButton;

    final title = Text(
      state?.currentStep?.id ?? '',
    );

    return AppBar(
      elevation: 0,
      leading: leading,
      title: title,
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
