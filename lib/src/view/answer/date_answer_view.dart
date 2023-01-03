import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:intl/intl.dart';
import 'package:survey_kit/src/model/answer/date_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/content/content_widget.dart';
import 'package:survey_kit/src/view/step_view.dart';

class DateAnswerView extends StatefulWidget {
  /// [QuestionStep] which includes the [DateAnswerFormat]
  final Step questionStep;

  /// [DateQuestionResult] which boxes the result
  final StepResult<DateTime?>? result;

  const DateAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _DateAnswerViewState createState() => _DateAnswerViewState();
}

class _DateAnswerViewState extends State<DateAnswerView>
    with MeasureDateStateMixin {
  final DateFormat _dateFormat = DateFormat('E, MMM d');
  late DateAnswerFormat _dateAnswerFormat;
  DateTime? _result;

  @override
  void initState() {
    super.initState();
    _dateAnswerFormat = widget.questionStep.answerFormat! as DateAnswerFormat;
    _result = widget.result?.result ??
        _dateAnswerFormat.defaultDate ??
        DateTime.now();
  }

  void _handleDateChanged(DateTime date) {
    setState(() => _result = date);
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<DateTime>(
        id: widget.questionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        valueIdentifier: _result?.toIso8601String() ?? 'none',
        result: _result,
      ),
      isValid: !widget.questionStep.isMandatory || _result != null,
      child: Column(
        children: [
          ContentWidget(
            content: widget.questionStep.content,
          ),
          if (Theme.of(context).platform == TargetPlatform.iOS)
            _iosDatePicker()
          else
            _androidDatePicker(),
        ],
      ),
    );
  }

  Widget _androidDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                height: 80.0,
              ),
              Positioned(
                left: 8.0,
                bottom: 8.0,
                child: Text(
                  _dateFormat.format(_result!),
                  style: const TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 300.0,
          child: CalendarDatePicker(
            firstDate: _dateAnswerFormat.minDate ?? DateTime.utc(1900),
            lastDate: _dateAnswerFormat.maxDate?.add(
                  const Duration(hours: 1),
                ) ??
                DateTime.now().add(
                  const Duration(hours: 1),
                ),
            initialDate: _result ?? DateTime.now(),
            currentDate: _result,
            onDateChanged: _handleDateChanged,
          ),
        ),
      ],
    );
  }

  Widget _iosDatePicker() {
    return Container(
      width: double.infinity,
      height: 400.0,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        minimumDate: _dateAnswerFormat.minDate,
        //We have to add an hour to to met the assert maxDate > initDate
        maximumDate: _dateAnswerFormat.maxDate?.add(
              const Duration(hours: 1),
            ) ??
            DateTime.now().add(
              const Duration(hours: 1),
            ),
        initialDateTime: _dateAnswerFormat.defaultDate,
        onDateTimeChanged: (DateTime value) {
          setState(() {
            _result = value;
          });
        },
      ),
    );
  }
}
