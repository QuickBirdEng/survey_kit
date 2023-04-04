import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/multi_double.dart';
import 'package:survey_kit/src/model/answer/multiple_double_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/question_answer.dart';

class MultipleDoubleAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const MultipleDoubleAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  State<MultipleDoubleAnswerView> createState() =>
      _MultipleDoubleAnswerViewState();
}

class _MultipleDoubleAnswerViewState extends State<MultipleDoubleAnswerView>
    with
        MeasureDateStateMixin,
        AnswerMixin<MultipleDoubleAnswerView, List<MultiDouble>> {
  late final MultipleDoubleAnswerFormat _multipleDoubleAnswer;
  late final List<TextEditingController> _controller;

  List<MultiDouble> _insertedValues = [];

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('MultipleDoubleAnswerFormat is null');
    }
    _multipleDoubleAnswer = answer as MultipleDoubleAnswerFormat;
    _controller = _multipleDoubleAnswer.hints.map((e) {
      return TextEditingController();
    }).toList();

    _insertedValues = List.generate(
      _multipleDoubleAnswer.hints.length,
      (index) => const MultiDouble(
        text: '',
        value: 0.0,
      ),
    );
  }

  @override
  void dispose() {
    for (final element in _controller) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  bool isValid(List<MultiDouble>? result) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;
    final questionAnswer = QuestionAnswer.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          const Divider(
            color: Colors.grey,
          ),
          ..._multipleDoubleAnswer.hints
              .asMap()
              .entries
              .map((MapEntry<int, String> md) {
            return TextField(
              textInputAction: TextInputAction.next,
              autofocus: true,
              decoration: InputDecoration(
                labelText: md.value,
              ),
              controller: _controller[md.key],
              onChanged: (String value) {
                value = value.replaceAll(',', '.');
                if (double.tryParse(value) == null) {
                  questionAnswer.setIsValid(false);
                  return;
                }
                _insertedValues[md.key] = MultiDouble(
                  text: md.value,
                  value: double.parse(value),
                );
                onChange(_insertedValues);
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            );
          }).toList(),
        ],
      ),
    );
  }
}
