import 'package:flutter/material.dart';
import 'package:survey_kit/src/answer_format/file_answer_format.dart';
import 'package:survey_kit/src/result/question/file_question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/decoration/input_decoration.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';

class FileAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final FileQuestionResult? result;

  const FileAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  State<FileAnswerView> createState() => _FileAnswerViewState();
}

class _FileAnswerViewState extends State<FileAnswerView> {
  late final FileAnswerFormat _fileAnswerFormat;
  late final TextEditingController _controller;
  late final DateTime _startDate;

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _fileAnswerFormat = widget.questionStep.answerFormat as FileAnswerFormat;

    _controller = TextEditingController();
    _controller.text = widget.result?.result?.toString() ?? '';

    _startDate = DateTime.now();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkValidation(String text) {
    setState(() {
      _isValid = text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => FileQuestionResult(
        id: widget.questionStep.stepIdentifier,
        startDate: _startDate,
        endDate: DateTime.now(),
        valueIdentifier: _controller.text,
        result: _controller.text,
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
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            decoration: textFieldInputDecoration(
              hint: _fileAnswerFormat.hint,
            ),
            controller: _controller,
            onChanged: (String value) {
              _checkValidation(value);
            },
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
