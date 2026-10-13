import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/time_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/result/time_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';

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
  late final TimeAnswerFormat _timeAnswerFormat;
  late final TimeResult _initialValue;

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

    final defaultTime = _timeAnswerFormat.defaultValue;
    _initialValue =
        widget.result?.result as TimeResult? ??
        TimeResult(timeOfDay: defaultTime ?? TimeOfDay.now());
    initValidation(_initialValue);
  }

  DateTime _initialDateTime() {
    final now = DateTime.now();
    final timeOfDay = _initialValue.timeOfDay;
    return DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionText = _timeAnswerFormat.question;

    return Column(
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        SizedBox(
          width: double.infinity,
          height: 450.0,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: _initialDateTime(),
            onDateTimeChanged: (time) =>
                onChange(TimeResult(timeOfDay: TimeOfDay.fromDateTime(time))),
          ),
        ),
      ],
    );
  }
}
