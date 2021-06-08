import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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
  final Task task;
  final ThemeData? themeData;
  final Function(SurveyResult) onResult;
  final SurveyController? surveyController;

  const SurveyKit({
    required this.task,
    required this.onResult,
    this.themeData,
    this.surveyController,
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
              value: widget.surveyController ?? SurveyController())
        ],
        child: BlocProvider(
          create: (BuildContext context) => SurveyPresenter(
            taskNavigator: _taskNavigator,
          ),
          child: BlocBuilder<SurveyPresenter, SurveyState>(
            builder: (BuildContext context, SurveyState state) {
              if (state is PresentingSurveyState) {
                return state.currentStep.createView(
                  questionResult: state.result,
                );
              }
              if (state is SurveyResultState) {
                widget.onResult.call(state.result);
                SchedulerBinding.instance?.addPostFrameCallback(
                  (_) {
                    Navigator.pop(context);
                  },
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
