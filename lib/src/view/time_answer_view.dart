import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/time_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/content/content_widget.dart';
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
  late TimeOfDay? _result;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answer;
    if (answer == null) {
      throw Exception('TimeAnswerFormat is null');
    }
    _timeAnswerFormat = answer as TimeAnswerFormat;
    _result = widget.result?.result as TimeOfDay? ??
        _timeAnswerFormat.defaultValue ??
        TimeOfDay.fromDateTime(
          DateTime.now(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<TimeOfDay>(
        id: widget.questionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        valueIdentifier: _result.toString(),
        result: _result,
      ),
      isValid: !widget.questionStep.isMandatory || _result != null,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: ContentWidget(
              content: widget.questionStep.content,
            ),
          ),
          //TODO Create new time picker
          _iosTimePicker()
        ],
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
