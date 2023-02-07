import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/time_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/result/time_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/step_view.dart';

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
    with MeasureDateStateMixin {
  late TimeAnswerFormat _timeAnswerFormat;
  late TimeResult? _result;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('TimeAnswerFormat is null');
    }
    _timeAnswerFormat = answer as TimeAnswerFormat;

    _result = widget.result?.result != null
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
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<TimeResult>(
        id: widget.questionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        valueIdentifier: _result.toString(),
        result: _result,
      ),
      isValid: !widget.questionStep.isMandatory || _result != null,
      child:
          // TODO(marvin): Create new time picker,
          _iosTimePicker(),
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
            _result = TimeResult(timeOfDay: TimeOfDay.fromDateTime(newTime));
          });
        },
      ),
    );
  }
}
