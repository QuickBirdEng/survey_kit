import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit/src/_new/view/answer_view.dart';
import 'package:survey_kit/src/configuration/app_bar_configuration.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/navigator/navigable_task_navigator.dart';
import 'package:survey_kit/src/navigator/ordered_task_navigator.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/result/survey/survey_result.dart';
import 'package:survey_kit/src/survey_configuration.dart';
import 'package:survey_kit/src/survey_presenter_inherited.dart';
import 'package:survey_kit/src/task/navigable_task.dart';
import 'package:survey_kit/src/task/ordered_task.dart';
import 'package:survey_kit/src/task/task.dart';
import 'package:survey_kit/src/views/widget/survey_app_bar.dart';
import 'package:survey_kit/src/widget/survey_progress_configuration.dart';

class SurveyKit extends StatefulWidget {
  /// [Task] for the configuraton of the survey
  final Task task;

  /// [ThemeData] to override the Theme of the subtree
  final ThemeData? themeData;

  /// Function which is called after the results are collected
  final Function(SurveyResult) onResult;

  /// [SurveyController] to override the navigation methods
  /// onNextStep, onBackStep, onCloseSurvey
  final SurveyController? surveyController;

  /// The appbar that is shown at the top
  final Widget Function(AppBarConfiguration appBarConfiguration)? appBar;

  /// If the progressbar shoud be show in the appbar
  final bool? showProgress;

  // Changes the styling of the progressbar in the appbar
  final SurveyProgressConfiguration? surveyProgressbarConfiguration;

  final Map<String, String>? localizations;

  const SurveyKit({
    super.key,
    required this.task,
    required this.onResult,
    this.themeData,
    this.surveyController,
    this.appBar,
    this.showProgress,
    this.surveyProgressbarConfiguration,
    this.localizations,
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
      showProgress: widget.showProgress ?? true,
      surveyProgressConfiguration: widget.surveyProgressbarConfiguration ??
          SurveyProgressConfiguration(),
      taskNavigator: _taskNavigator,
      surveyController: widget.surveyController ?? SurveyController(),
      localizations: widget.localizations,
      child: Theme(
        data: widget.themeData ?? Theme.of(context),
        child: SurveyPresenterInherited(
          taskNavigator: _taskNavigator,
          onResult: widget.onResult,
          child: SurveyPage(
            length: widget.task.steps.length,
            onResult: widget.onResult,
            appBar: widget.appBar,
          ),
        ),
      ),
    );
  }
}

class SurveyPage extends StatefulWidget {
  final int length;
  final Widget Function(AppBarConfiguration appBarConfiguration)? appBar;
  final Function(SurveyResult) onResult;

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
          widget.onResult.call(state.result);
        }
        if (state is PresentingSurveyState) {
          tabController.animateTo(state.currentStepIndex);
        }

        if (state is PresentingSurveyState) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const PreferredSize(
              preferredSize: Size(
                double.infinity,
                70.0,
              ),
              child: SurveyAppBar(),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: state.steps
                  .map(
                    (e) => _SurveyView(
                      id: e.id,
                      createView: () {
                        return AnswerView(
                          answer: e.answer!,
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
        } else if (state is SurveyResultState && state.currentStep != null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
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
