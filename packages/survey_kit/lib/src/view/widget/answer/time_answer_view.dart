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
