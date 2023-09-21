import 'package:flutter/widgets.dart';
import 'package:survey_kit/survey_kit.dart';

/// Needed to handle navigation when the survey-controller is not used
/// e.g. Swipe-Back-iOS
class SurveyRouteObserver extends RouteObserver<ModalRoute> {
  final SurveyStateProvider surveyStateProvider;

  SurveyRouteObserver(this.surveyStateProvider);

  @override
  void didPop(Route route, Route? previousRoute) {
    final state = surveyStateProvider.handleStepBack(
      StepBack(null),
      surveyStateProvider.state!,
    );
    surveyStateProvider.updateState(state);
    super.didPop(route, previousRoute);
  }
}
