import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/configuration/survey_configuration.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/model/result/survey_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/navigable_task_navigator.dart';
import 'package:survey_kit/src/navigator/ordered_task_navigator.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/presenter/survey_state_provider.dart';
import 'package:survey_kit/src/task/navigable_task.dart';
import 'package:survey_kit/src/task/ordered_task.dart';
import 'package:survey_kit/src/task/task.dart';
import 'package:survey_kit/src/view/widget/answer/answer_view.dart';
import 'package:survey_kit/src/widget/survey_app_bar.dart';
import 'package:survey_kit/src/widget/survey_kit_page_route_builder.dart';
import 'package:survey_kit/src/widget/survey_progress_configuration.dart';

typedef StepShell = Widget Function(
  Step step,
  Widget? answerWidget,
  BuildContext context,
);

class SurveyKit extends StatefulWidget {
  /// [Task] for the configuraton of the survey
  final Task task;

  /// Function which is called after the results are collected
  final Function(SurveyResult) onResult;

  /// [SurveyController] to override the navigation methods
  /// onNextStep, onBackStep, onCloseSurvey
  final SurveyController? surveyController;

  /// The appbar that is shown at the top
  final PreferredSizeWidget? appBar;

  // Changes the styling of the progressbar in the appbar
  final SurveyProgressConfiguration? surveyProgressbarConfiguration;

  /// Localizations for the survey
  final Map<String, String>? localizations;

  /// Step shell
  final StepShell? stepShell;

  /// Decoration which is applied to the survey container
  final BoxDecoration? decoration;

  const SurveyKit({
    super.key,
    required this.task,
    required this.onResult,
    this.surveyController,
    this.surveyProgressbarConfiguration,
    this.appBar,
    this.localizations,
    this.stepShell,
    this.decoration,
  });

  @override
  _SurveyKitState createState() => _SurveyKitState();
}

class _SurveyKitState extends State<SurveyKit> {
  late TaskNavigator _taskNavigator;
  late final GlobalKey<NavigatorState> _navigatorKey;

  @override
  void initState() {
    super.initState();
    _taskNavigator = _createTaskNavigator();
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  TaskNavigator _createTaskNavigator() {
    final task = widget.task;
    if (task is OrderedTask) {
      return OrderedTaskNavigator(widget.task);
    }
    if (task is NavigableTask) {
      return NavigableTaskNavigator(widget.task);
    }

    throw Exception('Task must be either OrderedTask or NavigableTask');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SurveyConfiguration(
      surveyProgressConfiguration: widget.surveyProgressbarConfiguration ??
          SurveyProgressConfiguration(),
      taskNavigator: _taskNavigator,
      surveyController: widget.surveyController ?? SurveyController(),
      localizations: widget.localizations,
      padding: const EdgeInsets.all(14),
      child: SurveyStateProvider(
        taskNavigator: _taskNavigator,
        onResult: widget.onResult,
        stepShell: widget.stepShell,
        navigatorKey: _navigatorKey,
        child: SurveyPage(
          length: widget.task.steps.length,
          onResult: widget.onResult,
          appBar: widget.appBar,
          navigatorKey: _navigatorKey,
          decoration: widget.decoration,
        ),
      ),
    );
  }
}

class SurveyPage extends StatefulWidget {
  final int length;
  final Function(SurveyResult) onResult;
  final PreferredSizeWidget? appBar;
  final GlobalKey<NavigatorState> navigatorKey;
  final Decoration? decoration;

  const SurveyPage({
    super.key,
    required this.length,
    required this.onResult,
    required this.navigatorKey,
    this.appBar,
    this.decoration,
  });

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => SurveyStateProvider.of(context).onEvent(
        StartSurvey(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ?? const SurveyAppBar(),
      body: Container(
        decoration: widget.decoration,
        child: Navigator(
          key: widget.navigatorKey,
          onGenerateRoute: (settings) => SurveyKitPageRouteBuilder<Widget>(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
            pageBuilder: (_, __, ___) {
              if (settings.arguments is! PresentingSurveyState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              final currentState = settings.arguments! as PresentingSurveyState;

              final step = currentState.currentStep;
              return _SurveyView(
                id: step.id,
                createView: () => AnswerView(
                  answer: step.answerFormat,
                  step: step,
                  stepResult: currentState.questionResults.firstWhereOrNull(
                    (element) => element.id == step.id,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SurveyView extends StatelessWidget {
  const _SurveyView({
    required this.id,
    required this.createView,
  });

  final String id;
  final Widget Function() createView;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey<String>(
        id,
      ),
      child: createView(),
    );
  }
}
