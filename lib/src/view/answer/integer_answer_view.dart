import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/integer_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/content/content_widget.dart';
import 'package:survey_kit/src/view/decoration/input_decoration.dart';
import 'package:survey_kit/src/view/step_view.dart';

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
    with MeasureDateStateMixin {
  late final IntegerAnswerFormat _integerAnswerFormat;
  late final TextEditingController _controller;

  bool _isValid = false;

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
    _checkValidation(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkValidation(String text) {
    setState(() {
      final value = int.tryParse(text);
      _isValid = text.isNotEmpty &&
          value != null &&
          value >= _integerAnswerFormat.min &&
          value <= _integerAnswerFormat.max;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<int>(
        id: widget.questionStep.id,
        startTime: startDate,
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
