import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/integer_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_text_field.dart';

class IntegerAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const IntegerAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _IntegerAnswerViewState createState() => _IntegerAnswerViewState();
}

class _IntegerAnswerViewState extends State<IntegerAnswerView>
    with MeasureDateStateMixin, AnswerMixin<IntegerAnswerView, int> {
  late final IntegerAnswerFormat _integerAnswerFormat;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('IntegerAnswerFormat is null');
    }
    _integerAnswerFormat = answer as IntegerAnswerFormat;
    final initialValue =
        widget.result?.result as int? ?? _integerAnswerFormat.defaultValue;
    _controller = TextEditingController(text: initialValue?.toString() ?? '');
    initValidation(initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool isValid(int? value) {
    if (value == null) {
      return !widget.questionStep.isMandatory;
    }
    return value >= _integerAnswerFormat.min &&
        value <= _integerAnswerFormat.max;
  }

  @override
  Widget build(BuildContext context) {
    return AnswerTextField(
      questionText: _integerAnswerFormat.question,
      hint: _integerAnswerFormat.hint,
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      onChanged: (text) => onChange(int.tryParse(text.trim())),
    );
  }
}
