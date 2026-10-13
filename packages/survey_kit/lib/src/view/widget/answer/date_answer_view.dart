import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/date_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';

class DateAnswerView extends StatefulWidget {
  /// [QuestionStep] which includes the [DateAnswerFormat]
  final Step questionStep;

  /// [DateQuestionResult] which boxes the result
  final StepResult? result;

  const DateAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _DateAnswerViewState createState() => _DateAnswerViewState();
}

class _DateAnswerViewState extends State<DateAnswerView>
    with MeasureDateStateMixin, AnswerMixin<DateAnswerView, DateTime> {
  late final DateAnswerFormat _dateAnswerFormat;
  late final DateTime _firstDate;
  late final DateTime _lastDate;
  late DateTime _result;

  @override
  void initState() {
    super.initState();
    _dateAnswerFormat = widget.questionStep.answerFormat! as DateAnswerFormat;
    _firstDate = _dateAnswerFormat.minDate ?? DateTime.utc(1900);
    _lastDate =
        _dateAnswerFormat.maxDate?.add(const Duration(hours: 1)) ??
        _latest(DateTime.now(), _firstDate).add(const Duration(hours: 1));
    final initialAnswer =
        widget.result?.result as DateTime? ?? _dateAnswerFormat.defaultDate;
    _result = _clampToRange(initialAnswer ?? DateTime.now());
    initValidation(initialAnswer == null ? null : _result);
  }

  DateTime _latest(DateTime a, DateTime b) => a.isAfter(b) ? a : b;

  DateTime _clampToRange(DateTime date) {
    if (date.isBefore(_firstDate)) {
      return _firstDate;
    }
    final upperBound = _dateAnswerFormat.maxDate ?? _lastDate;
    if (date.isAfter(upperBound)) {
      return upperBound;
    }
    return date;
  }

  @override
  bool isValid(DateTime? result) {
    return !widget.questionStep.isMandatory || result != null;
  }

  @override
  void onChange(DateTime? result) {
    if (result != null) {
      setState(() => _result = result);
    }
    super.onChange(result);
  }

  @override
  Widget build(BuildContext context) {
    final questionText = _dateAnswerFormat.question;
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return Column(
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        if (isIos) _iosDatePicker() else ..._materialDatePicker(context),
      ],
    );
  }

  List<Widget> _materialDatePicker(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: _SelectedDateHeader(date: _result),
      ),
      SizedBox(
        width: double.infinity,
        height: 300.0,
        child: CalendarDatePicker(
          firstDate: _firstDate,
          lastDate: _lastDate,
          initialDate: _result,
          onDateChanged: onChange,
        ),
      ),
    ];
  }

  Widget _iosDatePicker() {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        minimumDate: _dateAnswerFormat.minDate,
        maximumDate: _lastDate,
        initialDateTime: _result,
        onDateTimeChanged: onChange,
      ),
    );
  }
}

class _SelectedDateHeader extends StatelessWidget {
  const _SelectedDateHeader({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.primary,
      width: double.infinity,
      height: 80.0,
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        MaterialLocalizations.of(context).formatMediumDate(date),
        style: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(color: colorScheme.onPrimary),
      ),
    );
  }
}
