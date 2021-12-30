import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:survey_kit/src/answer_format/time_answer_formart.dart';
import 'package:survey_kit/src/result/question/time_question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';
import 'package:survey_kit/src/views/widget/time_picker_widget.dart'
    as surveywidget;

class TimeAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final TimeQuestionResult? result;

  const TimeAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _TimeAnswerViewState createState() => _TimeAnswerViewState();
}

class _TimeAnswerViewState extends State<TimeAnswerView> {
  final DateTime _startDate = DateTime.now();
  late TimeAnswerFormat _timeAnswerFormat;
  late TimeOfDay? _result;

  @override
  void initState() {
    super.initState();
    _timeAnswerFormat = widget.questionStep.answerFormat as TimeAnswerFormat;
    _result = widget.result?.result ??
        _timeAnswerFormat.defaultValue ??
        TimeOfDay.fromDateTime(
          DateTime.now(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => TimeQuestionResult(
        id: widget.questionStep.stepIdentifier,
        startDate: _startDate,
        endDate: DateTime.now(),
        valueIdentifier: _result.toString(),
        result: _result,
      ),
      isValid: widget.questionStep.isOptional || _result != null,
      title: widget.questionStep.title.isNotEmpty
          ? Text(
              widget.questionStep.title,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            )
          : widget.questionStep.content,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Text(
              widget.questionStep.text,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          PlatformWidget(
            material: (_, __) => _androidTimePicker(),
            cupertino: (context, platform) => _iosTimePicker(),
          ),
        ],
      ),
    );
  }

  Widget _androidTimePicker() {
    return Container(
      width: double.infinity,
      height: 450.0,
      child: surveywidget.TimePickerWidget(
        initialTime: _result ??
            TimeOfDay.fromDateTime(
              DateTime.now(),
            ),
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
      height: 450.0,
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
