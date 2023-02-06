import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/configuration/survey_configuration.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/result/survey_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/navigable_task_navigator.dart';
import 'package:survey_kit/src/navigator/ordered_task_navigator.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/presenter/survey_presenter_inherited.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/task/navigable_task.dart';
import 'package:survey_kit/src/task/ordered_task.dart';
import 'package:survey_kit/src/task/task.dart';
import 'package:survey_kit/src/view/widget/answer/answer_view.dart';
import 'package:survey_kit/src/widget/survey_app_bar.dart';
import 'package:survey_kit/src/widget/survey_progress_configuration.dart';

typedef StepShell = Widget Function(
  Step step,
  Widget child,
  StepResult Function()? stepResult,
  bool isValid,
  SurveyController? surveyController,
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

  const SurveyKit({
    super.key,
    required this.task,
    required this.onResult,
    this.surveyController,
    this.surveyProgressbarConfiguration,
    this.appBar,
    this.localizations,
    this.stepShell,
  });

  @override
  _SurveyKitState createState() => _SurveyKitState();
}

class _SurveyKitState extends State<SurveyKit> {
  late TaskNavigator _taskNavigator;

  @override
  void initState() {
    super.initState();
    _taskNavigator = _createTaskNavigator();
  }

  TaskNavigator _createTaskNavigator() {
    switch (widget.task.runtimeType) {
      case OrderedTask:
        return OrderedTaskNavigator(widget.task);
      case NavigableTask:
        return NavigableTaskNavigator(widget.task);
      default:
        return OrderedTaskNavigator(widget.task);
    }
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
      child: SurveyPresenterInherited(
        taskNavigator: _taskNavigator,
        onResult: widget.onResult,
        stepShell: widget.stepShell,
        child: SurveyPage(
          length: widget.task.steps.length,
          onResult: widget.onResult,
          appBar: widget.appBar,
        ),
      ),
    );
  }
}

class SurveyPage extends StatefulWidget {
  final int length;
  final Function(SurveyResult) onResult;
  final PreferredSizeWidget? appBar;

  const SurveyPage({
    super.key,
    required this.length,
    required this.onResult,
    this.appBar,
  });

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: widget.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: SurveyPresenterInherited.of(context).surveyStateStream.stream,
      builder: (_, __) {
        final state = SurveyPresenterInherited.of(context).state;

        if (state is SurveyResultState) {
          Future<dynamic>.microtask(
            () => widget.onResult.call(state.result),
          );

          return const SizedBox.shrink();
        }
        if (state is PresentingSurveyState) {
          tabController.animateTo(state.currentStepIndex);
        }

        if (state is PresentingSurveyState) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: widget.appBar ?? const SurveyAppBar(),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: state.steps
                  .map(
                    (e) => _SurveyView(
                      id: e.id,
                      createView: () {
                        return AnswerView(
                          answer: e.answerFormat,
                          step: e,
                          stepResult: state.questionResults.firstWhereOrNull(
                            (element) => element.id == e.id,
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}

class _SurveyView extends StatelessWidget {
  const _SurveyView({required this.id, required this.createView});

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
