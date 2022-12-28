import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/text_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/content/content_widget.dart';
import 'package:survey_kit/src/view/decoration/input_decoration.dart';
import 'package:survey_kit/src/view/step_view.dart';

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
    with MeasureDateStateMixin {
  late final TextAnswerFormat _textAnswerFormat;

  late final TextEditingController _controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.result?.result as String? ?? '';
    final answer = widget.questionStep.answer;
    if (answer == null) {
      throw Exception('TextAnswerFormat is null');
    }
    _textAnswerFormat = answer as TextAnswerFormat;
    _checkValidation(_controller.text);
  }

  void _checkValidation(String text) {
    setState(() {
      if (_textAnswerFormat.validationRegEx != null) {
        final regExp = RegExp(_textAnswerFormat.validationRegEx!);
        _isValid = regExp.hasMatch(text);
      } else {
        _isValid = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<String>(
        id: widget.questionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        valueIdentifier: _controller.text,
        result: _controller.text,
      ),
      isValid: _isValid || !widget.questionStep.isMandatory,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 32.0, left: 14.0, right: 14.0),
            child: ContentWidget(
              content: widget.questionStep.content,
            ),
          ),
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
              onChanged: _checkValidation,
            ),
          ),
        ],
      ),
    );
  }
}
