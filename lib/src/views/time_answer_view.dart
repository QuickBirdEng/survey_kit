import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surveykit/src/answer_format/time_answer_formart.dart';
import 'package:surveykit/src/controller/survey_controller.dart';
import 'package:surveykit/src/result/question/time_question_result.dart';
import 'package:surveykit/src/steps/predefined_steps/question_step.dart';
import 'package:surveykit/src/views/widget/time_picker.dart';
import 'package:surveykit/src/views/widget/step_view.dart';

class TimeAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final TimeQuestionResult result;

  const TimeAnswerView({Key key, this.questionStep, this.result})
      : super(key: key);

  @override
  _TimeAnswerViewState createState() => _TimeAnswerViewState();
}

class _TimeAnswerViewState extends State<TimeAnswerView> {
  final DateTime _startDate = DateTime.now();
  TimeAnswerFormat _timeAnswerFormat;
  TimeOfDay _result;

  @override
  void initState() {
    super.initState();
    _timeAnswerFormat = widget.questionStep.answerFormat as TimeAnswerFormat;
    _result = _timeAnswerFormat.defaultValue ??
        TimeOfDay.fromDateTime(
          DateTime.now(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      controller: SurveyController(
        context: context,
        resultFunction: () => TimeQuestionResult(
          id: widget.questionStep.id,
          startDate: _startDate,
          endDate: new DateTime.now(),
          valueIdentifier: _result.toString(),
          result: _result,
        ),
      ),
      title: Text(
        widget.questionStep.title,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Text(
              widget.questionStep.text,
              style: TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Platform.isAndroid ? _androidTimePicker() : _iosTimePicker(),
        ],
      ),
    );
  }

  Widget _androidTimePicker() {
    return Container(
      width: double.infinity,
      height: 400.0,
      child: TimePicker(
        initialTime: _result,
        timeChanged: (TimeOfDay time) {
          setState(() {
            _result = time;
          });
        },
      ),
    );
  }

  Widget _iosTimePicker() {
    return Container(
      width: double.infinity,
      height: 400.0,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (DateTime newTime) {
          setState(() {
            _result = TimeOfDay.fromDateTime(newTime);
          });
        },
      ),
    );
  }
}
