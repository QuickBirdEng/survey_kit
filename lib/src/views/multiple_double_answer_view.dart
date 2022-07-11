import 'package:flutter/material.dart';
import 'package:survey_kit/src/answer_format/multi_double.dart';
import 'package:survey_kit/src/answer_format/multiple_double_answer_format.dart';
import 'package:survey_kit/src/result/question/multiple_double_question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';

class MultipleDoubleAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final MultipleDoubleQuestionResult? result;

  const MultipleDoubleAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  State<MultipleDoubleAnswerView> createState() =>
      _MultipleDoubleAnswerViewState();
}

class _MultipleDoubleAnswerViewState extends State<MultipleDoubleAnswerView> {
  late final MultipleDoubleAnswerFormat _multipleDoubleAnswer;
  late final List<TextEditingController> _controller;
  late final DateTime _startDate;

  bool _isValid = false;
  List<MultiDouble> _insertedValues = [];

  @override
  void initState() {
    super.initState();
    _multipleDoubleAnswer =
        widget.questionStep.answerFormat as MultipleDoubleAnswerFormat;
    _controller = _multipleDoubleAnswer.multiDouble.map((e) {
      return TextEditingController(text: e.text);
    }).toList();

    _controller.forEach((element) {
      element = TextEditingController();
      element.text = widget.result?.result?.toString() ?? '';
      _checkValidation(element.text);
    });
    _startDate = DateTime.now();
  }

  @override
  void dispose() {
    _controller.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  void _checkValidation(String text) {
    setState(() {
      _isValid = text.isNotEmpty && double.tryParse(text) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => MultipleDoubleQuestionResult(
        id: widget.questionStep.stepIdentifier,
        startDate: _startDate,
        endDate: DateTime.now(),
        valueIdentifier: _controller.map((e) => e.value).join(''),
        result: _insertedValues,
      ),
      isValid: _isValid || widget.questionStep.isOptional,
      title: widget.questionStep.title.isNotEmpty
          ? Text(
              widget.questionStep.title,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            )
          : widget.questionStep.content,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
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
            Column(
              children: [
                Divider(
                  color: Colors.grey,
                ),
                ..._multipleDoubleAnswer.multiDouble.map((MultiDouble md) {
                  return TextField(
                    decoration: InputDecoration(
                      labelText: md.text + ' R\$: ',
                    ),
                    controller: _controller.firstWhere(
                      (e) => e.text == md.text,
                    ),
                    // onChanged: (String value) {
                    //   _checkValidation(value);
                    // },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  );
                }).toList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
