import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/multi_double.dart';
import 'package:survey_kit/src/model/answer/multiple_double_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/answer/number_parsing.dart';

class MultipleDoubleAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const MultipleDoubleAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  State<MultipleDoubleAnswerView> createState() =>
      _MultipleDoubleAnswerViewState();
}

class _MultipleDoubleAnswerViewState extends State<MultipleDoubleAnswerView>
    with
        MeasureDateStateMixin,
        AnswerMixin<MultipleDoubleAnswerView, List<MultiDouble>> {
  late final MultipleDoubleAnswerFormat _multipleDoubleAnswer;
  late final List<TextEditingController> _controllers;
  late final List<double?> _values;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('MultipleDoubleAnswerFormat is null');
    }
    _multipleDoubleAnswer = answer as MultipleDoubleAnswerFormat;
    final initialValues =
        widget.result?.result as List<MultiDouble>? ??
        _multipleDoubleAnswer.defaultValues ??
        const [];
    _values = _multipleDoubleAnswer.hints.map((hint) {
      for (final initialValue in initialValues) {
        if (initialValue.text == hint) {
          return initialValue.value;
        }
      }
      return null;
    }).toList();
    _controllers = _values
        .map((value) => TextEditingController(text: value?.toString() ?? ''))
        .toList();
    initValidation(_currentResult());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<MultiDouble>? _currentResult() {
    if (_values.any((value) => value == null)) {
      return null;
    }
    return [
      for (var index = 0; index < _values.length; index++)
        MultiDouble(
          text: _multipleDoubleAnswer.hints[index],
          value: _values[index]!,
        ),
    ];
  }

  void _onValueChanged(int index, String text) {
    _values[index] = parseDecimal(text);
    onChange(_currentResult());
  }

  @override
  bool isValid(List<MultiDouble>? result) {
    return !widget.questionStep.isMandatory || result != null;
  }

  @override
  Widget build(BuildContext context) {
    final questionText = _multipleDoubleAnswer.question;
    final hints = _multipleDoubleAnswer.hints;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          const SizedBox(height: 12),
          for (var index = 0; index < hints.length; index++)
            TextField(
              textInputAction: index == hints.length - 1
                  ? TextInputAction.done
                  : TextInputAction.next,
              autofocus: index == 0,
              decoration: InputDecoration(labelText: hints[index]),
              controller: _controllers[index],
              onChanged: (text) => _onValueChanged(index, text),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
