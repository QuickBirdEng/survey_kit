import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/_new/model/answer/integer_answer_format.dart';
import 'package:survey_kit/src/_new/model/result/step_result.dart';
import 'package:survey_kit/src/_new/model/step.dart';
import 'package:survey_kit/src/_new/view/content/content_widget.dart';
import 'package:survey_kit/src/_new/view/decoration/input_decoration.dart';
import 'package:survey_kit/src/_new/view/step_view.dart';

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

class _IntegerAnswerViewState extends State<IntegerAnswerView> {
  late final IntegerAnswerFormat _integerAnswerFormat;
  late final TextEditingController _controller;
  late final DateTime _startDate;

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _integerAnswerFormat = widget.questionStep.answer as IntegerAnswerFormat;
    _controller = TextEditingController();
    _controller.text = widget.result?.result?.toString() ?? '';
    _checkValidation(_controller.text);
    _startDate = DateTime.now();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkValidation(String text) {
    setState(() {
      _isValid = text.isNotEmpty && int.tryParse(text) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<int>(
        id: widget.questionStep.id,
        startTime: _startDate,
        endTime: DateTime.now(),
        valueIdentifier: _controller.text,
        result:
            int.tryParse(_controller.text) ?? _integerAnswerFormat.defaultValue,
      ),
      isValid: _isValid || !widget.questionStep.isMandatory,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ContentWidget(
                content: widget.questionStep.content,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                autofocus: true,
                decoration: textFieldInputDecoration(
                  hint: _integerAnswerFormat.hint,
                ),
                controller: _controller,
                onChanged: _checkValidation,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
