import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/integer_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/decoration/input_decoration.dart';

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
      throw Exception('ImageAnswerFormat is null');
    }
    _integerAnswerFormat = answer as IntegerAnswerFormat;
    _controller = TextEditingController();
    _controller.text = widget.result?.result?.toString() ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool isValid(int? value) {
    return value != null &&
        value >= _integerAnswerFormat.min &&
        value <= _integerAnswerFormat.max;
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          Container(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              textInputAction: TextInputAction.next,
              autofocus: true,
              decoration: textFieldInputDecoration(
                hint: _integerAnswerFormat.hint,
              ),
              controller: _controller,
              onChanged: (String text) {
                final number = int.tryParse(text);
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
