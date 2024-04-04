import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;

import '../../../model/answer/time_answer_format.dart';
import '../../../model/result/step_result.dart';
import '../../../model/result/time_result.dart';
import '../../../model/step.dart';
import '../../../util/measure_date_state_mixin.dart';
import 'answer_mixin.dart';
import 'answer_question_text.dart';

class TimeAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const TimeAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _TimeAnswerViewState createState() => _TimeAnswerViewState();
}

class _TimeAnswerViewState extends State<TimeAnswerView>
    with MeasureDateStateMixin, AnswerMixin<TimeAnswerView, TimeResult> {
  late TimeAnswerFormat _timeAnswerFormat;

  late final TimeResult initialValue;

  @override
  bool isValid(TimeResult? result) {
    if (widget.questionStep.isMandatory) {
      return result != null;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('TimeAnswerFormat is null');
    }
    _timeAnswerFormat = answer as TimeAnswerFormat;

    initialValue = widget.result?.result != null
        ? widget.result?.result as TimeResult
        : _timeAnswerFormat.defaultValue != null
            ? TimeResult(
                timeOfDay: _timeAnswerFormat.defaultValue!,
              )
            : TimeResult(
                timeOfDay: TimeOfDay.fromDateTime(
                  DateTime.now(),
                ),
              );
  }

  @override
  void onChange(TimeResult? result) {
    setState(() {
      super.onChange(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;

    return
        // TODO(marvin): Create new time picker,
        Column(
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        _iosTimePicker(initialValue),
      ],
    );
  }

  Widget _iosTimePicker(TimeResult timeResult) {
    return Container(
      width: double.infinity,
      height: 450.0,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (time) => onChange(
          TimeResult(
            timeOfDay: TimeOfDay.fromDateTime(time),
          ),
        ),
      ),
    );
  }
}
