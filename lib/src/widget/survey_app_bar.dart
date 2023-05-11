import 'package:flutter/material.dart';
import 'package:survey_kit/src/configuration/survey_configuration.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/presenter/survey_state_provider.dart';
import 'package:survey_kit/src/widget/survey_progress.dart';

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
    final surveyStream =
        SurveyStateProvider.of(context).surveyStateStream.stream;

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
      onPressed: () {
        surveyController.stepBack(
          context: context,
        );
      },
    );

    return AppBar(
      elevation: 0,
      leading: StreamBuilder<SurveyState>(
        stream: surveyStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }

          final state = snapshot.data!;

          return (state as PresentingSurveyState).isFirstStep
              ? const SizedBox.shrink()
              : backButton;
        },
      ),
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
