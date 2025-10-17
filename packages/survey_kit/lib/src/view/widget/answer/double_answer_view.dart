import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/double_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/decoration/input_decoration.dart';

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
    _controller = TextEditingController();
    _controller.text = widget.result?.result?.toString() ?? '';

    isValid(
      double.tryParse(_controller.text),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool isValid(dynamic result) {
    return !widget.questionStep.isMandatory ||
        (result != null && double.tryParse(result as String) != null);
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          Container(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              autofocus: true,
              decoration: textFieldInputDecoration(
                hint: _doubleAnswerFormat.hint,
              ),
              controller: _controller,
              onChanged: (String text) {
                final number = double.tryParse(text);
                if (number == null) {
                  onValidationChanged = false;
                  return;
                }
                onChange(number);
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
