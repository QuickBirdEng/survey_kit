import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/double_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_text_field.dart';
import 'package:survey_kit/src/view/widget/answer/number_parsing.dart';

class DoubleAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const DoubleAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _DoubleAnswerViewState createState() => _DoubleAnswerViewState();
}

class _DoubleAnswerViewState extends State<DoubleAnswerView>
    with MeasureDateStateMixin, AnswerMixin<DoubleAnswerView, double> {
  late final DoubleAnswerFormat _doubleAnswerFormat;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('DoubleAnswerFormat is null');
    }
    _doubleAnswerFormat = answer as DoubleAnswerFormat;
    final initialValue =
        (widget.result?.result as num?)?.toDouble() ??
        _doubleAnswerFormat.defaultValue;
    _controller = TextEditingController(text: initialValue?.toString() ?? '');
    initValidation(initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool isValid(double? result) {
    return !widget.questionStep.isMandatory || result != null;
  }

  @override
  Widget build(BuildContext context) {
    return AnswerTextField(
      questionText: _doubleAnswerFormat.question,
      hint: _doubleAnswerFormat.hint,
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      textInputAction: TextInputAction.done,
      onChanged: (text) => onChange(parseDecimal(text)),
    );
  }
}
