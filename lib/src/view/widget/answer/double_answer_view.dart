import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/double_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/step_view.dart';
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
    with MeasureDateStateMixin {
  late final DoubleAnswerFormat _doubleAnswerFormat;
  late final TextEditingController _controller;

  bool _isValid = false;

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
    _checkValidation(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
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
      resultFunction: () => StepResult<double>(
        id: widget.questionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        valueIdentifier: _controller.text,
        result: double.tryParse(_controller.text) ??
            _doubleAnswerFormat.defaultValue,
      ),
      isValid: _isValid || !widget.questionStep.isMandatory,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            autofocus: true,
            decoration: textFieldInputDecoration(
              hint: _doubleAnswerFormat.hint,
            ),
            controller: _controller,
            onChanged: _checkValidation,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
