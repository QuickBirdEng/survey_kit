import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/text_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/decoration/input_decoration.dart';

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
    _controller = TextEditingController();
    _controller.text = widget.result?.result as String? ?? '';
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('TextAnswerFormat is null');
    }
    _textAnswerFormat = answer as TextAnswerFormat;
    isValid(_controller.text);
  }

  @override
  bool isValid(String? text) {
    if (text == null) {
      return false;
    }
    if (_textAnswerFormat.validationRegEx != null) {
      final regExp = RegExp(_textAnswerFormat.validationRegEx!);
      return regExp.hasMatch(text);
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;

    return Column(
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          child: TextField(
            textInputAction: TextInputAction.next,
            autofocus: true,
            decoration: textFieldInputDecoration(
              hint: _textAnswerFormat.hint,
            ),
            controller: _controller,
            textAlign: TextAlign.center,
            onChanged: onChange,
          ),
        ),
      ],
    );
  }
}
