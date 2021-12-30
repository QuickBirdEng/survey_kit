import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:survey_kit/src/answer_format/date_answer_format.dart';
import 'package:survey_kit/src/result/question/date_question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';

class DateAnswerView extends StatefulWidget {
  /// [QuestionStep] which includes the [DateAnswerFormat]
  final QuestionStep questionStep;

  /// [DateQuestionResult] which boxes the result
  final DateQuestionResult? result;

  const DateAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _DateAnswerViewState createState() => _DateAnswerViewState();
}

class _DateAnswerViewState extends State<DateAnswerView> {
  final DateFormat _dateFormat = DateFormat('E, MMM d');
  final DateTime _startDate = DateTime.now();
  late DateAnswerFormat _dateAnswerFormat;
  DateTime? _result;

  @override
  void initState() {
    super.initState();
    _dateAnswerFormat = widget.questionStep.answerFormat as DateAnswerFormat;
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
      resultFunction: () => DateQuestionResult(
        id: widget.questionStep.stepIdentifier,
        startDate: _startDate,
        endDate: DateTime.now(),
        valueIdentifier: _result?.toIso8601String() ?? 'none',
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
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Text(
              widget.questionStep.text,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          PlatformWidget(
            material: (_, __) => _androidDatePicker(),
            cupertino: (context, platform) => _iosDatePicker(),
          ),
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
                  style: TextStyle(
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
                  Duration(hours: 1),
                ) ??
                DateTime.now().add(
                  Duration(hours: 1),
                ),
            initialDate: _result ?? DateTime.now(),
            currentDate: _result,
            onDateChanged: (DateTime value) => _handleDateChanged(value),
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
              Duration(hours: 1),
            ) ??
            DateTime.now().add(
              Duration(hours: 1),
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
