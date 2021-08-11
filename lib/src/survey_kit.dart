import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/navigator/navigable_task_navigator.dart';
import 'package:survey_kit/src/navigator/ordered_task_navigator.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/presenter/survey_presenter.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/result/survey/survey_result.dart';
import 'package:survey_kit/src/task/navigable_task.dart';
import 'package:survey_kit/src/task/ordered_task.dart';
import 'package:survey_kit/src/task/task.dart';

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

  final bool showProgress;

  const SurveyKit({
    required this.task,
    required this.onResult,
    this.themeData,
    this.surveyController,
    this.showProgress = true,
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
  Widget build(BuildContext context) {
    return Theme(
      data: widget.themeData ?? Theme.of(context),
      child: MultiProvider(
        providers: [
          Provider<TaskNavigator>.value(value: _taskNavigator),
          Provider<SurveyController>.value(
              value: widget.surveyController ?? SurveyController()),
          Provider<bool>.value(value: widget.showProgress),
        ],
        child: BlocProvider(
          create: (BuildContext context) => SurveyPresenter(
            taskNavigator: _taskNavigator,
          ),
          child: BlocConsumer<SurveyPresenter, SurveyState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) async {
              if (state is SurveyResultState) {
                widget.onResult.call(state.result);
                Navigator.of(context).pop();
              }
            },
            builder: (BuildContext context, SurveyState state) {
              if (state is PresentingSurveyState) {
                return state.currentStep.createView(
                  questionResult: state.result,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
