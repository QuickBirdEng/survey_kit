import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/text_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_text_field.dart';

class TextAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const TextAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _TextAnswerViewState createState() => _TextAnswerViewState();
}

class _TextAnswerViewState extends State<TextAnswerView>
    with MeasureDateStateMixin, AnswerMixin<TextAnswerView, String> {
  late final TextAnswerFormat _textAnswerFormat;

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('TextAnswerFormat is null');
    }
    _textAnswerFormat = answer as TextAnswerFormat;
    _controller = TextEditingController(
      text: widget.result?.result as String? ?? '',
    );
    initValidation(_controller.text);
  }

  @override
  bool isValid(String? text) {
    if (text == null || text.trim().isEmpty) {
      return !widget.questionStep.isMandatory;
    }
    final validationRegEx = _textAnswerFormat.validationRegEx;
    return validationRegEx == null || RegExp(validationRegEx).hasMatch(text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnswerTextField(
      questionText: _textAnswerFormat.question,
      hint: _textAnswerFormat.hint,
      controller: _controller,
      maxLines: _textAnswerFormat.maxLines ?? 1,
      padding: EdgeInsets.zero,
      onChanged: onChange,
    );
  }
}
